import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../ModelP/FirebaseServiceClient.dart';
import '../ModelP/FirebaseServiceEngagement.dart';
import '../ModelP/FirebaseServiceProjet.dart';
import '../ModelP/FirebaseServiceUser.dart';
import '../ModelP/FirebaseStorageService.dart';
import '../ModelP/Projets.dart';
import '../ModelP/UsersP.dart';
import '../style/colors.dart';
import 'ClientView.dart';
import 'ProjetView.dart';
import 'homeView.dart';
import 'profilView.dart';


class Home extends StatefulWidget {
  final FirebaseServiceClient firebaseServiceClient;
  final FirebaseServiceUser firebaseServiceUser;
  final UserP user;
  final Projet projet;

  const Home({super.key, required this.firebaseServiceClient, required this.firebaseServiceUser, required this.user, required this.projet});


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseServiceClient firebaseServiceClient = FirebaseServiceClient();
  final FirebaseServiceUser firebaseServiceUser=FirebaseServiceUser();
  final FirebaseServiceProjet firebaseServiceProjet=FirebaseServiceProjet();
  final FirebaseServiceEngagement firebaseServiceEngagement=FirebaseServiceEngagement();
  int _selectedIndex = 0;
  List<bool> pageStates = [true, false, false, false, false];
  int currentIndex = 0;

  late UserP userApp;
  late Projet projet;
  @override
  void initState() {
    super.initState();
    setState(() {
      userApp=widget.user;
      projet=widget.projet;
    });
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      centerTitle: true,
      backgroundColor: AppColors.bleu,
      title: Text("Cinq Etoils",style: TextStyle(color: AppColors.blanc,fontWeight: FontWeight.bold,fontSize: 30,),),
    ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeView(firebaseServiceClient: firebaseServiceClient, user: userApp, firebaseServiceEngagement: firebaseServiceEngagement,),ClientView(firebaseServiceClient: firebaseServiceClient, user: userApp, firebaseServiceEngagement:firebaseServiceEngagement, projet: projet,),ProjetView(user: userApp, firebaseServiceProjet: firebaseServiceProjet,projet: projet,),ProfilView(user:userApp, firebaseServiceUser:firebaseServiceUser, storageService: FirebaseStorageService(), projet: projet,),
        ],
      ),
      bottomNavigationBar: Container(
        color: AppColors.bleu,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
          child: GNav(
              selectedIndex: _selectedIndex,
              onTabChange: (index){
                setState(() {
                  _selectedIndex = index;

                });
              },
              backgroundColor: AppColors.bleu,
              rippleColor: AppColors.jaune, // tab button ripple color when pressed
              hoverColor: AppColors.rouge, // tab button hover color
              haptic: true, // haptic feedback
              tabBorderRadius: 10,
              tabActiveBorder: Border.all(color: AppColors.blanc, width: 1), // tab button border
              //tabBorder: Border.all(color: Colors.grey, width: 2), // tab button border
              //tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)], // tab button shadow
              //curve: Curves.easeInBack, // tab animation curves
              duration: Duration(milliseconds: 900), // tab animation duration
              gap: 10, // the tab button gap between icon and text
              color: AppColors.blanc, // unselected icon color
              activeColor: AppColors.blanc, // selected icon and text color
              iconSize: 25, // tab button icon size
              tabBackgroundColor: Colors.purple.withOpacity(0.1), // selected tab background color
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Accueil',
                ),
                GButton(
                  icon: Icons.people,
                  text: 'Clients',
                ),
                GButton(
                  icon: Icons.business_center,
                  text: 'Projet',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                )
              ]),
        ),
      ),


    );
  }


}