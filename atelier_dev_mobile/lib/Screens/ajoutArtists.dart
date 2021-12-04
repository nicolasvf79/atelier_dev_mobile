// ignore: file_names
import 'dart:convert';

import 'package:atelier_dev_mobile/bo/ipAddress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ajoutArtist extends StatefulWidget {
  const ajoutArtist({Key? key}) : super(key: key);
  @override
  newArtist createState() => newArtist();
}
class newArtist extends State<ajoutArtist> {
  TextEditingController tecName =  new TextEditingController();
  TextEditingController tecDescription =  new TextEditingController();
  TextEditingController tecScene =  new TextEditingController();
  TextEditingController tecHour =  new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ajouter des Artistes")),
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
            controller: tecName,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                label: Text("Nom de l'artiste"),
                prefixIcon: Icon(Icons.person_add)
            ),
          ),
          TextField(
            controller: tecDescription,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                label: Text("Description"),
                prefixIcon: Icon(Icons.title)
            ),
          ),
          TextField(
            controller: tecScene,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              label: Text("Scene"),
                prefixIcon: Icon(Icons.add_location)
            ),
          ),
          TextField(
            controller: tecHour,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                label: Text("Heure"),
                prefixIcon: Icon(Icons.access_alarm)
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
    String name = tecName.text;
    String description = tecDescription.text;
    String scene = tecScene.text;
    String hour = tecHour.text;
    String ip = Address().ip_address.toString();
    print("NAME = " + name);
    var responseArtist = await http.post(
        Uri.parse("http://" + ip + ":8080/createArtist"),
        headers:{
          "name": name,
          "description": description,
          "scene": scene,
          "hour": hour,
        }
    );
    if (responseArtist.statusCode == 200)
      {
        tecName.clear();
        tecDescription.clear();
        tecScene.clear();
        tecHour.clear();
      }
  }

  void _accueil(){
    Navigator. of (context).pushNamed('/homeAdmin');
  }
}