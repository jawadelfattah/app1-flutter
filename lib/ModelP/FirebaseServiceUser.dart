import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'UsersP.dart';


class FirebaseServiceUser {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UserP>> rechercheUserParEmailEtPassword(String email, String password) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();

      List<UserP> users = querySnapshot.docs.map((doc) {
        return UserP(
          id_user: doc.id,
          firstName: doc['firstName'],
          lastName: doc['lastName'],
          phoneNumber: doc['phoneNumber'],
          email: doc['email'],
          password: doc['password'],
          photoUrl: doc['photoUrl'],
          idProjet: doc['idProjet'],
          role: doc['role'],
        );
      }).toList();

      return users;
    } catch (e) {
      // Error handling
      print('Error during user search by email and password: $e');
      return []; // Return an empty list in case of error
    }
  }

  Future<String?> signInWithEmailAndPassword(String email, String password) async {
    try {
      // Sign in user with email and password
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      return null; // Return null for successful sign in
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "User not found.";
      } else if (e.code == 'wrong-password') {
        return "Incorrect password.";
      } else {
        return "An error occurred: ${e.message}";
      }
    }
  }
  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }



  Future<void> modifieruserp(String userId, UserP nouveauUser) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'firstNom': nouveauUser.firstName,
        'lastName': nouveauUser.lastName,
        'phoneNumber': nouveauUser.phoneNumber,
        'email': nouveauUser.email,
        'password': nouveauUser.password,
      });
    } catch (e) {
      print('Erreur lors de la modification du projet: $e');
    }
  }


  Future<List<UserP>> rechercheUserParid(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await _firestore.collection('users').doc(userId).get();
      if (userSnapshot.exists) {
        UserP user = UserP(
          id_user: userSnapshot.id,
          firstName: userSnapshot['firstName'],
          lastName: userSnapshot['lastName'],
          phoneNumber: userSnapshot['phoneNumber'],
          email: userSnapshot['email'],
          password: userSnapshot['password'],
          photoUrl: userSnapshot['photoUrl'],
          idProjet: userSnapshot['idProjet'],
          role: userSnapshot['role'],
        );
        return [user];
      } else {
        return []; // Return an empty list if the user is not found
      }
    } catch (e) {
      print('Error during user search by ID: $e');
      return []; // Return an empty list in case of error
    }
  }
  Future<Map<String, dynamic>?> getUserInfo(String userId) async {
    try {
      DocumentSnapshot userSnapshot = await _firestore.collection('users').doc(userId).get();

      if (userSnapshot.exists) {
        return userSnapshot.data() as Map<String, dynamic>?;
      } else {
        print('Document utilisateur non trouvé');
        return null;
      }
    } catch (e) {
      print('Erreur lors de la récupération des informations de l\'utilisateur : $e');
      return null;
    }
  }
  Future<UserP?> rechercheUserParId(String id) async {
    try {
      DocumentSnapshot docSnapshot = await _firestore.collection('users').doc(id).get();

      if (docSnapshot.exists) {
        return UserP(
          id_user: docSnapshot.id,
          firstName: docSnapshot['firstName'],
          lastName: docSnapshot['lastName'],
          phoneNumber: docSnapshot['phoneNumber'],
          email: docSnapshot['email'],
          photoUrl: docSnapshot['photoUrl'],
          idProjet: docSnapshot['idProjet'],
          role: docSnapshot['role'],
          password: docSnapshot['password'],
        );
      } else {
        // Utilisateur non trouvé
        return null;
      }
    } catch (e) {
      // Gestion des erreurs
      print('Erreur lors de la recherche d\'utilisateur par ID : $e');
      return null; // Retourner null en cas d'erreur
    }
  }

}
