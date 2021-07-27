

import 'package:automated_inventory/framework/codemessage.dart';
import 'package:automated_inventory/framework/model.dart';
import 'package:automated_inventory/framework/viewmodel.dart';
import 'package:faunadb_http/query.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScanItemInViewModel extends ViewModel {

  TextEditingController upcTextController = TextEditingController();

  ScanItemInViewModelProductModel? product;
  final List<ScanItemInViewModelInventoryModel> inventoryItems = List.empty(growable: true);

}

class ScanItemInViewModelProductModel {
  final String id;
  final String name ;
  final String measure;

  final Color color;

  ScanItemInViewModelProductModel(this.id, this.name, this.measure, this.color);

  String toString() {
    return '$name $measure';
  }
}

class ScanItemInViewModelInventoryModel {
  final String productId;
  final String expirationDate;
  final int qty;

  final Color color;

  ScanItemInViewModelInventoryModel(this.productId, this.expirationDate, this.qty, this.color);

  String toString() {
    return '$expirationDate';
  }
}

