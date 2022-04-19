import 'package:flutter/material.dart';

class ActiveCompte extends StatefulWidget {
  const ActiveCompte({Key? key}) : super(key: key);

  @override
  _ActiveCompteState createState() => _ActiveCompteState();
}

class _ActiveCompteState extends State<ActiveCompte> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Activé mon compte"),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Entrez le code de paiement",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextFormField(
              decoration: InputDecoration(
                fillColor: Colors.grey.withOpacity(0.2),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2),
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
                  "Activé",
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
