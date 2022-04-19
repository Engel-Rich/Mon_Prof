import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:monprof/UI/avant_page.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10.withOpacity(0.9),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: Colors.white,
        ),
        margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'Bienvenue',
              body: "Bienvenue sur la nouvelle plateforme d'etude numerique",
              image: Image.asset('assets/study1.png'),
              decoration: const PageDecoration(
                  pageColor: Colors.white,
                  bodyTextStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
            ),
            PageViewModel(
              title: '',
              body:
                  'Apprenez desormais vos lecons en ligne et soiyez suivit par les meilleurs enseignants',
              image: Image.asset('assets/prof.png'),
              decoration: const PageDecoration(
                  pageColor: Colors.white,
                  bodyTextStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
            ),
            PageViewModel(
              title: 'page1',
              body:
                  'Un large réseau de partenaire pour vous garantire un service de qualité exceptionnel',
              image: Image.asset('assets/study2.png'),
              decoration: const PageDecoration(
                  pageColor: Colors.white,
                  bodyTextStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
            ),
            PageViewModel(
              title: '',
              body: 'la réussite pour tous avec des cours vidéo de qualités',
              image: Image.asset('assets/study3.png'),
              decoration: const PageDecoration(
                  pageColor: Colors.white,
                  bodyTextStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
            ),
          ],
          showNextButton: false,
          done: const Text(
            'Suivant',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          onDone: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Avantpage()),
            );
          },
        ),
      ),
    );
  }
}
