import 'package:automated_inventory/framework/datamodel.dart';
import 'package:faunadb_http/query.dart';

class NutritionixItemDataModel extends DataModel {
  final String item_name;

  final String brand_name;

  final int servings_per_container;

  final int serving_size_qty;

  final String serving_size_unit;

  NutritionixItemDataModel(
    String id, {
    required this.item_name,
    required this.brand_name,
    required this.servings_per_container,
    required this.serving_size_qty,
    required this.serving_size_unit,
  }) : super(id);

  @override
  Map<String, dynamic> toJson() {
    return {
      'item_name': this.item_name,
      'brand_name': this.brand_name,
      'servings_per_container': this.servings_per_container,
      'serving_size_qty': this.serving_size_qty,
      'serving_size_unit': this.serving_size_unit,
    };
  }
}

/*
{
   "item_id": "51c3d78797c3e6d8d3b546cf",
   "item_name": "Cola, Cherry",
   "brand_id": "51db3801176fe9790a89ae0b",
   "brand_name": "Coke",
   "item_description": "Cherry",
   "updated_at": "2013-07-09T00:00:46.000Z",
   "nf_ingredient_statement": "Carbonated Water, High Fructose Corn Syrup and/or Sucrose, Caramel Color, Phosphoric Acid, Natural Flavors, Caffeine.",
   "nf_calories": 100,
   "nf_calories_from_fat": 0,
   "nf_total_fat": 0,
   "nf_saturated_fat": null,
   "nf_cholesterol": null,
   "nf_sodium": 25,
   "nf_total_carbohydrate": 28,
   "nf_dietary_fiber": null,
   "nf_sugars": 28,
   "nf_protein": 0,
   "nf_vitamin_a_dv": 0,
   "nf_vitamin_c_dv": 0,
   "nf_calcium_dv": 0,
   "nf_iron_dv": 0,
   "nf_servings_per_container": 6,
   "nf_serving_size_qty": 8,
   "nf_serving_size_unit": "fl oz",
}

 */
