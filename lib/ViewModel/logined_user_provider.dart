import 'package:blood_donation_app/Firebase_DB/crud.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginedUserProvider extends ChangeNotifier {
  String? name;
  String? get nameGetter => name;
  String? email;
  String? get emailGetter => email;
  String? phone;
  String? get phoneGetter => phone;
  Future<void> getSingleUser() async {
    final pref = await SharedPreferences.getInstance();
    String? id = pref.getString("DoccId");
    DocumentSnapshot data;
    CollectionOperations.getSingleDocument(id!, "Logineduser").then((value) {
      data = value;

      name = data.get("Name");
      email = data.get("Email");
      phone = data.get("Phone");
      notifyListeners();
    });
  }
}
