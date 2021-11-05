import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserInfo(String email) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get()
        .catchError((e) {
      // ignore: avoid_print
      print(e.toString());
    });
  }

  Future getByEmailNotes(String email) async {
    // ignore: avoid_print
    print("getByEmailNotes:" + email);
    return FirebaseFirestore.instance
        .collection("notes")
        .where("email", isEqualTo: email)
        .snapshots();
  }

  Future getByDocIdDoneUpdate(dataMap, id) async {
    return FirebaseFirestore.instance
        .collection("notes")
        .doc(id)
        .update(dataMap);
  }

  Future getByDocIdTokenUpdate(dataMap, id) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .update(dataMap);
  }

  Future addNote(dataMap) async {
    // ignore: avoid_print
    print("Eklendi");
    return FirebaseFirestore.instance.collection("notes").add(dataMap);
  }

  Future delNote(id) async {
    // ignore: avoid_print
    print(id + " Silindi");
    return FirebaseFirestore.instance.collection("notes").doc(id).delete();
  }
}
