import 'dart:convert';
class Login{
  int? id;
  String? pseudo;
  String? password;
  int? admin;
  Login(this.id, this.pseudo, this.password, this.admin);
  Login.fromJson(Map<String, dynamic> json):
        pseudo = json['pseudo'],
        password = json['password'],
        admin = json['admin'];

  Map<String, dynamic> toJson() =>{
    'pseudo' : pseudo,
    'password' : password,
    'admin' : admin,
  };
}