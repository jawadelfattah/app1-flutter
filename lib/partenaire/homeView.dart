import 'package:flutter/material.dart';

import '../ModelP/Engagement.dart';
import '../ModelP/FirebaseServiceClient.dart';
import '../ModelP/FirebaseServiceEngagement.dart';
import '../ModelP/UsersP.dart';
import '../ModelP/clients.dart';
import '../style/colors.dart';

class HomeView extends StatefulWidget {
  final FirebaseServiceClient firebaseServiceClient;
  final FirebaseServiceEngagement firebaseServiceEngagement;
  final UserP user;
  const HomeView({Key? key, required this.firebaseServiceClient, required this.user, required this.firebaseServiceEngagement});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int nombre=0;

  @override
  void initState() {
    super.initState();
    _loadEngagements();
  }

  void _loadEngagements() async{
    List<Client>cl=await widget.firebaseServiceClient.getClientsForProject(widget.user.idProjet);
    setState(() {
      nombre = cl.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: AppColors.rouge,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1, -1),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.people,
                            size: 50,
                            color: AppColors.blanc,
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, -1),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Clients',
                            style: TextStyle(fontSize: 40, color: AppColors.blanc),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(1, 1),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text(
                              'Nombre : $nombre',
                              style: TextStyle(fontSize: 20, color: AppColors.blanc),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
