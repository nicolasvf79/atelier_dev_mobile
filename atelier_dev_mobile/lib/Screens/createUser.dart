// ignore: file_names
import 'dart:convert';

import 'dart:convert';
import 'package:atelier_dev_mobile/bo/ipAddress.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class createUser extends StatefulWidget {
  const createUser({Key? key}) : super(key: key);
  @override
  _createUser createState() => _createUser();
}
class _createUser extends State<createUser> {
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
      appBar: AppBar(title: Text("Inscription")),
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
            controller: tecName,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                label: Text("Nom"),
                prefixIcon: Icon(Icons.person_add)
            ),
          ),
          TextField(
            controller: tecFirstName,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                label: Text("Prénom"),
                prefixIcon: Icon(Icons.person_add)
            ),
          ),
          TextField(
            controller: tecEmail,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                label: Text("Email"),
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
    String name = tecName.text;
    String firstName = tecFirstName.text;
    String email = tecEmail.text;
    String password = tecPassword.text;
    password = generateMd5(password);

    String ip = Address().ip_address.toString();
    var responseArtist = await http.post(
        Uri.parse("http://" + ip + ":8080/createUser"),
        headers:{
          "pseudo": pseudo,
          "name": name,
          "first": firstName,
          "email": email,
          "password": password,
        }
    );
    if (responseArtist.statusCode == 200)
    {
      tecPseudo.clear();
      tecName.clear();
      tecFirstName.clear();
      tecEmail.clear();
      tecPassword.clear();

      _allArtist();
    }
  }

  generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  void _allArtist()
  {
    Navigator.of(context).pushNamed("/Artist");
  }

  void _accueil(){
    Navigator. of (context).pushNamed('/homeAdmin');
  }
}