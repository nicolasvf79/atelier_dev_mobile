import 'package:flutter/material.dart';

import 'package:atelier_dev_mobile/Screens/SearchArtist.dart';
import 'package:atelier_dev_mobile/Screens/HomeAdmin.dart';
import 'package:atelier_dev_mobile/Screens/ajoutArtists.dart';
import 'package:atelier_dev_mobile/Screens/deleteArtist.dart';
import 'package:atelier_dev_mobile/Screens/createUser.dart';
import 'package:atelier_dev_mobile/Screens/Login_Register.dart';
import 'package:atelier_dev_mobile/Screens/login.dart';
import 'package:atelier_dev_mobile/Screens/updateUser.dart';
import 'package:atelier_dev_mobile/Screens/SearchartistAdmin.dart';
import 'package:atelier_dev_mobile/Screens/deleteUser.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter + PHP CRUD',
      initialRoute: '/',
      routes: {
        '/': (context) => Login_Register(),
        '/createUser': (context) => createUser(),
        '/login': (context) => login(),
        '/updateUser': (context) => updateUser(),
        '/homeAdmin': (context) => HomeAdmin(),
        '/Artist': (context) => searchArtist(),
        '/ajoutArtist': (context) => ajoutArtist(),
        '/delete': (context) => deleteArtist(),
        '/ArtistAdmin': (context) => searchArtistAdmin(),
        '/deleteUser': (context) => deleteUser(),
      },
    );
  }
}