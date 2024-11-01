import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../ModelP/FirebaseServiceUser.dart';
import '../../ModelP/UsersP.dart';
import '../../ModelP/regexvalid.dart';
import '../../style/colors.dart';

class ModifierProfil extends StatefulWidget {
  final UserP user;
  final Uint8List? image;
  const ModifierProfil({super.key, required this.user, required this.image});

  @override
  State<ModifierProfil> createState() => _ModifierProfilState();
}

class _ModifierProfilState extends State<ModifierProfil> {
  bool visible = false;
  final FirebaseServiceUser firebaseServiceUser=FirebaseServiceUser();
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return AlertDialog(
              backgroundColor: AppColors.blanc,
              content: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          padding: const EdgeInsets.symmetric(horizontal:40,vertical: 10 ),
                          decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.vert
                          ),
                          child: Title(color: AppColors.bleu, child: const Text("Modifier Projet",style: TextStyle(color: AppColors.blanc,fontSize: 30),))),
                      const SizedBox(height: 10,),
                      TextFormField(
                        initialValue: widget.user.lastName,
                        onChanged: (value) {
                          widget.user.lastName = value;
                        },
                        validator: (value){
                          if (value!.isEmpty) {
                            return "Vous devez entrer le nom";
                          }
                          return null;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(
                            color: AppColors.vert,
                          ),
                          labelText: 'Prenom',
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.vert,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.vert,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.rouge,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.rouge,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.all(12),
                          prefixIcon: const Icon(Icons.person,color: AppColors.vert,),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      TextFormField(
                        initialValue: widget.user.lastName,
                        onChanged: (value) {
                          widget.user.lastName = value;
                        },
                        validator: (value){
                          if (value!.isEmpty) {
                            return "Vous devez entrer le prénom";
                          }
                          return null;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(
                            color: AppColors.vert,
                          ),
                          labelText: 'nom',
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.vert,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.vert,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.rouge,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.rouge,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.all(12),
                          prefixIcon: const Icon(Icons.person,color: AppColors.vert,),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      TextFormField(
                        initialValue: widget.user.phoneNumber,
                        onChanged: (value) {
                          widget.user.phoneNumber = value;
                        },
                        validator: (value){
                          if (value!.isEmpty) {
                            return "Vous devez entrer telephone";
                          }else if(!Validator.isValidPhoneNumber(value)){
                            return "Entrez le téléphone comme ceci'0 et{9 N}'";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(
                            color: AppColors.vert,
                          ),
                          labelText: 'Telephone',
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.vert,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.vert,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.rouge,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.rouge,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.all(12),
                          prefixIcon: const Icon(Icons.phone,color: AppColors.vert,),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      TextFormField(
                        initialValue: widget.user.email,
                        onChanged: (value) {
                          widget.user.email = value;
                        },
                        keyboardType: TextInputType.emailAddress,
                        validator: (value){
                          if (value!.isEmpty) {
                            return "Vous devez entrer l'Email";
                          }else if(!Validator.isValidEmail(value)){
                            return "Entre un forme d'é-mail valide";
                          }
                          return null;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(
                            color: AppColors.vert,
                          ),
                          labelText: 'Email',
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.vert,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.vert,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.rouge,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.rouge,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.all(12),
                          prefixIcon: const Icon(Icons.email,color: AppColors.vert,),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      const SizedBox(height: 10,),
                      TextFormField(
                        initialValue: widget.user.password,

                        onChanged: (value) {
                          widget.user.password = value;
                        },
                        validator: (value){
                          if (value!.isEmpty) {
                            return "Vous devez entrer le nom";
                          }
                          return null;
                        },
                        obscureText: !visible,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(
                            color: AppColors.vert,
                          ),
                          labelText: 'Password',
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.vert,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.vert,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.rouge,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.rouge,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.all(12),
                          prefixIcon: const Icon(Icons.lock,color: AppColors.vert,),
                          suffixIcon: IconButton(
                            icon: Icon(
                              color: Colors.blue,
                              visible ? Icons.visibility_off : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                visible = !visible;
                              });
                            },
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ElevatedButton(
                              child: const Text("annuler"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.rouge,
                                  foregroundColor: AppColors.blanc,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ElevatedButton(
                              child: const Text("Modifier"),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  firebaseServiceUser.modifieruserp(widget.user.id_user,widget.user);
                                  Navigator.of(context).pop();

                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.vert,
                                  foregroundColor: AppColors.blanc,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            );
          }
    }


