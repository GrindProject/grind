import 'package:automated_inventory/datamodels/product/product_datamodel.dart';
import 'package:automated_inventory/framework/codemessage.dart';
import 'package:automated_inventory/framework/dao_faunadb.dart';
import 'package:automated_inventory/framework/dao_firebasedb.dart';

class ProductDao extends DaoFirebaseDB<ProductDataModel> {
  @override
  String getCollectionName() {
    return "products";
  }

  @override
  ProductDataModel createModelFromJson(String id, Map<String, dynamic> json) {
    return ProductDataModel(
      id,
      description: json['description'],
      measure: json['measure'],
      upcNumber: json['upcNumber'],
    );
  }

  Future<ProductDataModel?>  getByUsingUPCNumber(String upcNumber) async {
    List<ProductDataModel> list = await this.getAllUsingPropertyValue("upcNumber", upcNumber);
    if (list.isNotEmpty) return list.first;
    else return null;
  }


}
