import 'package:cloud_firestore/cloud_firestore.dart';

class Donators {
  final String name;
  final String bloodGroup;
  final String phnone;
  String? id;
  Donators(
     {
    required this.name,
    required this.bloodGroup,
    required this.phnone,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "BloodGroup": bloodGroup,
      "Phone": phnone,
    };
  }

  factory Donators.fomMap(QueryDocumentSnapshot doc) {
    return Donators(
        name: doc.get("name"),
        bloodGroup: doc.get("BloodGroup"),
        phnone: doc.get("Phone"),id: doc.id);
  }
}
