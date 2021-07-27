import 'dart:convert';

import 'package:http/http.dart' as http;
import 'codemessage.dart';
import 'dao.dart';
import 'datamodel.dart';



abstract class DaoNutritionix<DM extends DataModel> extends Dao<DM> {


  String getBaseUrl() {
    return 'https://api.nutritionix.com/v1_1/item?appId=d51ab63a&appKey=23096e21dbe474ce5ea1ba982df3a4c6';
  }

  DM createModelFromJson(String id, Map<String, dynamic> json);

  Future<DM?> getFromUPCCode(String upcCode) async {

      String url = getBaseUrl();
      url += '&upc=' + upcCode;
      http.Response httpResponse = await http.get(Uri.parse(url));
      if (httpResponse.statusCode == 200) {
        return createModelFromJson(upcCode, jsonDecode(httpResponse.body));
      } else {
        return null;
      }

  }

  Future<DM?> get(String id) async {
    return null;
  }

  Future<List<DM>> getAll() async {
    List<DM> list = List.empty(growable: true);
    return list;
  }

  Future<CodeMessage> put(DM dataModel) async {
    return CodeMessage(100, 'not allowed');
  }

  Future<CodeMessage> create(DM dataModel) async {
    return CodeMessage(200, 'not allowed');
  }

  Future<CodeMessage> delete(String id) async {
    return CodeMessage(300, 'not allowed');
  }
}
