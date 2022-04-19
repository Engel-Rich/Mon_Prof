import 'package:flutter/material.dart';
import 'package:monprof/UI/active_compte.dart';
import 'package:monprof/UI/apropos.dart';
import 'package:monprof/UI/cours.dart';
import 'package:monprof/UI/parametre.dart';
import 'package:monprof/UI/sugestion.dart';
import 'package:page_transition/page_transition.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10.withOpacity(0.9),
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Invité / Classe',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
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
                  MaterialPageRoute(builder: (context) => ActiveCompte()),
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
      body: Container(
        margin: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          shrinkWrap: true,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                      alignment: Alignment.bottomCenter,
                      curve: Curves.easeInOut,
                      duration: const Duration(milliseconds: 600),
                      reverseDuration: const Duration(milliseconds: 600),
                      type: PageTransitionType.bottomToTop,
                      child: const Cours(),
                      childCurrent: const Home()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 1, color: Colors.blue)),
                child: Column(children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Image.asset('assets/physique.png'),
                    ),
                  ),
                  const Text(
                    'Physique',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ]),
              ),
            ),
            InkWell(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 1, color: Colors.blue)),
                child: Column(children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Image.asset('assets/science.png'),
                    ),
                  ),
                  const Text(
                    'Science',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ]),
              ),
            ),
            InkWell(
              onTap: null,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 1, color: Colors.blue)),
                child: Column(children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Image.asset('assets/maths.png'),
                    ),
                  ),
                  const Text(
                    'Mathematiques',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ]),
              ),
            ),
            InkWell(
              onTap: null,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 1, color: Colors.blue)),
                child: Column(children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Image.asset('assets/chimie.png'),
                    ),
                  ),
                  const Text(
                    'Chimie',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ]),
              ),
            ),
            InkWell(
              onTap: null,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 1, color: Colors.blue)),
                child: Column(children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Image.asset('assets/anglais.png'),
                    ),
                  ),
                  const Text(
                    'Anglais',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ]),
              ),
            ),
            InkWell(
              onTap: null,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 1, color: Colors.blue)),
                child: Column(children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Image.asset('assets/francais.png'),
                    ),
                  ),
                  const Text(
                    'francais',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ]),
              ),
            ),
            InkWell(
              onTap: null,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 1, color: Colors.blue)),
                child: Column(children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Image.asset('assets/philo.png'),
                    ),
                  ),
                  const Text(
                    'philosophie',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ]),
              ),
            ),
            InkWell(
              onTap: null,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 1, color: Colors.blue)),
                child: Column(children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Image.asset('assets/electricité1.png'),
                    ),
                  ),
                  const Text(
                    'Mesure Electrique',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ]),
              ),
            ),
            InkWell(
              onTap: null,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(width: 1, color: Colors.blue)),
                child: Column(children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Image.asset('assets/electricité2.png'),
                    ),
                  ),
                  const Text(
                    'Production',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
