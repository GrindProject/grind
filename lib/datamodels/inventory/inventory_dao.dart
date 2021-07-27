import 'package:automated_inventory/datamodels/product/product_datamodel.dart';
import 'package:automated_inventory/framework/codemessage.dart';
import 'package:automated_inventory/framework/dao_faunadb.dart';
import 'package:automated_inventory/framework/dao_firebasedb.dart';

import 'inventory_datamodel.dart';

class InventoryDao extends DaoFirebaseDB<InventoryDataModel> {
  @override
  String getCollectionName() {
    return "inventory";
  }

  @override
  InventoryDataModel createModelFromJson(String id, Map<String, dynamic> json) {
    return InventoryDataModel(
      id,
      productId: json['productId'],
      expirationDate: json['expirationDate'],
      qty: json['qty']
    );
  }

  Future<List<InventoryDataModel>>  getAllByUsingProductId(String productId) async {
    return this.getAllUsingPropertyValue("productId", productId);
  }

}
