import 'package:cloud_firestore/cloud_firestore.dart';

import 'clients.dart';



class FirebaseServiceClient {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //************client************
  Future<String> ajouterClient(Client client) async {
    try {
      DocumentReference docRef = await _firestore.collection('clients').add(client.toJson());
      return docRef.id; // Return the ID of the added client
    } catch (e) {
      print('Erreur lors de l\'ajout du client: $e');
      throw e; // Rethrow the error
    }
  }


  Future<List<Client>> rechercherClientParemail(String email) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('clients')
          .where('email', isEqualTo: email)
          .get();

      return querySnapshot.docs.map((doc) {
        return Client(
          id: doc.id,
          nom: doc['nom'],
          prenom: doc['prenom'],
          numeroTelephone: doc['numeroTelephone'],
          email: doc['email'],
        );
      }).toList();
    } catch (e) {
      print('Erreur lors de la recherche des clients: $e');
      return [];
    }
  }

  Future<void> supprimerClient(String clientId) async {
    try {
      await _firestore.collection('clients').doc(clientId).delete();
    } catch (e) {
      print('Erreur lors de la suppression du client: $e');
    }
  }
  Future<void> modifierClient(String clientId, Client nouveauClient) async {
    try {
      await _firestore.collection('clients').doc(clientId).update({
        'nom': nouveauClient.nom,
        'prenom': nouveauClient.prenom,
        'numeroTelephone': nouveauClient.numeroTelephone,
        'email': nouveauClient.email,
      });
    } catch (e) {
      print('Erreur lors de la modification du client: $e');
    }
  }

  Future<List<Client>> getClientsForProject(String projectId) async {
    try {
      // First, query engagements for the given project
      QuerySnapshot engagementSnapshot = await _firestore
          .collection('engagements')
          .where('projetId', isEqualTo: projectId)
          .get();

      // Extract client IDs from engagements
      List clientIds = engagementSnapshot.docs.map((doc) => doc['clientId']).toList();

      // Use client IDs to query clients
      QuerySnapshot clientSnapshot = await _firestore
          .collection('clients')
          .where(FieldPath.documentId, whereIn: clientIds)
          .get();

      // Map client documents to Client objects
      return clientSnapshot.docs.map((doc) {
        return Client(
          id: doc.id,
          nom: doc['nom'],
          prenom: doc['prenom'],
          numeroTelephone: doc['numeroTelephone'],
          email: doc['email'],
        );
      }).toList();
    } catch (e) {
      print('Error fetching clients for project: $e');
      throw e;
    }
  }

}




