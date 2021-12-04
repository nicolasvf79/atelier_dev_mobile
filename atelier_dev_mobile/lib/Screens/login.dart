// ignore: file_names
import 'dart:convert';

import 'dart:convert';
import 'package:atelier_dev_mobile/bo/ipAddress.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;

import 'package:atelier_dev_mobile/bo/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);
  @override
  _login createState() => _login();
}
class _login extends State<login> {
  List<Login> listeUser = <Login>[];
  TextEditingController tecPseudo =  new TextEditingController();
  TextEditingController tecName =  new TextEditingController();
  TextEditingController tecFirstName =  new TextEditingController();
  TextEditingController tecEmail =  new TextEditingController();
  TextEditingController tecPassword =  new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Connexion")),
      body: Column(
        children: [
          MenuAjout(),
          buildRowInput()
        ],
      ),
    );
  }

  Widget buildRowInput() {
    return Container(
      decoration: BoxDecoration(color : Theme.of(context).primaryColor),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: _accueil,
            child: Text("Accueil", style: TextStyle(fontSize: 10.0,)),
          )
        ]
        ,),
    );
  }


  Widget MenuAjout() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: tecPseudo,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                label: Text("Pseudo"),
                prefixIcon: Icon(Icons.person_add)
            ),
          ),
          TextField(
            controller: tecPassword,
            obscureText: true,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
                label: Text("Mot de Passe"),
                prefixIcon: Icon(Icons.person_add)
            ),
          ),
          ElevatedButton(
            onPressed: _valider,
            child: Text("Valider", style: TextStyle(fontSize: 10.0,)),
          )
        ],
      ),
    );
  }

  _valider() async{
    String pseudo = tecPseudo.text;
    String password = tecPassword.text;
    password = generateMd5(password);
    String ip = Address().ip_address.toString();

    var responseArtist = await http.post(
        Uri.parse("http://" + ip + ":8080/getUser"),
        headers:{
          "pseudo": pseudo,
          "password": password,
        }
    );
    if (responseArtist.statusCode == 200)
    {
      print(responseArtist.body.toString());

      List mapArtist = jsonDecode(responseArtist.body);
      listeUser = mapArtist.map((i) => Login.fromJson(i)).toList();
      listeUser.forEach((element) {});


      String passwordGet = listeUser[0].password.toString();
      if (passwordGet == password) {
        tecPseudo.clear();
        tecName.clear();
        tecFirstName.clear();
        tecEmail.clear();
        tecPassword.clear();

        String admin = listeUser[0].admin.toString();
        print("ADMIN = " + admin);
        if (admin == "null") {
          _home();
        } else {
          _homeAdmin();
        }
      }
    }
  }

  generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  void _accueil(){
    Navigator. of (context).pushNamed('/');
  }

  void _home() {
    Navigator. of (context).pushNamed('/Artist');
  }

  void _homeAdmin() {
    Navigator. of (context).pushNamed('/homeAdmin');
  }
}