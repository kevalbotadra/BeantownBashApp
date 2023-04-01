import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thriftly/data/models/thriftlyuser.dart';

class ItemListing {
  final String uniqueId;
  final String title;
  final ThriftlyUser creator;
  final String imageUrl;
  final String description;
  final String createdAt;
  final String price;
  final String size;
  final String location;

  ItemListing(
      {required this.uniqueId,
      required this.title,
      required this.creator,
      required this.imageUrl,
      required this.description,
      required this.size,
      required this.createdAt,
      required this.location,
      required this.price});

  factory ItemListing.fromJson(Map<String, dynamic> json) {
    return ItemListing(
      uniqueId: json["uid"],
      title: json["title"],
      imageUrl: json["imageUrl"] ?? "no image url",
      description: json["description"],
      size: json["size"],
      createdAt: json["createdAt"].toDate().toString(),
      location: json["location"],
      price: json["price"],
      creator: new ThriftlyUser(isValid: false),
    );
  }

  factory ItemListing.fromSnapshot(DocumentSnapshot snapshot, ThriftlyUser creator) {
    return ItemListing(
      uniqueId: snapshot["uid"],
      title: snapshot["title"],
      imageUrl: snapshot["imageUrl"] ?? "no image url",
      description: snapshot["description"],
      size: snapshot["size"],
      createdAt: snapshot["createdAt"].toDate().toString(),
      location: snapshot["location"],
      price: snapshot["price"],
      creator: creator,
    );
  }

  factory ItemListing.fromMap(Map<String, dynamic> json, ThriftlyUser creator) {
    return ItemListing(
      uniqueId: json["uid"],
      title: json["title"],
      imageUrl: json["imageUrl"] ?? "no image url",
      size: json["size"],
      description: json["description"],
      createdAt: json["createdAt"].toDate().toString(),
      location: json["location"],
      price: json["price"],
      creator: creator,
    );
  }
}
