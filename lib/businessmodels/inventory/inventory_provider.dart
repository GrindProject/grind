import 'package:automated_inventory/businessmodels/product/product_businessmodel.dart';
import 'package:automated_inventory/datamodels/inventory/inventory_dao.dart';
import 'package:automated_inventory/datamodels/inventory/inventory_datamodel.dart';
import 'package:automated_inventory/datamodels/product/product_dao.dart';
import 'package:automated_inventory/datamodels/product/product_datamodel.dart';
import 'package:automated_inventory/framework/codemessage.dart';
import 'package:automated_inventory/framework/provider.dart';

import 'inventory_businessmodel.dart';

class InventoryProvider extends Provider<InventoryBusinessModel> {
  InventoryDao _dao = InventoryDao();

  @override
  Future<InventoryBusinessModel?> get(String id) async {
    InventoryDataModel? dataModel = await _dao.get(id);
    if (dataModel == null) return null;
    return _getBusinessModelFromDataModel(dataModel);
  }

  @override
  Future<List<InventoryBusinessModel>> getAll() async {
    List<InventoryBusinessModel> businessModels = List.empty(growable: true);
    List<InventoryDataModel> dataModels = await _dao.getAll();
    dataModels.forEach((dataModel) {
      businessModels.add(_getBusinessModelFromDataModel(dataModel));
    });
    return businessModels;
  }

  @override
  Future<CodeMessage> put(InventoryBusinessModel businessModel) async {
    InventoryDataModel dataModel = _getDataModelFromBusinessModel(businessModel);
    return _dao.put(dataModel);
  }

  @override
  Future<CodeMessage> create(InventoryBusinessModel businessModel) async {
    InventoryDataModel dataModel = _getDataModelFromBusinessModel(businessModel);
    return _dao.create(dataModel);
  }

  /// adapters

  InventoryBusinessModel _getBusinessModelFromDataModel(InventoryDataModel dataModel) {
    return InventoryBusinessModel(
      id: dataModel.id,
      productId: dataModel.productId,
      expirationDate: dataModel.expirationDate,
      qty: dataModel.qty,
    );
  }

  InventoryDataModel _getDataModelFromBusinessModel(InventoryBusinessModel businessModel) {
    return InventoryDataModel(
      businessModel.id,
      productId: businessModel.productId,
      expirationDate: businessModel.expirationDate,
      qty: businessModel.qty
    );
  }

  @override
  Future<CodeMessage> delete(String id) {
    return _dao.delete(id);
  }

  Future<List<InventoryBusinessModel>> getByProductId(String productId) async {
    List<InventoryBusinessModel> businessModels = List.empty(growable: true);
    List<InventoryDataModel> dataModels = await _dao.getAllByUsingProductId(productId);
    dataModels.forEach((dataModel) {
      businessModels.add(_getBusinessModelFromDataModel(dataModel));
    });
    return businessModels;
  }
}
