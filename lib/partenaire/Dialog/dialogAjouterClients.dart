
import 'package:flutter/material.dart';

import '../../../style/colors.dart';
import '../../ModelP/Engagement.dart';
import '../../ModelP/FirebaseServiceClient.dart';
import '../../ModelP/FirebaseServiceEngagement.dart';
import '../../ModelP/UsersP.dart';
import '../../ModelP/clients.dart';
import '../../ModelP/regexvalid.dart';

class ajouteClients extends StatefulWidget {
  final FirebaseServiceClient firebaseService;
  final UserP user;
  const ajouteClients({super.key,required this.firebaseService,required this.user});

  @override
  State<ajouteClients> createState() => _ajouteClientsState();
}

class _ajouteClientsState extends State<ajouteClients> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseServiceEngagement firebaseService1=FirebaseServiceEngagement();
  final Client _client=Client(id: '', nom: '', prenom: '', numeroTelephone: '', email: '');

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.maxFinite,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  padding: const EdgeInsets.symmetric(horizontal:40,vertical: 10 ),
                  decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blueAccent),
                      color: AppColors.bleu
                  ),
                  child: Title(color: AppColors.bleu, child: const Text("Ajouter Client",style: TextStyle(color: AppColors.blanc,fontSize: 25),))),
              const SizedBox(height: 10,),
              TextFormField(
                onSaved: (value) {
                  _client.nom = value!;
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
                    color: AppColors.bleu,
                  ),
                  labelText: 'Nom de Client',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.bleu,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.bleu,
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
                  prefixIcon: const Icon(Icons.person,color: AppColors.bleu,),
                ),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                onSaved: (value) {
                  _client.prenom = value!;
                },
                validator: (value){
                  if (value!.isEmpty) {
                    return "Vous devez entrer le prenom";
                  }
                  return null;
                },
                obscureText: false,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(
                    color: AppColors.bleu,
                  ),
                  labelText: 'Prenom de Client',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.bleu,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.bleu,
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
                  prefixIcon: const Icon(Icons.person,color: AppColors.bleu,),
                ),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                onSaved: (value) {
                  _client.numeroTelephone = value!;
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
                    color: AppColors.bleu,
                  ),
                  labelText: 'Telephone',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.bleu,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.bleu,
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
                  prefixIcon: const Icon(Icons.phone,color: AppColors.bleu,),
                ),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                onSaved: (value) {
                  _client.email = value!;
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
                    color: AppColors.bleu,
                  ),
                  labelText: 'Email',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.bleu,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.bleu,
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
                  prefixIcon: const Icon(Icons.email,color: AppColors.bleu,),
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    label: const Text("annuler"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.rouge,
                        foregroundColor: AppColors.blanc,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  Spacer(),
                  ElevatedButton.icon(
                    label: const Text("Ajouter"),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();
                      _formKey.currentState!.save();
                      widget.firebaseService.ajouterClient(_client).then((clientId) {
                        if (widget.user.idProjet != null) {
                          Engagement engagement = Engagement(
                            id: '', // This will be auto-generated by Firestore
                            projetId: widget.user.idProjet!,
                            clientId: clientId, // Use the returned client ID
                          );
                          firebaseService1.ajouterEngagement(engagement);
                        }

                        // Close the dialog after successful addition
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Container(

                                padding: const EdgeInsets.all(15),
                                height: 110,
                                decoration: const BoxDecoration(
                                  color: AppColors.vert,
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Succès",style: TextStyle(fontSize: 20,color: AppColors.blanc),),
                                        SizedBox(width: 10,),
                                        Icon(Icons.done,color: AppColors.blanc,),
                                      ],
                                    ),
                                    Text("Le client est bien ajouté",style: TextStyle(fontSize: 15,color: AppColors.blanc),),
                                  ],
                                ),
                              ),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ));
                      }).catchError((error) {
                        print("Error adding client: $error");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Container(

                              padding: const EdgeInsets.all(15),
                              height: 80,
                              decoration: const BoxDecoration(
                                color: AppColors.vert,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text("erreur ",style: TextStyle(fontSize: 20,color: AppColors.blanc),),
                                      SizedBox(width: 10,),
                                      Icon(Icons.error,color: AppColors.blanc,),
                                    ],
                                  ),
                                  Text("Échec de l'ajout du client. Veuillez réessayer.",style: TextStyle(fontSize: 15,color: AppColors.blanc),),
                                ],
                              ),
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                          ),
                        );
                      });


                    }

                    },
                    icon: const Icon(Icons.add_business),
                    style: ElevatedButton.styleFrom(

                        backgroundColor: AppColors.vert,
                        foregroundColor: AppColors.blanc,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
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
