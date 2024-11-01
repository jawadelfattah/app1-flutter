import 'dart:async';

import 'package:flutter/material.dart';
import '../ModelP/FirebaseServiceClient.dart';
import '../ModelP/FirebaseServiceUser.dart';
import '../ModelP/UsersP.dart';
import '../ModelP/regexvalid.dart';
import '../style/colors.dart';
import 'Dialog/CustomSnackBar.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  FirebaseServiceClient firebaseServiceClient = FirebaseServiceClient();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final FirebaseServiceUser firebaseServiceUser = FirebaseServiceUser();
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Form(
            key: _formkey,
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  ClipOval(
                    child: Container(
                      width: 300,
                      height: 300,
                      child: Image.asset(
                        'assets/logo/logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      width: double.infinity,
                      height: 450,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.bleu,
                            spreadRadius: 5,
                            blurRadius: 20,
                            offset: Offset(3, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Text(
                            "Connexion",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: AppColors.bleu,
                            ),
                          ),
                          Text(
                            "Veuillez vous connecter à votre compte",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.bleu,
                            ),
                          ),
                          SizedBox(height: 50),
                          Container(
                            width: 300,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: email,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                } else if (!Validator.isValidEmail(value)) {
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelStyle: TextStyle(
                                  color: AppColors.bleu,
                                ),
                                labelText: 'Email',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.bleu,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.bleu,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)),
                                ),
                                prefixIcon: Icon(Icons.email, color: AppColors.bleu),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          Container(
                            width: 300,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                }
                                return null;
                              },
                              controller: password,
                              obscureText: !visible,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelStyle: TextStyle(
                                  color: AppColors.bleu,
                                ),
                                labelText: 'Mot de passe',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.bleu,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.bleu,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                                ),
                                prefixIcon: Icon(Icons.lock, color: AppColors.bleu),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    visible ? Icons.visibility_off : Icons.visibility,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      visible = !visible;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          Container(
                            width: 300,
                            height: 50,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formkey.currentState!.validate()) {
                                  singUserIn();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding: EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: Text(
                                'Connecter',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void singUserIn() async {
    try {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      List<UserP> user = await firebaseServiceUser.rechercheUserParEmailEtPassword(email.text, password.text);

      if (user.isNotEmpty) {
        String roleuser = user.first.role;
        if (roleuser == "partenaire") {
          String? signInResult = await firebaseServiceUser.signInWithEmailAndPassword(email.text, password.text);

          if (signInResult == null) {
            CustomSnackBar.showCustomSnackBar(context, "Succès",
                "Vous êtes connecté", AppColors.vert, Icons.done);

          } else {
            CustomSnackBar.showCustomSnackBar(
                context, "Erreur", signInResult, AppColors.rouge, Icons.error);
          }
        } else {
          CustomSnackBar.showCustomSnackBar(
              context,
              "Erreur",
              "Cette application est réservée aux partenaires.",
              AppColors.rouge,
              Icons.error);
        }
      } else {
        CustomSnackBar.showCustomSnackBar(
            context,
            "Erreur",
            "Aucun utilisateur trouvé pour cet e-mail.",
            AppColors.rouge,
            Icons.error);
      }
    } catch (e) {
      print(
          "Une erreur s'est produite lors de la connexion de l'utilisateur : $e");
    } finally {
        Navigator.pop(context);

    }
  }


}

