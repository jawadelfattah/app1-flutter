
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../../ModelP/regexvalid.dart';
import '../../style/colors.dart';
import 'CustomSnackBar.dart';

class showEditPasswordDialog extends StatefulWidget {

  const showEditPasswordDialog({super.key,});

  @override
  State<showEditPasswordDialog> createState() => _showEditPasswordDialogState();
}

class _showEditPasswordDialogState extends State<showEditPasswordDialog> {
  final formKey = GlobalKey<FormState>();
  bool _visible = false;
  bool _visible2 = false;
  TextEditingController mmdp =TextEditingController();
  User? user1 = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      backgroundColor: AppColors.blanc,
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  padding: const EdgeInsets.symmetric(horizontal:40,vertical: 10 ),
                  decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.vert
                  ),
                  child: const Text("Modifier\nMot de Pass",textAlign: TextAlign.center,style: TextStyle(color: AppColors.blanc,fontSize: 25),)),
              const SizedBox(height: 10,),

              const SizedBox(height: 10,),
              TextFormField(
                controller: mmdp,
                validator: (newvalue) {
                  if (newvalue!.isEmpty) {
                    return "Vous devez entrer un nouveau mot de passe";
                  } else if (!Validator.isValidPassword(newvalue)) {
                    return 'Le mot de passe doit contenir : \n'
                        '* Au moins une majuscule\n'
                        '* Au moins une minuscule\n'
                        '* Au moins un chiffre\n'
                        '* Au moins un caractère spécial\n'
                        '* Au moins 8 caractères';
                  } else {
                    return null; // Mot de passe valide
                  }
                },
                obscureText: !_visible,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(
                    color: AppColors.bleu,
                  ),
                  labelText: 'Mot de passe',
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
                  prefixIcon: const Icon(Icons.lock,color: AppColors.bleu,),
                  suffixIcon: IconButton(
                    icon: Icon(
                      color: Colors.blue,
                      _visible ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _visible = !_visible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              TextFormField(
                validator: (vvalue){
                  if (vvalue!.isEmpty) {
                    return 'Vous devez Confirmer votre Mot de passe';
                  }else if(vvalue!=mmdp.text){
                    return 'la confirmation incorrecte';
                  }
                  return null;
                },
                obscureText: !_visible2,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(
                    color: AppColors.bleu,
                  ),
                  labelText: 'Confirmer votre Mot de passe',
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
                  prefixIcon: const Icon(Icons.lock,color: AppColors.bleu,),
                  suffixIcon: IconButton(
                    icon: Icon(
                      color: Colors.blue,
                      _visible2 ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _visible2 = !_visible2;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.rouge,
                          foregroundColor: AppColors.blanc,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Text("annuler"),
                    ),
                  ),
                  Padding(
                    padding:  const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          String newPassword = mmdp.text.trim();
                          try {
                            await FirebaseAuth.instance.currentUser?.updatePassword(newPassword);
                            await FirebaseFirestore.instance.collection('users').doc(user1?.uid).update({'password': newPassword});
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Mot de passe modifié avec succès'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.of(context).pop(); // Close the dialog
                          } catch (e) {
                            // Show a snackbar with the error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Erreur lors de la modification du mot de passe : ${user1!.uid}'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.vert,
                          foregroundColor: AppColors.blanc,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Text("Modifier"),
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
