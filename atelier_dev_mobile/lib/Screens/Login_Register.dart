// ignore: file_names
import 'dart:convert';

import 'package:atelier_dev_mobile/bo/allArtist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Login_Register extends StatefulWidget {
  const Login_Register({Key? key}) : super(key: key);
  @override
  _loginRegister createState() => _loginRegister();
}
class _loginRegister extends State<Login_Register> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Column(
        children: [
          MenuButtons(),
        ],
      ),
    );
  }

  Widget MenuButtons() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: _Login,
            child: Text("Connexion", style: TextStyle(fontSize: 10.0,)),
          ),
          ElevatedButton(
            onPressed: _Register,
            child: Text("Inscription", style: TextStyle(fontSize: 10.0,)),
          ),
        ],
      ),
    );
  }


  void _Login(){
    Navigator. of (context).pushNamed('/login');
  }

  void _Register(){
    Navigator.of(context).pushNamed('/createUser');
  }
}