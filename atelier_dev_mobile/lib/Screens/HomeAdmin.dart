// ignore: file_names
import 'dart:convert';

import 'package:atelier_dev_mobile/bo/allArtist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);
  @override
  _homeAdmin createState() => _homeAdmin();
}
class _homeAdmin extends State<HomeAdmin> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Administration Home")),
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
              onPressed: _Artist,
              child: Text("Chercher par Nom / Scene / heure", style: TextStyle(fontSize: 10.0,)),
            ),
            ElevatedButton(
              onPressed: _AjoutArtist,
              child: Text("Ajouter des Artistes", style: TextStyle(fontSize: 10.0,)),
            ),
            ElevatedButton(
              onPressed: _DeleteArtist,
              child: Text("Supprimer des Artistes", style: TextStyle(fontSize: 10.0,)),
            ),
            ElevatedButton(
              onPressed: _ModifUser,
              child: Text("Modifier des utilisateurs", style: TextStyle(fontSize: 10.0,)),
            ),
            ElevatedButton(
              onPressed: _DeleteUser,
              child: Text("Supprimer des utilisateurs", style: TextStyle(fontSize: 10.0,)),
            ),
            ElevatedButton(
              onPressed: _Disconnect,
              child: Text("Déconnexion", style: TextStyle(fontSize: 10.0,)),
            ),
          ],
        ),
      );
    }


  void _Artist(){
    Navigator. of (context).pushNamed('/ArtistAdmin');
  }

  void _AjoutArtist(){
    Navigator.of(context).pushNamed('/ajoutArtist');
  }

  void _DeleteArtist(){
    Navigator.of(context).pushNamed('/delete');
  }

  void _DeleteUser(){
    Navigator.of(context).pushNamed('/deleteUser');
  }

  void _ModifUser(){
    Navigator.of(context).pushNamed('/updateUser');
  }

  void _Disconnect(){
    Navigator.of(context).pushNamed('/');
  }
}