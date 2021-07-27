import 'package:automated_inventory/businessmodels/product/product_businessmodel.dart';
import 'package:automated_inventory/datamodels/nutritionix_item/nutritionix_item_dao.dart';
import 'package:automated_inventory/datamodels/nutritionix_item/nutritionix_item_datamodel.dart';
import 'package:automated_inventory/datamodels/product/product_dao.dart';
import 'package:automated_inventory/datamodels/product/product_datamodel.dart';
import 'package:automated_inventory/framework/codemessage.dart';
import 'package:automated_inventory/framework/provider.dart';

import 'item_info_businessmodel.dart';

class ItemInfoProvider extends Provider<ItemInfoBusinessModel> {
  NutritionixItemDao _dao = NutritionixItemDao();


  Future<ItemInfoBusinessModel?> getFromUPCCode(String upcCode) async {
    NutritionixItemDataModel? dataModel = await _dao.getFromUPCCode(upcCode);
    if (dataModel == null) return null;
    return _getBusinessModelFromDataModel(dataModel);
  }


  @override
  Future<ItemInfoBusinessModel?> get(String id) async {
    return null;
  }

  @override
  Future<List<ItemInfoBusinessModel>> getAll() async {
    List<ItemInfoBusinessModel> businessModels = List.empty(growable: true);
    return businessModels;
  }

  @override
  Future<CodeMessage> put(ItemInfoBusinessModel businessModel) async {
    return CodeMessage(100, 'not allowed');

  }

  @override
  Future<CodeMessage> create(ItemInfoBusinessModel businessModel) async {
    return CodeMessage(100, 'not allowed');
  }

  @override
  Future<CodeMessage> delete(String id) async {
    return CodeMessage(100, 'not allowed');
  }


  /// adapters

  ItemInfoBusinessModel _getBusinessModelFromDataModel(NutritionixItemDataModel dataModel) {
    return ItemInfoBusinessModel(
      description: dataModel.brand_name + ' ' + dataModel.item_name,
      measure: dataModel.serving_size_qty.toString() + ' ' + dataModel.serving_size_unit,
    );
  }

}
