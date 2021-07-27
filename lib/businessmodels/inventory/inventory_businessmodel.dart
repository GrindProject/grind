import 'package:automated_inventory/framework/businessmodel.dart';
import 'package:faunadb_http/query.dart';

class InventoryBusinessModel extends BusinessModel {
  final String id;

  final String productId;

   String expirationDate;

   int qty;



  InventoryBusinessModel({required this.id, required this.productId, required this.expirationDate, required this.qty});
}
