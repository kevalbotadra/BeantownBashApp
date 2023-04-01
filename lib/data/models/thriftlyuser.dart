import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thriftly/data/models/item_listing.dart';

class ThriftlyUser {
  final bool isValid;
  final String uid;
  final String name;
  final String phoneNumber;
  final String pfpUrl;
  List<ItemListing> itemListings;
  // List<Posts> posts;

  ThriftlyUser({
    required this.isValid,
    this.uid = "ASASFASFASF",
    this.name = "",
    this.phoneNumber = "",
    this.pfpUrl = "",
    this.itemListings = const [],
  });

  factory ThriftlyUser.fullFromSnapshot(
      DocumentSnapshot snapshot, List<ItemListing> itemListings) {
    return ThriftlyUser(
      isValid: true,
      uid: snapshot["uid"],
      name: snapshot["name"],
      pfpUrl: snapshot["pfpUrl"] != ""
          ? snapshot["pfpUrl"]
          : "https://www.pinclipart.com/picdir/big/z157-1578186_user-profile-default-image-png-clipart.png",
      phoneNumber: snapshot["phoneNumber"],
      itemListings: itemListings,
    );
  }

  factory ThriftlyUser.lessFromSnapshot(DocumentSnapshot snapshot) {
    return ThriftlyUser(
      isValid: true,
      uid: snapshot["uid"],
      name: snapshot["name"],
      pfpUrl: snapshot["profilePic"] != ""
          ? snapshot["profilePic"]
          : "https://www.pinclipart.com/picdir/big/157-1578186_user-profile-default-image-png-clipart.png",
      phoneNumber: snapshot["phoneNumber"],
    );
  }

  factory ThriftlyUser.fromMap(
      Map<String, dynamic> map, List<ItemListing> itemListings) {
    return ThriftlyUser(
      isValid: true,
      uid: map["uid"],
      name: map["name"],
      pfpUrl: map["pfpUrl"] != ""
          ? map["pfpUrl"]
          : "https://www.pinclipart.com/picdir/big/157-1578186_user-profile-default-image-png-clipart.png",
      phoneNumber: map["phoneNumber"],
      itemListings: itemListings,
    );
  }
}


// Django  Backend Info:
  // username = models.CharField(max_length=255, unique=True)
  // name = models.CharField(max_length=50, default="New User")
  // email = models.CharField(max_length=255, unique=True)
  // profile_picture = models.FileField(upload_to=upload_to, default="default.png")
  // is_staff = models.BooleanField(default=False)
  // is_active = models.BooleanField(default=True)

  // username = self.username,
  // name = self.name,
  // email = self.email,
  // pfp = self.pfp.url,
  // is_staff = self.is_staff
