import 'package:cloud_firestore/cloud_firestore.dart';

import 'Projets.dart';

class FirebaseServiceProjet {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //***********projet************
  Future<void> modifierProjet(String projetId, Projet nouveauProjet) async {
    try {
      await _firestore.collection('projets').doc(projetId).update({
        'nomProjet': nouveauProjet.nomProjet,
        'numeroTelephone': nouveauProjet.numeroTelephone,
        'email': nouveauProjet.email,
        'photoUrl': nouveauProjet.photoUrl,
        'projetUrl': nouveauProjet.projetUrl,
      });
    } catch (e) {
      print('Erreur lors de la modification du projet: $e');
    }
  }

  Future<Projet?> getprojetInfo(String projetId) async {
    try {
      DocumentSnapshot docSnapshot = await _firestore.collection('projets').doc(projetId).get();
      if (docSnapshot.exists) {
        return Projet(
          id: docSnapshot.id,
          nomProjet: docSnapshot['nomProjet'],
          numeroTelephone: docSnapshot['numeroTelephone'],
          email: docSnapshot['email'],
          photoUrl: docSnapshot['photoUrl'],
          projetUrl: docSnapshot['projetUrl'],
        );
      } else {
        return null;
      }
    } catch (e) {
      print('Erreur lors de la récupération des informations de projet : $e');
      return null;
    }
  }
  Future<List<Projet>> rechercherProjetParId(String id) async {
    try {
      DocumentSnapshot docSnapshot = await _firestore.collection('projets').doc(id).get();
      if (docSnapshot.exists) {
        Projet projet = Projet(
          id: docSnapshot.id,
          nomProjet: docSnapshot['nomProjet'],
          numeroTelephone: docSnapshot['numeroTelephone'],
          email: docSnapshot['email'],
          photoUrl: docSnapshot['photoUrl'],
          projetUrl: docSnapshot['projetUrl'],
        );
        return [projet];
      } else {
        return [];
      }
    } catch (e) {
      print('Erreur lors de la recherche du projet: $e');
      return [];
    }
  }




}
