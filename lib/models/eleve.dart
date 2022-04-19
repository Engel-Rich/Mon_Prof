import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Eleve {
  String? nomEleve;
  final String classe;
  final String matricule;
  final String password;
  Eleve({
    this.nomEleve,
    required this.classe,
    required this.matricule,
    required this.password,
  });
  static Eleve sessionEleve = Eleve(classe: '', matricule: '', password: '');
  Future login() async {
    final uri = Uri(
      scheme: "https",
      host: 'kedycours.000webhostapp.com',
      path: "/traitements/traitementelves.php",
    );
    var response = await http.post(uri, body: {
      'classe': classe,
      'passe_eleve': password,
      "matricule_eleve": matricule
    });
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      return result;
    } else {
      return response.statusCode.toString();
    }
  }

  Future register() async {
    final uri = Uri(
      scheme: "https",
      host: 'kedycours.000webhostapp.com',
      path: "/traitements/traitementelves.php",
    );
    var response = await http.post(uri, body: {
      'classe': classe,
      'passe_eleve': password,
      "matricule_eleve": matricule,
      "nom_eleve": nomEleve
    });
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      // list.add(result[0]['code']);
      // list.add(result[0]['valeur']);
      return result;
    } else {
      return response.statusCode.toString();
    }
  }

  factory Eleve.fromJson(Map<String, dynamic> map) => Eleve(
        classe: map["classe"],
        matricule: map["matricule_eleve"],
        password: map["passe_eleve"],
        nomEleve: map["nom_eleve"],
      );
  Map<String, dynamic> elevetomap() {
    return {
      "classe": classe,
      "matricule_eleve": matricule,
      "passe_eleve": password,
      "nom_eleve": nomEleve,
    };
  }

  static void saveEleve(Eleve eleve) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var data = jsonEncode(eleve.elevetomap());
    preferences.setString('eleve', data);
    preferences.commit();
  }

  static void getEleve() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var data = preferences.getString("user");
    if (data != null) {
      var decode = json.decode(data);
      var eleve = Eleve.fromJson(decode);
      sessionEleve = eleve;
    } else {
      sessionEleve = sessionEleve;
    }
  }
}
