import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:monprof/UI/splashscreen.dart';
import 'package:monprof/models/eleve.dart';
import 'package:monprof/studies/allcoursforclass.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'inscription.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
// variables
  TextEditingController numero = TextEditingController();
  TextEditingController password = TextEditingController();
  String requestError = '';

  final formGlobalKey = GlobalKey<FormState>();
  Future<List<String>> listclasse() async {
    var list = <String>[];
    var response = await get(
        Uri.parse('https://kedycours.000webhostapp.com/getelms/courslist.php'));
    if (response.statusCode == 200) {
      for (var classe in jsonDecode(response.body)) {
        list.add(classe['nom']);
      }
    } else {
      list.add(response.statusCode.toString());
    }
    return list;
  }

  String? selectedClasse;
  bool visible = true;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? const SplashScreen()
        : Scaffold(
            backgroundColor: Colors.white10.withOpacity(0.9),
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Center(
                child: Text(
                  'Connexion',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            body: Form(
              key: formGlobalKey,
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(20),
                        elevation: 3.0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 1,
                              color: Colors.blue,
                            ),
                          ),
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(30),
                                  child: Image.asset('assets/book.png')),
                              TextFormField(
                                controller: numero,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "entrer votre numero";
                                  } else if (value.trim().length < 9) {
                                    return "numéro incorrecte";
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    fillColor: Colors.grey.withOpacity(0.3),
                                    filled: true,
                                    hintText: "entrez votre identifiant",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    prefixIcon: const IconButton(
                                      onPressed: null,
                                      icon: CircleAvatar(
                                          child: Icon(Icons.phone)),
                                    )),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                child: FutureBuilder<List<String>>(
                                    future: listclasse(),
                                    builder: (context, snapshot) {
                                      return !snapshot.hasData
                                          ? Shimmer.fromColors(
                                              period: const Duration(
                                                  milliseconds: 500),
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.all(0.0),
                                                height: 50,
                                                color: Colors.grey,
                                                width: double.infinity,
                                                child: const Center(
                                                  child: Text(
                                                      'selectionner la classe'),
                                                ),
                                              ),
                                              baseColor: Colors.grey.shade400,
                                              highlightColor:
                                                  Colors.grey.shade200,
                                            )
                                          : DropdownButtonFormField(
                                              value: selectedClasse,
                                              icon: const Icon(
                                                  Icons.keyboard_arrow_down),
                                              hint: const Text('Select Classe'),
                                              items: snapshot.data
                                                  ?.map<
                                                      DropdownMenuItem<String>>(
                                                    (String value) =>
                                                        DropdownMenuItem(
                                                      value: value,
                                                      child: Text(value),
                                                    ),
                                                  )
                                                  .toList(),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  selectedClasse = value!;
                                                });
                                              });
                                    }),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: password,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "entrer votre mots de passe";
                                  } else if (value.trim().length < 8) {
                                    return "mots de passe doit avoir au moins 8 caracteres";
                                  } else {
                                    return null;
                                  }
                                },
                                obscureText: visible,
                                decoration: InputDecoration(
                                  fillColor: Colors.grey.withOpacity(0.3),
                                  filled: true,
                                  hintText: "mots de passe",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  prefixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        visible = !visible;
                                      });
                                    },
                                    icon: visible
                                        ? const CircleAvatar(
                                            child: Icon(Icons.lock))
                                        : const CircleAvatar(
                                            child: Icon(Icons.lock_open)),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        visible = !visible;
                                      });
                                    },
                                    icon: visible
                                        ? const CircleAvatar(
                                            child: Icon(Icons.visibility_off))
                                        : const CircleAvatar(
                                            child: Icon(Icons.visibility)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "mots de passe oublier?",
                                style: TextStyle(color: Colors.blue),
                              ),
                              SizedBox(
                                  height: 30,
                                  child: Center(
                                    child: Text(
                                      requestError,
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  )),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 50,
                                margin: const EdgeInsets.all(15),
                                child: TextButton(
                                  onPressed: () async {
                                    if (formGlobalKey.currentState!
                                        .validate()) {
                                      Eleve eleve = Eleve(
                                          classe: selectedClasse ?? 'no classe',
                                          matricule: numero.text,
                                          password: password.text);
                                      if (eleve.classe == "no classe") {
                                        Fluttertoast.showToast(
                                            fontSize: 18,
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.TOP,
                                            msg: 'veiller choisir la classe');
                                      } else {
                                        try {
                                          setState(() {
                                            loading = !loading;
                                          });
                                          var result = await eleve.login();
                                          print(result);
                                          if (result['valeur'] == true) {
                                            Eleve.saveEleve(eleve);
                                            Timer(
                                              const Duration(
                                                  milliseconds: 2000),
                                              () => Navigator.push(
                                                context,
                                                PageTransition(
                                                  child: AllCoursForClasse(
                                                      eleve: eleve),
                                                  type: PageTransitionType
                                                      .bottomToTop,
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                ),
                                              ),
                                            );
                                            Timer(const Duration(seconds: 5),
                                                () {
                                              setState(() {
                                                requestError = '';
                                                loading = !loading;
                                              });
                                            });
                                          } else {
                                            Timer(
                                              const Duration(
                                                  milliseconds: 4250),
                                              () => setState(() {
                                                loading = !loading;
                                                requestError =
                                                    "matricule ou mot de passe incorrecte ";
                                              }),
                                            );
                                          }
                                        } catch (e) {
                                          print(e);
                                        }
                                      }
                                    } else {
                                      return;
                                    }
                                  },
                                  child: const Text(
                                    "Connexion",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    backgroundColor: Colors.blue,
                                    elevation: 3,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              // ignore: prefer_const_literals_to_create_immutables
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    //     MaterialPageRoute(builder: (context) {
                                    //   return const Inscription();
                                    // })
                                    PageTransition(
                                      alignment: Alignment.bottomCenter,
                                      curve: Curves.easeInOut,
                                      duration:
                                          const Duration(milliseconds: 600),
                                      reverseDuration:
                                          const Duration(milliseconds: 600),
                                      type:
                                          PageTransitionType.leftToRightJoined,
                                      child: const Inscription(),
                                      childCurrent: const Login(),
                                    ),
                                  );
                                },
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text("pas de compte?"),
                                      Text("Inscrivez vous",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold)),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
