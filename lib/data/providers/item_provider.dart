import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ItemProvider {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getItems() async {
    List<Map<String, dynamic>> itemsMetaData = [];
    await firestore.collection("items").get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        itemsMetaData.add(doc.data());
      });
    });

    return itemsMetaData;
  }
}