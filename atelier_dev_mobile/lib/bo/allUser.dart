import 'dart:convert';
class AllUser{
  int? id;
  String? pseudo;
  String? name;
  String? firstName;
  String? email;
  int? admin;

  AllUser(this.id, this.pseudo, this.name, this.firstName, this.email, this.admin);
  AllUser.fromJson(Map<String, dynamic> json):
        id = json['id'],
        pseudo = json['pseudo'],
        name = json['name'],
        firstName = json['firstName'],
        email = json['email'],
        admin = json['admin'];

  Map<String, dynamic> toJson() =>{
    'id' : id,
    'pseudo' : pseudo,
    'name' : name,
    'firstName' : firstName,
    'email' : email,
    'admin' : admin,
  };
}