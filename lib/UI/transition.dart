import 'package:flutter/material.dart';
import 'package:monprof/UI/login.dart';
import 'package:monprof/UI/onboardinding.dart';
import 'package:monprof/models/eleve.dart';
import 'package:monprof/studies/allcoursforclass.dart';

class TransitionPage extends StatefulWidget {
  const TransitionPage({Key? key}) : super(key: key);

  @override
  State<TransitionPage> createState() => _TransitionPageState();
}

class _TransitionPageState extends State<TransitionPage> {
  bool login = false;
  Future<void> isconnected() async {
    Eleve.getEleve();
    if (Eleve.sessionEleve.classe != '' && Eleve.sessionEleve.matricule != "") {
      setState(() {
        login = true;
      });
    } else {
      setState(() {
        login = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    isconnected();
  }

  @override
  Widget build(BuildContext context) {
    return login
        ? AllCoursForClasse(eleve: Eleve.sessionEleve)
        : const Onboarding();
  }
}
