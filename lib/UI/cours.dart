import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:monprof/UI/videocours.dart';

class Cours extends StatefulWidget {
  const Cours({Key? key}) : super(key: key);

  @override
  _CoursState createState() => _CoursState();
}

class _CoursState extends State<Cours> {
  get tabController => null;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: const FloatingActionButton(
          child: Icon(
            Icons.email,
          ),
          onPressed: null,
        ),
        appBar: AppBar(
          title: const Text('Noms du cours'),
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                icon: Icon(Icons.book),
                text: 'Cours',
              ),
              Tab(
                icon: Icon(Icons.message),
                text: 'Forum',
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 1,
                            style: BorderStyle.solid,
                            color: Colors.blue),
                      ),
                      child: ListTile(
                        leading: const CircleAvatar(
                            backgroundColor: Colors.grey, child: Text('1')),
                        title: const Text('Chapitre 1'),
                        subtitle: const Text('les solutions acqueuse'),
                        trailing: const Icon(Icons.arrow_right, size: 40),
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                                alignment: Alignment.bottomCenter,
                                curve: Curves.easeInOut,
                                duration: const Duration(milliseconds: 600),
                                reverseDuration:
                                    const Duration(milliseconds: 600),
                                type: PageTransitionType.fade,
                                child: const VideoCours(),
                                childCurrent: const Cours()),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              margin: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 1,
                          style: BorderStyle.solid,
                          color: Colors.blue,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                              Text(
                                "nom de l'utilisateur",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 1,
                            color: Colors.blue,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          //Iv@n_2022K€dy
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                            ),
                            child: const Text(
                                "Question de l'utilisateur de l'utilisateur  de l'utilisateur  de l'utilisateur  de l'utilisateur  de l'utilisateur  vv de l'utilisateur  de l'utilisateur  de l'utilisateur  courant avec élément de réponse plus bas par l'enseignant"),
                          ),
                          Column(
                            children: [
                              const Text(
                                'Nom Proffeseur',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                ),
                                child: const Text(
                                    "ur  de l'utilisateur  de l'utilisateur  courant avec élément de réponse plus bas par l'enseignant"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void change() {
  PageTransition(
    alignment: Alignment.bottomCenter,
    curve: Curves.easeInOut,
    duration: const Duration(milliseconds: 500),
    reverseDuration: const Duration(milliseconds: 800),
    type: PageTransitionType.leftToRightJoined,
    child: const VideoCours(),
    childCurrent: const Cours(),
  );
}
