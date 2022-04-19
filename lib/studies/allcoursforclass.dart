import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:monprof/UI/active_compte.dart';
import 'package:monprof/UI/apropos.dart';
import 'package:monprof/UI/parametre.dart';
import 'package:monprof/UI/sugestion.dart';
import 'package:monprof/models/eleve.dart';
import 'package:http/http.dart' as http;
import 'package:monprof/studies/onecourslist.dart';
import 'package:page_transition/page_transition.dart';

class AllCoursForClasse extends StatefulWidget {
  final Eleve eleve;
  const AllCoursForClasse({Key? key, required this.eleve}) : super(key: key);

  @override
  State<AllCoursForClasse> createState() => _AllCoursForClasseState();
}

class _AllCoursForClasseState extends State<AllCoursForClasse> {
  List list = <String>[];
  getClasse() async {
    const url = "https://kedycours.000webhostapp.com/getelms/getmatieres.php";
    final uri = Uri.parse(url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      for (var classe in result) {
        setState(() {
          list.add(classe['nom']);
        });
      }
    } else {
      setState(() {
        list = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getClasse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.eleve.classe,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.grey,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CircleAvatar(),
                  ],
                )),
            ListTile(
              title: const Text(
                'Activer mon compte',
                style: TextStyle(fontSize: 15),
              ),
              leading: const Icon(Icons.person_outline_rounded),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ActiveCompte()),
                );
              },
            ),
            ListTile(
              title: const Text(
                'Parametres',
                style: TextStyle(fontSize: 15),
              ),
              leading: const Icon(Icons.settings),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Parametre()),
                );
              },
            ),
            ListTile(
              title: const Text(
                'A Propos',
                style: TextStyle(fontSize: 15),
              ),
              leading: const Icon(Icons.info),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Apropos()),
                );
              },
            ),
            ListTile(
              title: const Text(
                'Sugetion',
                style: TextStyle(fontSize: 15),
              ),
              leading: const Icon(Icons.message),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Sugestion()),
                );
              },
            ),
            const Divider(
              thickness: 1,
            ),
            Container(
              margin: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(30)),
              child: ListTile(
                title: const Center(
                  child: Text(
                    'Déconnexion',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10),
        itemCount: list.length,
        itemBuilder: ((context, index) {
          return InkWell(
            onTap: () => Navigator.push(
                context,
                PageTransition(
                    child: OneCoursLessonsList(
                      matiere: list[index],
                      classe: widget.eleve.classe,
                    ),
                    type: PageTransitionType.leftToRight)),
            child: Container(
              width: double.infinity,
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              height: 60.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 0),
                    ),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    list[index],
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 30,
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
