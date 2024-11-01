
class Engagement {
  String id;
  String projetId;
  String clientId;

  Engagement({
    required this.id,
    required this.projetId,
    required this.clientId,
  });

  Map<String, dynamic> toJson() {
    return {
      'projetId': projetId,
      'clientId': clientId,
    };
  }

  factory Engagement.fromJson(Map<String, dynamic> json) {
    return Engagement(
      id: json['id'],
      projetId: json['projetId'],
      clientId: json['clientId'],
    );
  }

}
