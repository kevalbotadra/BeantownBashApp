import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:thriftly/data/models/item_listing.dart';
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

class NavigateToItemListingDetail extends ItemListingEvent {
    final ItemListing itemListing;

  NavigateToItemListingDetail({required this.itemListing});

  @override
  List<Object> get props => [itemListing];
}

class CreateOutfitInspoEvent extends ItemListingEvent {
  final String caption;
  final File imageFile;

  CreateOutfitInspoEvent({
    required this.caption,
    required this.imageFile,
  });

  @override
  List<Object> get props => [
        caption,
        imageFile,
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

class GetOutfitInspos extends ItemListingEvent {}

class GetItems extends ItemListingEvent {}

class GetAccount extends ItemListingEvent {}

class NavigateToDetailPage extends ItemListingEvent {}

class NavigateToCreateItemListingForm extends ItemListingEvent {}

class NavigateToPostOutfitInspo extends ItemListingEvent {}
