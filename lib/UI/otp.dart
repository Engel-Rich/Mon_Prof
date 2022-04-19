import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:monprof/UI/home.dart';
import 'package:monprof/firebase/auth_service.dart';
import 'package:monprof/firebase/firebase.dart';
import 'package:monprof/models/user.dart';
import 'package:pinput/pin_put/pin_put.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OTPScreen extends StatefulWidget {
  OTPScreen({
    Key? key,
    this.classe,
    this.numero,
    this.nom,
    this.ecole,
    this.password,
  }) : super(key: key);
  final String? classe;
  final String? numero;
  final String? nom;
  final String? ecole;
  final String? password;
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> with TickerProviderStateMixin {
  final formGlobalKey = GlobalKey<FormState>();
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );
  void _showSnackBar(String pin) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Container(
        height: 80.0,
        child: Center(
          child: Text(
            'Pin Submitted. Value: $pin',
            style: const TextStyle(fontSize: 25.0),
          ),
        ),
      ),
      backgroundColor: Colors.deepPurpleAccent,
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  AuthService authservice = AuthService();
  String? verificationCode;
  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  bool isloading = false;
  AnimationController? animationcontroller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifyPhoneNumber();
    animationcontroller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationcontroller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey,
      body: Form(
        key: formGlobalKey,
        child: ListView(primary: true, children: [
          Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                  side: BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          bottom: 12,
                          top: 15,
                        ),
                        child: Container(
                          height: 72,
                          width: 141,
                          child: Image.asset(
                            "assets/philo.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const Center(
                        child: Text(
                          "Un code de confirmation a été envoyer au numéro de",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: Text(
                            "Téléphone : +237" + widget.numero!,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: isloading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                ),
                              )
                            : PinPut(
                                fieldsCount: 6,
                                withCursor: true,
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                                eachFieldWidth: 10.0,
                                eachFieldHeight: 10.0,
                                //onSubmit: (String pin) => _showSnackBar(pin),
                                focusNode: _pinPutFocusNode,
                                controller: _pinPutController,
                                submittedFieldDecoration: pinPutDecoration,
                                selectedFieldDecoration: pinPutDecoration,
                                followingFieldDecoration: pinPutDecoration,

                                onSubmit: (String pin) async {
                                  try {
                                    setState(() {
                                      isloading = true;
                                    });
                                    await FirebaseAuth.instance
                                        .signInWithCredential(
                                            PhoneAuthProvider.credential(
                                                verificationId:
                                                    verificationCode!,
                                                smsCode: pin))
                                        .then((value) async {
                                      if (value.user != null) {
                                        Logger().d('pass to home');

                                        await DBservice().saveUser(UserModel(
                                          classe: widget.classe,
                                          numero: widget.numero,
                                          nom: widget.nom,
                                          ecole: widget.ecole,
                                          password: widget.password,
                                        ));

                                        setState(() {
                                          isloading = false;
                                        });
                                        Fluttertoast.showToast(
                                            msg: "Compte crée avec succès",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 4,
                                            backgroundColor: Colors.blue,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Home()),
                                            (route) => false);
                                      }
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'weak-password') {
                                      Logger().d(
                                          'The password provided is too weak.');
                                    } else if (e.code ==
                                        'email-already-in-use') {
                                      Logger().d(
                                          'The account already exists for that email.');
                                    }
                                  } catch (e) {
                                    setState(() {
                                      isloading = false;
                                    });
                                    FocusScope.of(context).unfocus();
                                    Fluttertoast.showToast(
                                        msg: "Code OTP invalide",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 4,
                                        backgroundColor: Colors.grey,
                                        textColor: Colors.white,
                                        fontSize: 16.0);

                                    /*   scaffoldkey.currentState!.showSnackBar(
                                        SnackBar(content: Text("invalid OTP")));*/
                                  }
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ))
        ]),
      ),
    ));
  }

  verifyPhoneNumber() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: "+237${widget.numero}",
          verificationCompleted: (PhoneAuthCredential credential) async {
            //quand tout c'est bien passé
            Logger().d("on complete method");
            try {
              await FirebaseAuth.instance
                  .signInWithCredential(credential)
                  .then((value) async {
                if (value.user != null) {
                  Logger().d("user logged in");
                  print('save user');
                }
              });
            } catch (e) {
              Logger().d(e);
            }
          },
          verificationFailed: (FirebaseAuthException e) {
            Logger().d(e.message);
            if (e.code == 'invalid-phone-number') {
              Logger().d('The provided phone number is not valid.');
              Fluttertoast.showToast(
                  msg: "Numéro de téléphone invalide",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 4,
                  backgroundColor: Colors.grey,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          },
          codeSent: (String verificationID, int? resendToken) {
            if (mounted) {
              setState(() {
                verificationCode = verificationID;
              });
            }
          },
          codeAutoRetrievalTimeout: (String verificationID) {
            if (mounted) {
              setState(() {
                verificationCode = verificationID;
              });
            }
          },
          timeout: Duration(seconds: 120));
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Une erreur est survenue",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
