import 'package:flutter/material.dart';

class Sugestion extends StatefulWidget {
  const Sugestion({Key? key}) : super(key: key);

  @override
  _SugestionState createState() => _SugestionState();
}

class _SugestionState extends State<Sugestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Sugestion"),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Entrez votre message",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextFormField(
              decoration: InputDecoration(
                fillColor: Colors.grey.withOpacity(0.2),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onTap: null,
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 50,
              margin: const EdgeInsets.all(15),
              child: TextButton(
                onPressed: null,
                child: const Text(
                  "Envoyer",
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
          ],
        ),
      ),
    );
  }
}
