// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

UserModel usermodelFromJson(String str) => UserModel.fromJson(json.decode(str));

String usermodelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? classe;
  String? numero;
  String? nom;
  String? ecole;
  String? password;

  UserModel({this.classe, this.numero, this.nom, this.ecole, this.password});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        classe: json["classe"] == null ? null : json["classe"],
        numero: json["numero"] == null ? null : json["numero"],
        nom: json["nom"] == null ? null : json["nom"],
        ecole: json["ecole"] == null ? null : json["ecole"],
        password: json["password"] == null ? null : json["password"],
      );

  Map<String, dynamic> toJson() => {
        "classe": classe == null ? null : classe,
        "numero": numero == null ? null : numero,
        "nom": nom == null ? null : nom,
        "ecole": ecole == null ? null : ecole,
        "password": password == null ? null : password,
      };
}
