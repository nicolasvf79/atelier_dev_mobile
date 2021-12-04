// ignore: file_names
import 'dart:convert';

import 'package:atelier_dev_mobile/bo/ipAddress.dart';
import 'package:atelier_dev_mobile/bo/allArtist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class deleteArtist extends StatefulWidget {
  const deleteArtist({Key? key}) : super(key: key);
  @override
  _delete createState() => _delete();
}
class _delete extends State<deleteArtist> {
  List<AllArtist> listeArtist = <AllArtist>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllArtist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Supprimer des Artistes")),
      body: Column(
        children: [
          _buildListView(),
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

  Expanded _buildListView() {
    return Expanded(
      child: ListView.separated(
        itemCount: listeArtist.length,
        separatorBuilder: (context, index)=> Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => DeleteArtist(listeArtist[index].name!.toString(), listeArtist[index].description!.toString(), listeArtist[index].scene!.toString(), listeArtist[index].heure!.toString()),
                  child: Text("Nom de l'artiste : " + listeArtist[index].name!.toString() + "\nDescription : " + listeArtist[index].description!.toString() + "\nScene : " + listeArtist[index].scene!.toString()
                      + "\nHeure : " + listeArtist[index].heure!.toString(), style: TextStyle(fontSize:  10.0,)),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  _getAllArtist() async{
    String ip = Address().ip_address.toString();
    var responseArtist = await http.get(
      Uri.parse("http://" + ip + ":8080/allArtist"),
    );
    if (responseArtist.statusCode == 200){
      print(responseArtist.body.toString());
      List mapMessages = jsonDecode(responseArtist.body);
      listeArtist = mapMessages.map((i) => AllArtist.fromJson(i)).toList();

      _reloadListView(listeArtist);
      listeArtist.forEach((element) {
      });
    }
  }

  DeleteArtist(name, description, scene, hour) async{
    String ip = Address().ip_address.toString();
    var responseArtist = await http.delete(
        Uri.parse("http://" + ip + ":8080/deleteArtist"),
        headers:{
          "name": name,
          "description": description,
          "scene": scene,
          "hour": hour,
        }
    );
    if (responseArtist.statusCode == 200)
    {
      _getAllArtist();
    }
  }

  _reloadListView(List<AllArtist> artist){
    setState(() {
      listeArtist = artist;
    });
  }

  void _accueil(){
    Navigator. of (context).pushNamed('/homeAdmin');
  }
}