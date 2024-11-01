class UserP {
  String id_user;
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  String password;
  String photoUrl;
  String idProjet;
  String role;

  UserP({
    required this.id_user,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.photoUrl,
    required this.idProjet,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
      'photoUrl': photoUrl,
      'idProjet': idProjet,
      'role': role,
    };
  }

  factory UserP.fromJson(Map<String, dynamic> json) {
    return UserP(
      id_user: json['id_user'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      password: json['password'],
      photoUrl: json['photoUrl'],
      idProjet: json['idProjet'],
      role: json['role'],
    );
  }
}