import 'package:automated_inventory/framework/businessmodel.dart';
import 'package:faunadb_http/query.dart';

class ItemInfoBusinessModel extends BusinessModel {

  final String description;

  final String measure;

  ItemInfoBusinessModel({required this.description, required this.measure});
}
