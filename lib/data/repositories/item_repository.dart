import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thriftly/data/models/Item.dart';
import 'package:thriftly/data/providers/item_provider.dart';

class ItemRespositry {
  final ItemProvider _itemProvider;

  ItemRespositry(this._itemProvider);

  Future<List<Item>> getItems() async {
    List<Map<String, dynamic>> itemsMetaData =
        await _itemProvider.getItems();
    List<Map<String, dynamic>> docs = [];
    List<Item> items = [];

    itemsMetaData.map((doc) {
      docs.add(doc);
    }).toList();

    for (Map<String, dynamic> doc in docs) {
      items.add(Item.fromMap(doc));
    }

    return items;
  }
}