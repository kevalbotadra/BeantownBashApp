import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:thriftly/data/models/thriftlyuser.dart';

Future<ThriftlyUser> getAnyUserFromFirebaseUserUid(String userUID) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  DocumentReference doc = users.doc(userUID);
  DocumentSnapshot snapshot = await doc.get();
  final finalUser = ThriftlyUser.lessFromSnapshot(snapshot);
  return finalUser;
}

Future<ThriftlyUser> getCurrentUserFromFirebaseUser(User? user) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  if (user != null) {
    DocumentReference doc = users.doc(user.uid);
    DocumentSnapshot snapshot = await doc.get();
    print('here currentuserfromfirebase');
    ThriftlyUser finalUser = ThriftlyUser.lessFromSnapshot(snapshot);
    return finalUser;
  }
  return new ThriftlyUser(isValid: false);
}

// Future<List<NsksUser>> getVolunteersByPost(Map<String, dynamic> doc) async {
//   List<NsksUser> volunteers = [];
//   List uidList = doc["volunteers"];
//   for (String uid in uidList) {
//     NsksUser user = await getAnyUserFromFirebaseUserUid(uid);
//     volunteers.add(user);
//   }
//   return volunteers;
// }

// Future<List<Post>> getPostsbyVolunteer(String uid) async {
//   List<Post> volunteerPosts = [];
//   List<Map<String, dynamic>> postsMetaData = [];
//   await FirebaseFirestore.instance
//       .collection("posts")
//       .get()
//       .then((querySnapshot) {
//     querySnapshot.docs.forEach((document) {
//       postsMetaData.add(document.data());
//     });
//   });

//   for (Map<String, dynamic> post in postsMetaData) {
//     for (String volunteerUid in post["volunteers"]) {
//       if (volunteerUid == uid) {
//         List<NsksUser> volunteers = await getVolunteersByPost(post);
//         volunteerPosts.add(Post.fromMap(post, volunteers));
//       }
//     }
//   }

//   return volunteerPosts;
// }

Future<String> uploadImageToFirebase(File imageFile) async {
  String filename = imageFile.path;
  Reference ref = FirebaseStorage.instance.ref(filename);
  await ref.putFile(
    imageFile,
  );

  return ref.getDownloadURL();
}

Timestamp dateTimeToTimestamp(DateTime dateTime) {
  return Timestamp.fromMillisecondsSinceEpoch(dateTime.millisecondsSinceEpoch);
}
