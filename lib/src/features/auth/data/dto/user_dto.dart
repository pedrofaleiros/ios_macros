import 'dart:convert';

class UserDTO {
  final String? email;
  final String name;
  final String password;

  UserDTO({
    required this.name,
    this.email,
    required this.password,
  });

  UserDTO copyWith({
    String? name,
    String? email,
    String? password,
  }) {
    return UserDTO(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email ?? '', 'password': password};
  }

  factory UserDTO.fromMap(Map<String, dynamic> map) {
    return UserDTO(
        name: map['name'], email: map['email'], password: map['password']);
  }

  factory UserDTO.fromJson(String jsonData) {
    return UserDTO.fromMap(
      json.decode(jsonData),
    );
  }

  String toJson() => json.encode(toMap());

  bool validatePassword() {
    if (password.length < 8) {
      return false;
    }

    return true;
  }

  bool validateName() {
    if (name.length > 30 || name == '') {
      return false;
    }
    return true;
  }

  bool validateEmail() {
    if (email == null || email!.length > 30 || email == '') {
      return false;
    }
    return true;
  }
}
