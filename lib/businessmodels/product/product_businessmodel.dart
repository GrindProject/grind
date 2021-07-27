import 'package:automated_inventory/framework/businessmodel.dart';
import 'package:faunadb_http/query.dart';

class ProductBusinessModel extends BusinessModel {
  final String id;

  final String description;

  final String measure;

  final String upcNumber;

  ProductBusinessModel({required this.id, required this.description, required this.measure, required this.upcNumber});
}
