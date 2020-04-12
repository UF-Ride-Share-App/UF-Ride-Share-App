import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> getCurrentUser() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user = await _auth.currentUser();
  final uid = user.uid;
  return uid;
}

User userFromJson(String str) {
  final jsonData = json.decode(str);
  return User.fromJson(jsonData);
}

String userToJson(User data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class User {
  String id;
  String name;
  String photoUrl;
  String email;

  User(String id, String name, String photoUrl, String email) {
    this.id = id;
    this.name = name;
    this.photoUrl = photoUrl;
    this.email = email;
  }

  factory User.fromJson(Map<String, dynamic> json) => new User(
        json["id"],
        json["name"],
        json["photoUrl"],
        json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photoUrl": photoUrl,
        "email": email,
      };
}