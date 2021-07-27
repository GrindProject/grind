

import 'package:automated_inventory/framework/codemessage.dart';
import 'package:automated_inventory/framework/model.dart';
import 'package:automated_inventory/framework/viewmodel.dart';
import 'package:faunadb_http/query.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManageItemViewModel extends ViewModel {
  final String inventoryId;
  final String productId;
  final String initialUpcNumber;

  ManageItemViewModel(this.inventoryId, this.productId, this.initialUpcNumber);

  /// product
  TextEditingController nameController = TextEditingController();
  TextEditingController measureController = TextEditingController();
  TextEditingController upcNumberController = TextEditingController();

  /// inventory
  TextEditingController expirationDateController = TextEditingController();
  int qty =0;

  String screenTitle = "";

  CodeMessage? responseToSaveItem;

  CodeMessage? responseToSearchItem;
}

/*
class ManageItemViewModelItemModel extends Model {
  final String productId;
  final String description;
  final String measure;

  final String expirationDate;


  ManageItemViewModelItemModel({required this.id, required this.description, required this.expirationDate, required this.measure});
}
*/