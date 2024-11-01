import 'dart:io';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../ModelP/FirebaseServiceProjet.dart';
import '../ModelP/FirebaseServiceUser.dart';
import '../ModelP/FirebaseStorageService.dart';
import '../ModelP/Projets.dart';
import '../ModelP/UsersP.dart';
import '../ModelP/regexvalid.dart';
import '../style/colors.dart';

class ProfilView extends StatefulWidget {
  final UserP user;
  final Projet projet;
  final FirebaseServiceUser firebaseServiceUser;
  final FirebaseStorageService storageService;


  const ProfilView({super.key, required this.firebaseServiceUser, required this.storageService ,required this.user, required this.projet, });

  @override
  State<ProfilView> createState() => _ProfilState();
}


class _ProfilState extends State<ProfilView> {
  bool _isUploading = false;
  late UserP _user;
  late Projet projet;
  User? user1 = FirebaseAuth.instance.currentUser;
  FirebaseServiceProjet firebaseServiceProjet=FirebaseServiceProjet();
  FirebaseServiceUser firebaseServiceUser=FirebaseServiceUser();

  void _showDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(

          title: const Text('Confirmation :', style: TextStyle(fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black),),
          content: const Text('Voulez-vous changer la photo de profil ?',
            style: TextStyle(fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black),),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.vert,
                  foregroundColor: AppColors.blanc,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            ElevatedButton(
              onPressed: () {
                getImage();
                Navigator.of(context).pop();

              },
              child: const Text('Changer'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.rouge,
                  foregroundColor: AppColors.blanc,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ],
        );
      },
    );
  }
  @override
  void initState() {
    super.initState();
    projet=widget.projet;
    loaduser();
  }
  void loaduser(){
    _user = widget.user;
  }
  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);// Use gallery as image source, you can change it to camera if needed


    if (pickedFile != null) {
      setState(() {
        _isUploading = true;
      });
      // Upload selected image
      File imageFile = File(pickedFile.path);
      await _uploadImage(imageFile);
      setState(() {
        _isUploading = false;
      });
    } else {
      print('No image selected.');
    }
  }

  // Function to upload image
  Future<void> _uploadImage(File imageFile) async {
    // Retrieve userId, you need to replace 'userId' with your actual userId
    String? userId = user1?.uid ;

    // Call uploadProfileImage method from FirebaseStorageService
    await widget.storageService.uploadProfileImage(userId!, imageFile);

    /// Retrieve updated user data from Firestore
    Map<String, dynamic>? userData = await widget.firebaseServiceUser.getUserInfo(user1!.uid);
    if (userData != null) {
      // Update user object with new photoUrl
      setState(() {
        _user.photoUrl = userData['photoUrl'];
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    String nom=_user.firstName;
    String prenom=_user.lastName;
    String tel=_user.phoneNumber;
    String image=_user.photoUrl;
    String email=_user.email;
    return SingleChildScrollView(
      child:Container(
      width: MediaQuery.of(context).size.width,
      height:  MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width*0.9,
                height:  MediaQuery.of(context).size.height*0.1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: AppColors.bleu,
                ),
                child: Center(
                  child: Text(
                    "PROFILE",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width*0.9,
              height:  MediaQuery.of(context).size.height*0.66,
              padding: EdgeInsets.fromLTRB(10, 20, 5, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        child: GestureDetector(
                          onTap:(){ _showDialog(context);},
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: image != null ? NetworkImage(image) : const NetworkImage("https://firebasestorage.googleapis.com/v0/b/cinq-etoiles-f2bce.appspot.com/o/profil%2Fdefault_imag.png?alt=media&token=2746acb3-e5cd-4218-a036-e2372b93e3fa"),
                                radius: 70,
                              ),
                              if (_isUploading)
                                CircularProgressIndicator(
                                  strokeCap: StrokeCap.round,
                                  strokeAlign: 10,
                                  strokeWidth: 9.0,
                                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.bleu,),
                                  backgroundColor: AppColors.jaune,
                                ), // Show CircularProgressIndicator while uploading
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal:20,vertical:20),
                        child: ElevatedButton.icon(
                          label: Text("Modifier",style: TextStyle(fontSize: 12),),
                          onPressed: ()   {
                             _showEditDialog(context);
                          },
                          icon: Icon(Icons.edit),
                          style: ElevatedButton.styleFrom(
                            fixedSize:Size.fromWidth( MediaQuery.of(context).size.width*0.4,),
                            backgroundColor: AppColors.vert,
                            foregroundColor: AppColors.blanc,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(  height:20,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10,),
                      Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                          shape: BoxShape.circle,
                          color: AppColors.rouge,
                        ),
                        child: Icon(
                          Icons.person,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Text(
                          "Nom : ",
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                      ),
                      Spacer(),
                      Text(
                        nom,
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10,),
                      Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                          shape: BoxShape.circle,
                          color: AppColors.rouge,
                        ),
                        child: Icon(
                          Icons.person,
                          size: 20,
                          color: AppColors.blanc,
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Text(
                          "Prenom : ",
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                      ),
                      Spacer(),
                      Text(
                        prenom,
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10,),
                      Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                          shape: BoxShape.circle,
                          color: AppColors.vert,
                        ),
                        child: Icon(
                          Icons.phone,
                          size: 20,
                          color: AppColors.blanc,
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Text(
                          "Téléphone : ",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Text(
                        tel,
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10,),
                      Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                          shape: BoxShape.circle,
                          color: AppColors.jaune,
                        ),
                        child: Icon(
                          Icons.email,
                          size: 20,
                          color: AppColors.blanc,
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Text(
                          "Adresse-email : ",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Text(
                        email,
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      SizedBox(width: 20),
                    ],
                  )
                  ,SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10,),
                      Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                          shape: BoxShape.circle,
                          color: AppColors.jaune,
                        ),
                        child: Icon(
                          Icons.business_center,
                          size: 20,
                          color: AppColors.blanc,
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Text(
                          "Nom de projet ",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Text(
                        projet.nomProjet,
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal:10,vertical:10),
                    child: ElevatedButton.icon(
                      label: Text("Se Déconnecter",style: TextStyle(fontSize: 12),),
                      onPressed: ()   {
                        firebaseServiceUser.signOut();
                      },
                      icon: Icon(Icons.logout),
                      style: ElevatedButton.styleFrom(
                        fixedSize:Size.fromWidth( MediaQuery.of(context).size.width,),
                        backgroundColor: AppColors.rouge,
                        foregroundColor: AppColors.blanc,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),


          ],
        ),
      ),
    ));
  }
  void _showEditDialog(BuildContext context){
    final _formKey = GlobalKey<FormState>();
    String nom=_user.firstName;
    String tel=_user.phoneNumber;
    String prenom=_user.lastName;
    String email=_user.email;
    showDialog(
        context: context,
        builder: (BuildContext context){
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
                        child: Title(color: AppColors.bleu, child: const Text("Modifier Projet",style: TextStyle(color: AppColors.blanc,fontSize: 25,fontWeight: FontWeight.bold),))),
                    const SizedBox(height: 10,),
                    TextFormField(
                      initialValue: _user.firstName,
                      onChanged: (value) {
                        nom= value;
                      },
                      validator: (value){
                        if (value!.isEmpty) {
                          return "Vous devez entrer le nom de projet";
                        }
                        return null;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                          color: AppColors.vert,
                        ),
                        labelText: 'Nom',
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
                    SizedBox(height: 10,),
                    TextFormField(
                      initialValue: _user.lastName,
                      onChanged: (value) {
                        prenom= value;
                      },
                      obscureText: false,
                      validator: (value){
                        if (value!.isEmpty) {
                          return "Vous devez entrer le URL de projet";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(
                          color: AppColors.vert,
                        ),
                        labelText: 'URL',
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
                      initialValue: _user.phoneNumber,
                      onChanged: (value) {
                        tel= value;
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
                      initialValue:_user.email,
                      onChanged: (value) {
                        email = value;
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
                    Row(
                      children: [
                        ElevatedButton(
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
                        Spacer(),
                        ElevatedButton(
                          child: const Text("Modifier"),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _user.firstName=nom;
                                _user.lastName=prenom;
                                _user.phoneNumber=tel;
                                _user.email=email;
                              });
                              firebaseServiceUser.modifieruserp(_user.id_user, _user);
                              loaduser();
                              Navigator.of(context).pop();
                            }
                          },
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
    );
  }


}

