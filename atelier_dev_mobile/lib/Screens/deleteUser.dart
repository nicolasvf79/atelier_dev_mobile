// ignore: file_names
import 'dart:convert';

import 'dart:convert';
import 'package:atelier_dev_mobile/bo/ipAddress.dart';
import 'package:atelier_dev_mobile/bo/allUser.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class deleteUser extends StatefulWidget {
  const deleteUser({Key? key}) : super(key: key);
  @override
  _deleteUser createState() => _deleteUser();
}
class _deleteUser extends State<deleteUser> {
  List<AllUser> listeArtist = <AllUser>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Suppression d'utilisateur")),
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
                  onPressed: () => DeleteOneUser(listeArtist[index].id!.toString()),
                  child: Text("Pseudo : " + listeArtist[index].pseudo!.toString(), style: TextStyle(fontSize:  10.0,)),
                )
              ],
            ),
          );
        },
      ),
    );
  }


  DeleteOneUser(id) async{
    String ip = Address().ip_address.toString();
    var responseArtist = await http.delete(
        Uri.parse("http://" + ip + ":8080/deleteUser"),
        headers:{
          "id": id,
        }
    );
    if (responseArtist.statusCode == 200)
    {
      _getAllUser();
    }
  }


  _getAllUser() async{
    String ip = Address().ip_address.toString();
    var responseArtist = await http.get(
      Uri.parse("http://" + ip + ":8080/allUser"),
    );
    if (responseArtist.statusCode == 200){
      print(responseArtist.body.toString());
      List mapMessages = jsonDecode(responseArtist.body);
      listeArtist = mapMessages.map((i) => AllUser.fromJson(i)).toList();

      _reloadListView(listeArtist);
      listeArtist.forEach((element) {
      });
    }
  }

  _reloadListView(List<AllUser> artist){
    setState(() {
      listeArtist = artist;
    });
  }

  void _accueil(){
    Navigator. of (context).pushNamed('/homeAdmin');
  }
}