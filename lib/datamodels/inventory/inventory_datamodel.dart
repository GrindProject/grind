import 'package:automated_inventory/framework/datamodel.dart';
import 'package:faunadb_http/query.dart';

class InventoryDataModel extends DataModel {
  final String productId;

  final String expirationDate;

  final int qty;



  InventoryDataModel(String id, {required this.productId, required this.expirationDate, required this.qty}) : super(id);

  @override
  Map<String, dynamic> toJson() {
    return {
          'productId': this.productId,
          'expirationDate': this.expirationDate,
          'qty': this.qty,
    };
  }
}
