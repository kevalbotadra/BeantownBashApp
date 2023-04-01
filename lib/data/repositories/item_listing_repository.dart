import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thriftly/data/models/thriftlyuser.dart';
import 'package:thriftly/data/providers/item_listing_provider.dart';
import 'package:thriftly/helpers/firebase_functions.dart';

class ItemListingRepository {
  final ItemListingProvider _itemListingProvider;
  ItemListingRepository(this._itemListingProvider);

  // Future<Post> createPost(String title, String body, XFile image,
  //     String endDate, String tags) async {
  //   String postJson = await _postProvider.createPost(
  //       title: title, image: image, body: body, endDate: endDate, tags: tags);
  //   final post = Post.fromJson(jsonDecode(postJson));
  //   return post;
  // }

  // Future<List<Post>> getPosts() async {
  //   List<Map<String, dynamic>> postsMetaData = await _postProvider.getPosts();
  //   List<Map<String, dynamic>> docs = [];
  //   List<Post> posts = [];

  //   postsMetaData.map((doc) {
  //     docs.add(doc);
  //   }).toList();

  //   for (Map<String, dynamic> doc in docs) {
  //     List<NsksUser> volunteers = await getVolunteersByPost(doc);
  //     posts.add(Post.fromMap(doc, volunteers));
  //   }
  //   return posts;
  // }

  // // Future<void> deletePost(int id) async {
  // //   await _postProvider.deletePost(id);
  // // }

  // Future<void> acceptPost(String id) async {
  //   await _postProvider.acceptPost(id);
  // }

  // Future<NsksUser> getAccountDetails() async {
  //   User? userInfo = await _postProvider.getAccountDetails();

  //   CollectionReference users = FirebaseFirestore.instance.collection('users');

  //   DocumentReference doc = users.doc(userInfo!.uid);
  //   DocumentSnapshot snapshot = await doc.get();

  //   List<Post> volunteerPosts = await getPostsbyVolunteer(snapshot["uid"]);

  //   NsksUser finalUser = NsksUser.fullFromSnapshot(snapshot, volunteerPosts);

  //   return finalUser;
  // }

  // Future<void> setNewBio(String bio) async {
  //   await _postProvider.setBio(bio);
  // }

  // Future<Post> getPostByUid(String uid) async {
  //   List<NsksUser> volunteers = [];
  //   Map<String, dynamic>? doc = await _postProvider.getPostByUid(uid);
  //   List uidList = doc!["volunteers"];
  //   for (String uid in uidList) {
  //     print(uid);
  //     NsksUser user = await getAnyUserFromFirebaseUserUid(uid);
  //     volunteers.add(user);
  //   }
  //   return Post.fromMap(doc, volunteers);
  // }

  Future<void> createItemListing({
    required String title,
    required String description,
    required String size,
    required File imageFile,
    required String price,
    required String location,
    required ThriftlyUser creator,
  }) async {
    Timestamp createdAtStamp = dateTimeToTimestamp(DateTime.now());


    await _itemListingProvider.createItemListing(
        title: title,
        description: description,
        size: size,
        price: price,
        createdAt: createdAtStamp,
        imageFile: imageFile,
        location: location,
        creator: creator.uid,
        );
  }
}
