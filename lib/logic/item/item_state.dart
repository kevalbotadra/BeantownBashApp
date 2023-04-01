import 'package:equatable/equatable.dart';
import 'package:thriftly/data/models/Item.dart';
import 'package:thriftly/logic/item/item_event.dart';

abstract class ItemState extends Equatable {
  @override
  List<Object> get props => [];
}

class ItemInitial extends ItemState {}

class ItemLoading extends ItemState {}

class ItemObtained extends ItemState {
  final List<Item> items;

  ItemObtained({required this.items});

  @override
  List<Object> get props => [items];
}

class ItemFailure extends ItemState {
  final String error;

  ItemFailure({required this.error});

  @override
  List<Object> get props => [error];
}
