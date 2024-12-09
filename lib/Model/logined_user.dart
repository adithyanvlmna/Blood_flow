import 'package:cloud_firestore/cloud_firestore.dart';

class LoginedUser {
  final String name;
  final String phone;
  final String email;
  LoginedUser({required this.name, required this.phone, required this.email});
  Map<String, dynamic> toMap() {
    return {
      "Email": email,
      "Name": name,
      "Phone": phone,
    };
  }

  factory LoginedUser.fomMap(QueryDocumentSnapshot doc) {
    return LoginedUser(
        name: doc.get("Email"),
        phone: doc.get("Name"),
        email: doc.get("Phone"));
  }
}
