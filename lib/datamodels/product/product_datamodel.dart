import 'package:automated_inventory/framework/datamodel.dart';
import 'package:faunadb_http/query.dart';

class ProductDataModel extends DataModel {
  final String description;

  final String measure;

  final String upcNumber;

  ProductDataModel(String id, {required this.description, required this.measure, required this.upcNumber}) : super(id);

  @override
  Map<String, dynamic> toJson() {
    return {
          'description': this.description,
          'measure': this.measure,
          'upcNumber': this.upcNumber,
    };
  }
}
