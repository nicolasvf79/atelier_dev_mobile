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

class updateUser extends StatefulWidget {
  const updateUser({Key? key}) : super(key: key);
  @override
  _updateUser createState() => _updateUser();
}
class _updateUser extends State<updateUser> {
  List<AllUser> listeArtist = <AllUser>[];
  TextEditingController tecPseudo =  new TextEditingController();
  TextEditingController tecName =  new TextEditingController();
  TextEditingController tecFirstName =  new TextEditingController();
  TextEditingController tecEmail =  new TextEditingController();
  bool tecAdmin = false;
  int id = 0;
  String pseudo = "Pseudo";
  String name = "Name";
  String firstName = "Prénom";
  String email = "Email";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Modification d'utilisateur")),
      body: Column(
        children: [
          _buildListView(),
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
                label: Text('$pseudo'),
                prefixIcon: Icon(Icons.person_add)
            ),
          ),
          TextField(
            controller: tecName,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                label: Text('$name'),
                prefixIcon: Icon(Icons.person_add)
            ),
          ),
          TextField(
            controller: tecFirstName,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                label: Text('$firstName'),
                prefixIcon: Icon(Icons.person_add)
            ),
          ),
          TextField(
            controller: tecEmail,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                label: Text('$email'),
                prefixIcon: Icon(Icons.person_add)
            ),
          ),
          CheckboxListTile(
            title: Text("Est Administrateur ?"),
            value: tecAdmin,
            onChanged: (newValue) {
              setState(() {
                tecAdmin = newValue!;
              });
            },
          ),
          ElevatedButton(
            onPressed: _valider,
            child: Text("Valider", style: TextStyle(fontSize: 10.0,)),
          )
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
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      id = listeArtist[index].id!.toInt();
                      pseudo = listeArtist[index].pseudo!.toString();
                      name = listeArtist[index].name!.toString();
                      firstName = listeArtist[index].firstName!.toString();
                      email = listeArtist[index].email!.toString();
                    });
                  },
                  child: Text("Pseudo : " + listeArtist[index].pseudo!.toString(), style: TextStyle(fontSize:  10.0,)),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  _valider() async{
    String lastId = id.toString();
    String lastPseudo = tecPseudo.text;
    if (lastPseudo == "") {
      lastPseudo = pseudo.toString();
    }

    String lastName = tecName.text;
    if (lastName == "") {
      lastName = name.toString();
    }

    String lastFirstName = tecFirstName.text;
    if (lastFirstName == "") {
      lastFirstName = firstName.toString();
    }

    String lastEmail = tecEmail.text;
    if (lastEmail == "") {
      lastEmail = email.toString();
    }

    String admin;
    if (tecAdmin == true){
      admin = "1";
    } else {
      admin = "0";
    }

    String ip = Address().ip_address.toString();
    var responseArtist = await http.post(
        Uri.parse("http://" + ip + ":8080/updateUser"),
        headers:{
          "id": lastId,
          "pseudo": lastPseudo,
          "name": lastName,
          "first": lastFirstName,
          "email": lastEmail,
          "admin": admin,
        }
    );
    if (responseArtist.statusCode == 200)
    {
      tecPseudo.clear();
      tecName.clear();
      tecFirstName.clear();
      tecEmail.clear();
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