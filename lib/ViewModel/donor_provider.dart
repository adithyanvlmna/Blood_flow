import 'dart:io';

import 'package:blood_donation_app/Firebase_DB/crud.dart';
import 'package:blood_donation_app/Model/donators.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DonorProvider extends ChangeNotifier {
  List<Donators> users = [];
  List<Donators> get usersGetter => users;
  late List<QueryDocumentSnapshot> doccuments;
  File? _image;
  File? get imageGetter => _image;
  final ImagePicker _picker = ImagePicker();
  Future<void> getUsers() async {
    CollectionOperations.getAllDocumets("Donors").then((value) {
      doccuments = value;
      List<Donators> finalResponse =
          doccuments.map((mapdata) => Donators.fomMap(mapdata)).toList();
      users = finalResponse;
      notifyListeners();
    });
  }

  Future<void> deleteUser(String id) async {
    await CollectionOperations.deleteDocumet("Donors", id);
    notifyListeners();
  }

  Future<void> pickImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);

      await prefs.setString('imagePath', pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('imagePath');
    if (imagePath != null) {
      _image = File(imagePath);
      notifyListeners();
    }
  }

  void deleteimage() {
    _image = null;
    notifyListeners();
  }
}
