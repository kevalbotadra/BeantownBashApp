import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thriftly/data/models/thriftlyuser.dart';

class OutfitInspo {
  final String uniqueId;
  final String caption;
  final ThriftlyUser creator;
  final String imageUrl;
  final String createdAt;

  OutfitInspo({
    required this.uniqueId,
    required this.creator,
    required this.imageUrl,
    required this.caption,
    required this.createdAt,
  });

  factory OutfitInspo.fromJson(Map<String, dynamic> json) {
    return OutfitInspo(
      uniqueId: json["uid"],
      caption: json["caption"],
      imageUrl: json["imageUrl"] ?? "no image url",
      createdAt: json["createdAt"].toDate().toString(),
      creator: new ThriftlyUser(isValid: false),
    );
  }

  factory OutfitInspo.fromSnapshot(
      DocumentSnapshot snapshot, ThriftlyUser creator) {
    return OutfitInspo(
      uniqueId: snapshot["uid"],
      caption: snapshot["caption"],
      imageUrl: snapshot["imageUrl"] ?? "no image url",
      createdAt: snapshot["createdAt"].toDate().toString(),
      creator: creator,
    );
  }

  factory OutfitInspo.fromMap(Map<String, dynamic> json, ThriftlyUser creator) {
    return OutfitInspo(
      uniqueId: json["uid"],
      caption: json["caption"],
      imageUrl: json["imageUrl"] ?? "no image url",
      createdAt: json["createdAt"].toDate().toString(),
      creator: creator,
    );
  }
}
