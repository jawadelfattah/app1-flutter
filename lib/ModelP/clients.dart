class Client {
  String id;
  String nom;
  String prenom;
  String numeroTelephone;
  String email;

  Client({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.numeroTelephone,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'prenom': prenom,
      'numeroTelephone': numeroTelephone,
      'email': email,
    };
  }

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      numeroTelephone: json['numeroTelephone'],
      email: json['email'],

    );
  }
}
