
class Projet {
  String id;
  String nomProjet;
  String numeroTelephone;
  String email;
  String photoUrl;
  String projetUrl;

  Projet({
    required this.id, // Laisser id sans valeur initiale
    required this.nomProjet,
    required this.numeroTelephone,
    required this.email,
    required this.photoUrl,
    required this.projetUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'nomProjet': nomProjet,
      'numeroTelephone': numeroTelephone,
      'email': email,
      'photoUrl': photoUrl,
      'projetUrl': projetUrl,
    };
  }

  factory Projet.fromJson(Map<String, dynamic> json) {
    return Projet(
      id: json['id'],
      nomProjet: json['nomProjet'],
      numeroTelephone: json['numeroTelephone'],
      email: json['email'],
      photoUrl: json['photoUrl'],
      projetUrl: json['projetUrl'],
    );
  }
}

