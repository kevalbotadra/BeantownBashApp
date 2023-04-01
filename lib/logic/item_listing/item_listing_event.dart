import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:thriftly/data/models/thriftlyuser.dart';

abstract class ItemListingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateItemListing extends ItemListingEvent {
  final String title;
  final String description;
  final String size;
  final String price;
  final File imageFile;
  final String location;

  CreateItemListing({
    required this.title,
    required this.description,
    required this.price,
    required this.size,
    required this.imageFile,
    required this.location,
  });

  @override
  List<Object> get props => [
        title,
        description,
        price,
        size,
        imageFile,
        location,
      ];
}

class DeletePost extends ItemListingEvent {
  final int id;

  DeletePost({required this.id});

  @override
  List<Object> get props => [id];
}

class AcceptPost extends ItemListingEvent {
  final String id;

  AcceptPost({required this.id});

  @override
  List<Object> get props => [id];
}

class GetPosts extends ItemListingEvent {}

class GetAccount extends ItemListingEvent {}

class NavigateToDetailPage extends ItemListingEvent {
  final String uid;

  NavigateToDetailPage({required this.uid});

  @override
  List<Object> get props => [uid];
}

class NavigateToPostsPage extends ItemListingEvent {}

class NavigateToSettingsPage extends ItemListingEvent {}
