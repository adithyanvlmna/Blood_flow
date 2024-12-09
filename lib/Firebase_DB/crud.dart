import 'package:cloud_firestore/cloud_firestore.dart';

class CollectionOperations {
  static Future<CollectionReference<Object?>> createCollection(
      String collectionName) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection(collectionName);
    return users;
  }

  static Future<DocumentReference<Object?>> addDocumentToCollection(
      CollectionReference collection, Map<String, dynamic> data) async {
    DocumentReference docRef = await collection.add(data);
    return docRef;
  }

  static Future<List<QueryDocumentSnapshot<Object?>>> getAllDocumets(String collectionName) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection(collectionName);
    QuerySnapshot querySnapshot = await users.get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    return documents;
  }

  static Future<DocumentSnapshot<Object?>> getSingleDocument(
      String documentId, String collectionName) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection(collectionName).doc(documentId);
    DocumentSnapshot<Object?> docSnapshot = await docRef.get();
    return docSnapshot;
  }

  static Future <void> updateDocumet(
      String collectionName, String documentId,Map <String,dynamic> data) async {
          final CollectionReference users =
        FirebaseFirestore.instance.collection(collectionName);
    DocumentReference docRef = users.doc(documentId);
    await docRef.update(data);
  }

  static Future <void> deleteDocumet(
      String collectionName, String documentId) async {
         final CollectionReference users =
        FirebaseFirestore.instance.collection(collectionName);
    DocumentReference docRef = users.doc(documentId);
    await docRef.delete();
  }
}