import 'package:cloud_firestore/cloud_firestore.dart';

class DBManager {
  final Firestore _firestore = Firestore.instance;

  void createRecord() async {
    await _firestore.collection("books").document("1").setData({
      'title': 'Mastering Flutter',
      'description': 'Programming Guide for Dart'
    });

    DocumentReference ref = await _firestore.collection("books").add({
      'title': 'Flutter in Action',
      'description': 'Complete Programming Guide to learn Flutter'
    });
    print(ref.documentID);
  }

  void getData() {
    _firestore
        .collection("Rides")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }

  void updateData() {
    try {
      _firestore
          .collection('books')
          .document('1')
          .updateData({'description': 'Head First Flutter'});
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteData() {
    try {
      _firestore.collection('books').document('1').delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
