import 'package:cloud_firestore/cloud_firestore.dart';
import 'Engagement.dart';

class FirebaseServiceEngagement {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //************engagement************

  // Method to add an engagement to Firestore
  Future<void> ajouterEngagement(Engagement engagement) async {
    try {
      await _firestore.collection('engagements').add(engagement.toJson());
    } catch (e) {
      print('Erreur lors de l\'ajout de l\'engagement: $e');
    }
  }

  // Method to delete an engagement from Firestore
  Future<void> supprimerEngagement(String idclient) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('engagements')
          .where('clientId', isEqualTo: idclient)
          .get();

      for (DocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
      print('Engagement supprimé avec succès');
    } catch (e) {
      print('Erreur lors de la suppression de l\'engagement: $e');
    }
  }

  Future<List<Engagement>> getEngament(String idProjet) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('engagements')
        .where('idProjet', isEqualTo: idProjet)
        .get();

    List<Engagement> engagements = snapshot.docs.map((doc) {
      return Engagement(
        id: doc.id,
        projetId: doc['projetId'],
        clientId: doc['clientId'],
      );
    }).toList();

    return engagements;
  }


}
