import 'package:automated_inventory/businessmodels/inventory/inventory_businessmodel.dart';
import 'package:automated_inventory/businessmodels/inventory/inventory_provider.dart';
import 'package:automated_inventory/businessmodels/item_info/item_info_businessmodel.dart';
import 'package:automated_inventory/businessmodels/item_info/item_info_provider.dart';
import 'package:automated_inventory/businessmodels/product/product_businessmodel.dart';
import 'package:automated_inventory/businessmodels/product/product_provider.dart';
import 'package:automated_inventory/framework/bloc.dart';
import 'package:automated_inventory/framework/codemessage.dart';
import 'package:automated_inventory/modules/barcode_validation.dart';
import 'package:uuid/uuid.dart' as uuid;
import 'manage_item_blocevent.dart';
import 'manage_item_viewmodel.dart';

class ManageItemBloc extends Bloc<ManageItemViewModel, ManageItemBlocEvent> {
  @override
  void onReceiveEvent(ManageItemBlocEvent event) {
    if (event is ManageItemBlocEventOnInitializeView) _onInitializeView(event);
    if (event is ManageItemBlocEventSaveItem) _onSaveItem(event);
    if (event is ManageItemBlocEventSearchUPCNumber) _onSearchUPCNumber(event);
  }

  void _onInitializeView(ManageItemBlocEvent event) async {
    ProductProvider productProvider = ProductProvider();
    ProductBusinessModel? product = await productProvider.get(event.viewModel.productId);
    if (product != null)
      _onInitializeViewWithProduct(event, product);
    else if (event.viewModel.initialUpcNumber.isNotEmpty)
      _onInitializeViewWithUPCNumber(event, event.viewModel.initialUpcNumber);
    else
      _onInitializeViewWithEmptyValues(event);
  }

  void _onInitializeViewWithProduct(ManageItemBlocEvent event, ProductBusinessModel product) async {

    /// title
    event.viewModel.screenTitle = product.description;

    /// product information
    event.viewModel.nameController.text = product.description;
    event.viewModel.measureController.text = product.measure;
    event.viewModel.upcNumberController.text = product.upcNumber;
    InventoryProvider inventoryProvider = InventoryProvider();
    InventoryBusinessModel? inventory = await inventoryProvider.get(event.viewModel.inventoryId);
    if (inventory != null) {
      /// inventory information
      event.viewModel.expirationDateController.text = inventory.expirationDate;
      event.viewModel.qty = inventory.qty;
    } else {
      event.viewModel.expirationDateController.text = '';
      event.viewModel.qty = 1;
    }

    this.pipeOut.send(event.viewModel);
  }

  void _onInitializeViewWithUPCNumber(ManageItemBlocEvent event, String initialUPCNumber) async {

    /// title
    event.viewModel.screenTitle = 'New Item';

    /// product information
    event.viewModel.nameController.text = '';
    event.viewModel.measureController.text = '';
    event.viewModel.upcNumberController.text = initialUPCNumber;
    /// inventory information
    event.viewModel.expirationDateController.text = '';
    event.viewModel.qty = 1;

    _searchUPCNumber(event.viewModel);
    this.pipeOut.send(event.viewModel);
  }

  void _onInitializeViewWithEmptyValues(ManageItemBlocEvent event) async {

    /// title
    event.viewModel.screenTitle = 'New Item';

    /// product information
    event.viewModel.nameController.text = '';
    event.viewModel.measureController.text = '';
    event.viewModel.upcNumberController.text = '';
    /// inventory information
    event.viewModel.expirationDateController.text = '';
    event.viewModel.qty = 1;

    this.pipeOut.send(event.viewModel);
  }

  void _onSaveItem(ManageItemBlocEventSaveItem event) async {

    CodeMessage codeMessage = await _saveDataToRepository(
      productId: event.viewModel.productId,
      productDescription: event.viewModel.nameController.text,
      productMeasure: event.viewModel.measureController.text,
      productUpcNumber: event.viewModel.upcNumberController.text,
      inventoryId: event.viewModel.inventoryId,
      inventoryExpirationDate: event.viewModel.expirationDateController.text,
      inventoryQty: event.viewModel.qty,

    );

    event.viewModel.responseToSaveItem = codeMessage;
    this.pipeOut.send(event.viewModel);

  }

  Future<CodeMessage> _saveDataToRepository({
    required String productId,
    required String productDescription,
    required String productMeasure,
    required String productUpcNumber,
    required String inventoryId,
    required String inventoryExpirationDate,
    required int inventoryQty,
  }) async {

    if (productDescription.isEmpty) return CodeMessage(400, "Description is Required!");
    if (productMeasure.isEmpty) return CodeMessage(400, "Measure is Required!");
    if (productUpcNumber.isNotEmpty) {
      BarcodeValidation upcValidation = BarcodeValidation(productUpcNumber);
      if (!upcValidation.isValidNumber()) {
        return CodeMessage(400, "UPC Number is not Valid!");
      }

      ProductProvider productProvider = ProductProvider();
      ProductBusinessModel? anotherProduct = await productProvider.getbyUPCNumber(productUpcNumber);

      if (anotherProduct != null) {
        if (anotherProduct.id != productId) {
          productId = anotherProduct.id;
        }
      }

    }



    if (productId.isEmpty) {
      productId = uuid.Uuid().v4().toString();
    }

    if (inventoryId.isEmpty) {
      inventoryId = uuid.Uuid().v4().toString();
    }

    ProductBusinessModel product = ProductBusinessModel(id: productId, description: productDescription, measure: productMeasure, upcNumber: productUpcNumber);
    ProductProvider productProvider = ProductProvider();
    var responseForSavingProduct = await productProvider.put(product);


    InventoryBusinessModel inventory = InventoryBusinessModel(id: inventoryId, expirationDate: inventoryExpirationDate, qty: inventoryQty, productId: productId);
    InventoryProvider inventoryProvider = InventoryProvider();
    var responseForSavingInventory = await inventoryProvider.put(inventory);

    return responseForSavingInventory;
  }

  void _onSearchUPCNumber(ManageItemBlocEventSearchUPCNumber event) async {
    _searchUPCNumber(event.viewModel);
    this.pipeOut.send(event.viewModel);
  }

  void _searchUPCNumber(ManageItemViewModel viewModel) async {
    String upcNumber = viewModel.upcNumberController.text;
    if (upcNumber.isEmpty) {
      viewModel.responseToSearchItem = CodeMessage(500, 'Please fill the UPC Number in order to search!');
      this.pipeOut.send(viewModel);
      return;
    }
    ItemInfoProvider itemInfoProvider = ItemInfoProvider();
    ItemInfoBusinessModel? itemInfoBusinessModel = await itemInfoProvider.getFromUPCCode(upcNumber);
    if (itemInfoBusinessModel == null) {
      viewModel.responseToSearchItem = CodeMessage(501, 'No item was found with that UPC Number! Please fill manually!');
      this.pipeOut.send(viewModel);
      return;
    }
    viewModel.nameController.text = itemInfoBusinessModel.description;
    viewModel.measureController.text = itemInfoBusinessModel.measure;

  }


}
