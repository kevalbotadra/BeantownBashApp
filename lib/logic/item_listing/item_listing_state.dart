import 'package:equatable/equatable.dart';
import 'package:thriftly/data/models/item_listing.dart';
import 'package:thriftly/data/models/outfit_inspo.dart';
import 'package:thriftly/data/models/thriftlyuser.dart';

abstract class ItemListingState extends Equatable {
  @override
  List<Object> get props => [];
}

class ItemListingInitial extends ItemListingState {}

class ItemListingLoading extends ItemListingState {}

class ItemListingCreated extends ItemListingState {}

class RedirectToCreateItemListing extends ItemListingState {}

class RedirectToPostOutfitInspo extends ItemListingState {}

class RedirectToItemListingDetail extends ItemListingState {
  final ItemListing itemListing;

  RedirectToItemListingDetail({required this.itemListing});

  @override
  List<Object> get props => [itemListing];

}

class ItemListingsObtained extends ItemListingState {
  final List<ItemListing> itemListings;

  ItemListingsObtained({required this.itemListings});

  @override
  List<Object> get props => [itemListings];
}

class OutfitInsposObtained extends ItemListingState {
  final List<OutfitInspo> outfitInspos;

  OutfitInsposObtained({required this.outfitInspos});

  @override
  List<Object> get props => [outfitInspos];
}

class PostDeleted extends ItemListingState {}

class PostAccepted extends ItemListingState {}

class PostFailure extends ItemListingState {
  final String error;

  PostFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class AccountRetrieved extends ItemListingState {
  final ThriftlyUser user;

  AccountRetrieved({required this.user});

  @override
  List<Object> get props => [user];
}

class GoToItemListingDetailPage extends ItemListingState {
  final ItemListing itemListing;

  GoToItemListingDetailPage({required this.itemListing});

  @override
  List<Object> get props => [itemListing];
}
