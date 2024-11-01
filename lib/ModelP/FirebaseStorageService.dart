import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final CollectionReference _userCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference _projetCollection = FirebaseFirestore.instance.collection('projets');


  Future<String> getImageUrl(String imageUrl) async {
    try {
      if (imageUrl.isNotEmpty) {
        final ref = _storage.ref().child(imageUrl);
        return await ref.getDownloadURL();
      }
    } catch (e) {
      print('Error getting image URL: $e');
    }
    return ''; // Return empty string if retrieval fails
  }
  Future<String> getProjetImageUrl(String imageUrl) async {
    try {
      if (imageUrl.isNotEmpty) {
        final ref = _storage.ref().child(imageUrl);
        return await ref.getDownloadURL();
      }
    } catch (e) {
      print('Error getting image URL: $e');
    }
    return ''; // Return empty string if retrieval fails
  }

  Future<void> uploadProfileImage(String userId, File imageFile) async {
    try {
      String imageName = 'profil_$userId.jpg';
      Reference ref = _storage.ref().child('profil').child(imageName);
      UploadTask uploadTask = ref.putFile(imageFile);

      // Attendez que le chargement soit terminé
      TaskSnapshot taskSnapshot = await uploadTask;

      // Obtenir l'URL de téléchargement du fichier
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      // Mettre à jour la référence de l'image dans la collection "users"
      await _userCollection.doc(userId).update({'photoUrl': imageUrl});

      // Supprimer l'image existante avec le nom précédent
      await _storage.ref().child('profil').child('$userId.jpg').delete();


    } catch (e) {
      print('Error uploading image: $e');
    }
  }
  Future<void> uploadProjetImage(String ProjetId, File imageFile) async {
    try {
      String imageName = 'profil_$ProjetId.jpg';
      Reference ref = _storage.ref().child('projetphoto').child(imageName);
      UploadTask uploadTask = ref.putFile(imageFile);

      // Attendez que le chargement soit terminé
      TaskSnapshot taskSnapshot = await uploadTask;

      // Obtenir l'URL de téléchargement du fichier
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      // Mettre à jour la référence de l'image dans la collection "users"
      await _projetCollection.doc(ProjetId).update({'photoUrl': imageUrl});

      // Supprimer l'image existante avec le nom précédent
      await _storage.ref().child('projetphoto').child('$ProjetId.jpg').delete();


    } catch (e) {
      print('Error uploading image: $e');
    }
  }
}