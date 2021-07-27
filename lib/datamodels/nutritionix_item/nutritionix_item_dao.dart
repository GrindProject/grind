import 'package:automated_inventory/datamodels/nutritionix_item/nutritionix_item_datamodel.dart';
import 'package:automated_inventory/framework/dao_nutritionix.dart';

class NutritionixItemDao extends DaoNutritionix<NutritionixItemDataModel> {


  @override
  NutritionixItemDataModel createModelFromJson(String id, Map<String, dynamic> json) {
    NutritionixItemDataModel dataModel = NutritionixItemDataModel(
      id,
      item_name: json['item_name'] ?? '',
      brand_name: json['brand_name'] ?? '',
      servings_per_container: json['nf_servings_per_container'] ?? 1,
      serving_size_qty: json['nf_serving_size_qty'] ?? 1,
      serving_size_unit: json['nf_serving_size_unit'] ?? '',
    );
    return dataModel;
  }




}
