import 'dart:async';
import 'dart:convert';

import 'package:monprof/UI/splashscreen.dart';
import 'package:monprof/models/eleve.dart';
import 'package:monprof/studies/allcoursforclass.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class Inscription extends StatefulWidget {
  const Inscription({Key? key}) : super(key: key);

  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  //variables

  TextEditingController numero = TextEditingController();
  TextEditingController nom = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isloading = false;
  final formGlobalKey = GlobalKey<FormState>();

  String? valeurClasse;

  bool visible = true;
  bool visibleconfir = false;
  String requestError = '';

  Future<List<String>> listcours() async {
    var list = <String>[];
    final url =
        Uri.parse('https://kedycours.000webhostapp.com/getelms/courslist.php');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final listProvisoire = jsonDecode(response.body);
      for (var x in listProvisoire) {
        list.add(x['nom']);
      }
    } else {
      list.add(response.statusCode.toString());
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? const SplashScreen()
        : Scaffold(
            backgroundColor: Colors.white10.withOpacity(0.9),
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Center(
                child: Text(
                  'Inscription',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            body: SingleChildScrollView(
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
                        child: Form(
                            key: formGlobalKey,
                            child: Column(
                              children: [
                                Container(
                                    height: 150,
                                    padding: const EdgeInsets.all(20),
                                    child: Image.asset('assets/book.png')),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(
                                          color: Colors.grey, width: 2)),
                                  child: FutureBuilder<List<String>>(
                                      future: listcours(),
                                      builder: (context, snapshot) {
                                        return snapshot.hasData
                                            ? DropdownButton(
                                                value: valeurClasse,
                                                isExpanded: true,
                                                items: snapshot.data?.map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                    (String value) {
                                                  return DropdownMenuItem(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                hint: const Text(
                                                  'Choisir votre classe',
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    valeurClasse = value!;
                                                  });
                                                },
                                              )
                                            : Shimmer.fromColors(
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
                                              );
                                      }),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "entrer un numero";
                                    } else if (value.trim().length != 9) {
                                      return "entrer un numero valide";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: numero,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      prefixText: '+237',
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
                                  height: 15,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "entrer un nom";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: nom,
                                  decoration: InputDecoration(
                                      fillColor: Colors.grey.withOpacity(0.3),
                                      filled: true,
                                      hintText: "nom",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      prefixIcon: const IconButton(
                                        onPressed: null,
                                        icon: CircleAvatar(
                                            child: Icon(Icons.person)),
                                      )),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),

                                const SizedBox(
                                  height: 15,
                                ),

                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "entrer un mots de passe";
                                    } else if (value.trim().length < 8) {
                                      return "au moins 8 caracteres requis";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: password,
                                  obscureText: visible,
                                  keyboardType: TextInputType.visiblePassword,
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
                                      icon: !visible
                                          ? const CircleAvatar(
                                              child: Icon(Icons.visibility_off))
                                          : const CircleAvatar(
                                              child: Icon(Icons.visibility)),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  validator: (val) {
                                    if (val == password.text) {
                                      return null;
                                    } else {
                                      return 'the password is not same';
                                    }
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: visibleconfir,
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey.withOpacity(0.3),
                                    filled: true,
                                    hintText: "confirmé le mots de passe",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    prefixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          visibleconfir = !visibleconfir;
                                        });
                                      },
                                      icon: visibleconfir
                                          ? const CircleAvatar(
                                              child: Icon(Icons.lock))
                                          : const CircleAvatar(
                                              child: Icon(Icons.lock_open)),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          visibleconfir = !visibleconfir;
                                        });
                                      },
                                      icon: !visibleconfir
                                          ? const CircleAvatar(
                                              child: Icon(Icons.visibility_off))
                                          : const CircleAvatar(
                                              child: Icon(Icons.visibility)),
                                    ),
                                  ),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: 50,
                                  margin: const EdgeInsets.all(15),
                                  child: TextButton(
                                    onPressed: () async {
                                      if (formGlobalKey.currentState!
                                          .validate()) {
                                        final eleve = Eleve(
                                            nomEleve: nom.text,
                                            classe: valeurClasse ?? "no classe",
                                            matricule: numero.text,
                                            password: password.text);
                                        if (eleve.classe == "no classe") {
                                          Fluttertoast.showToast(
                                              msg: 'veiller choisir la classe');
                                        } else {
                                          try {
                                            setState(() {
                                              isloading = !isloading;
                                            });
                                            var result = await eleve.register();
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
                                                  isloading = !isloading;
                                                });
                                              });
                                            } else {
                                              Timer(
                                                const Duration(
                                                    milliseconds: 4250),
                                                () => setState(() {
                                                  isloading = !isloading;
                                                  requestError = result['code'];
                                                }),
                                              );
                                            }
                                          } catch (e) {
                                            print(e);
                                          }
                                        }
                                        // print(
                                        //     " ${eleve.classe}, ${eleve.nomEleve},${eleve.matricule},${eleve.password},");
                                      }
                                    },
                                    child: const Text(
                                      "S'inscrire",
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
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text("déja un compte ?"),
                                        Text("Connectez vous",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold)),
                                      ]),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
