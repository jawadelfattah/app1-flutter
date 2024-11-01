import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ModelP/FirebaseServiceClient.dart';
import '../ModelP/FirebaseServiceProjet.dart';
import '../ModelP/FirebaseServiceUser.dart';
import '../ModelP/Projets.dart';
import '../ModelP/UsersP.dart';
import 'Home.dart';
import 'loginView.dart';

class loadingpage extends StatefulWidget {
  const loadingpage({super.key});

  @override
  State<loadingpage> createState() => _loadingpageState();
}

class _loadingpageState extends State<loadingpage> {
  late Future<UserP?> _userFuture;
  late Future<Projet?> _projetFuture;
  FirebaseServiceClient firebaseServiceClient = FirebaseServiceClient();
  FirebaseServiceUser firebaseServiceUser = FirebaseServiceUser();
  FirebaseServiceProjet firebaseServiceProjet = FirebaseServiceProjet();
  @override
  void initState() {
    super.initState();
    _userFuture = _loadUser();
    _projetFuture = loadProjet();
  }

  Future<UserP?> _loadUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      UserP? u = await firebaseServiceUser.rechercheUserParId(user.uid);
      return u;
    }
    return null;
  }

  Future<Projet?> loadProjet() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      UserP? u = await firebaseServiceUser.rechercheUserParId(user.uid);
      if (u != null) {
        Projet? p = await firebaseServiceProjet.getprojetInfo(u.idProjet);
        return p;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.wait([_userFuture, _projetFuture]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              UserP? userApp = snapshot.data?[0];
              Projet? projet = snapshot.data?[1];

              if (userApp != null && projet != null) {
                return Home(
                  firebaseServiceClient: firebaseServiceClient,
                  firebaseServiceUser: firebaseServiceUser, user: userApp, projet: projet,
                );
              } else {
                return LoginView();
              }
            }
          }
        },
      ),
    );
  }
}




