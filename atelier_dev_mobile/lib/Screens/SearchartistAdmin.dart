// ignore: file_names
import 'dart:convert';

import 'package:atelier_dev_mobile/bo/ipAddress.dart';
import 'package:atelier_dev_mobile/bo/allArtist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class searchArtistAdmin extends StatefulWidget {
  const searchArtistAdmin({Key? key}) : super(key: key);
  @override
  _listArtistState createState() => _listArtistState();
}
class _listArtistState extends State<searchArtistAdmin> {
  List<AllArtist> listeArtist = <AllArtist>[];
  TextEditingController tecArtist =  new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllArtist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Les Artistes")),
      body: Column(
        children: [
          _builColumnFields(),
          _builRowView(),
          _builRowView1(),
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

  Widget _builColumnFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          TextField(
            controller: tecArtist,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                label: Text("Nom de l'artiste / scene / heure"),
                prefixIcon: Icon(Icons.person)
            ),
          ),
        ]
        ,),
    );
  }

  Widget _builRowView()
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        children:<Widget>[
          ElevatedButton(
            onPressed: _getAllArtist,
            child: Text("Tous les artistes", style: TextStyle(fontSize: 10.0,)),
          ),
          ElevatedButton(
            onPressed: _getOneArtist,
            child: Text("Chercher par Nom", style: TextStyle(fontSize: 10.0,)),
          ),
        ],
      ),
    );
  }

  Widget _builRowView1()
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        children:<Widget>[
          ElevatedButton(
            onPressed: _getOneScene,
            child: Text("Chercher par Scene", style: TextStyle(fontSize: 10.0,)),
          ),
          ElevatedButton(
            onPressed: _getOneHeure,
            child: Text("Chercher par Heure", style: TextStyle(fontSize: 10.0,)),
          ),
        ],
      ),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Nom de l'artiste : ", style: TextStyle(fontSize: 15.0)),
                Text(listeArtist[index].name!.toString(), style: TextStyle(fontSize: 15.0,)),
              ],
            ),
            subtitle: Text("Description : " + listeArtist[index].description!.toString() + "\nScene : " + listeArtist[index].scene!.toString()
                + "\nHeure : " + listeArtist[index].heure!.toString(), style: TextStyle(fontSize:  10.0,)),
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

  _getOneArtist() async{
    String name = tecArtist.text;
    String ip = Address().ip_address.toString();
    print("NAME = " + name);
    var responseArtist = await http.get(
        Uri.parse("http://" + ip + ":8080/allArtist/name"),
        headers:{
          "name": name,
        }
    );
    if (responseArtist.statusCode == 200)
    {
      print(responseArtist.body.toString());
      List mapArtist = jsonDecode(responseArtist.body);
      listeArtist = mapArtist.map((i) => AllArtist.fromJson(i)).toList();

      _reloadListView(listeArtist);
      listeArtist.forEach((element) {});
    }
  }

  _getOneScene() async{
    String scene = tecArtist.text;
    String ip = Address().ip_address.toString();
    var responseArtist = await http.get(
        Uri.parse("http://"+ ip + ":8080/allArtist/scene"),
        headers:{
          "scene": scene,
        }
    );
    if (responseArtist.statusCode == 200)
    {
      print(responseArtist.body.toString());
      List mapArtist = jsonDecode(responseArtist.body);
      listeArtist = mapArtist.map((i) => AllArtist.fromJson(i)).toList();

      _reloadListView(listeArtist);
      listeArtist.forEach((element) {});
    }
  }

  _getOneHeure() async{
    String heure = tecArtist.text;
    String ip = Address().ip_address.toString();
    var responseArtist = await http.get(
        Uri.parse("http://" + ip + ":8080/allArtist/hour"),
        headers:{
          "hour": heure,
        }
    );
    if (responseArtist.statusCode == 200)
    {
      print(responseArtist.body.toString());
      List mapArtist = jsonDecode(responseArtist.body);
      listeArtist = mapArtist.map((i) => AllArtist.fromJson(i)).toList();

      _reloadListView(listeArtist);
      listeArtist.forEach((element) {});
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