import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thriftly/helpers/firebase_functions.dart';

class ItemListingProvider {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getOutfitInspos() async {
    List<Map<String, dynamic>> postsMetaData = [];
    await firestore.collection("outfits").get().then((querySnapshot) {
      querySnapshot.docs.forEach((document) {
        print(document);
        postsMetaData.add(document.data());
      });
    });

    print(postsMetaData);

    return postsMetaData;
  }

  Future<void> acceptPost(String postUid) async {
    User? user = await getAccountDetails();
    var list = [user!.uid];
    await firestore
        .collection("posts")
        .doc(postUid)
        .update({"volunteers": FieldValue.arrayUnion(list)});
  }

  Future<User?> getAccountDetails() async {
    return FirebaseAuth.instance.currentUser;
  }

  Future<bool> setBio(String bio) async {
    try {
      User? user = await getAccountDetails();
      await firestore.collection("users").doc(user!.uid).set({
        "bio": bio,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>?> getPostByUid(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection("posts").doc(uid).get();

    return snapshot.data();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> createItemListing({
    required String title,
    required String description,
    required Timestamp createdAt,
    required File imageFile,
    required String location,
    required String price,
    required String size,
    required String creator,
  }) async {
    String imageFileUrl = await uploadImageToFirebase(imageFile);

    DocumentReference<Map<String, dynamic>> post =
        await firestore.collection("items").add({
      "title": title,
      "description": description,
      "createdAt": createdAt,
      "imageUrl": imageFileUrl,
      "size": size,
      "price": price,
      "location": location,
      "creator": creator,
    });

    await firestore.collection("items").doc(post.id).set({
      "uid": post.id,
    }, SetOptions(merge: true));

    return post.get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> createOutfitInspo({
    required String caption,
    required Timestamp createdAt,
    required File imageFile,
    required String creator,
  }) async {
    String imageFileUrl = await uploadImageToFirebase(imageFile);

    DocumentReference<Map<String, dynamic>> post =
        await firestore.collection("outfits").add({
      "caption": caption,
      "createdAt": createdAt,
      "imageUrl": imageFileUrl,
      "creator": creator,
    });

    await firestore.collection("outfits").doc(post.id).set({
      "uid": post.id,
    }, SetOptions(merge: true));

    return post.get();
  }

  Future<List<Map<String, dynamic>>> getItemListings() async {
    List<Map<String, dynamic>> itemsMetaData = [];
    await firestore.collection("items").get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        itemsMetaData.add(doc.data());
      });
    });

    return itemsMetaData;
  }
}
