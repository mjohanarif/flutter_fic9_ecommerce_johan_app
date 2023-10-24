import 'dart:convert';

class LoginRequestModel {
  final String password;
  final String identifier;

  LoginRequestModel({
    required this.password,
    required this.identifier,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'password': password,
      'identifier': identifier,
    };
  }

  String toJson() => json.encode(toMap());
}
