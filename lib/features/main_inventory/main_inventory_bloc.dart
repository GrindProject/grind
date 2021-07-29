import 'package:automated_inventory/businessmodels/inventory/inventory_businessmodel.dart';
import 'package:automated_inventory/businessmodels/inventory/inventory_provider.dart';
import 'package:automated_inventory/businessmodels/product/product_businessmodel.dart';
import 'package:automated_inventory/businessmodels/product/product_provider.dart';
import 'package:automated_inventory/features/main_inventory/main_inventory_blocevent.dart';
import 'package:automated_inventory/features/main_inventory/main_inventory_viewmodel.dart';
import 'package:automated_inventory/framework/bloc.dart';
import 'package:automated_inventory/framework/codemessage.dart';
import 'package:automated_inventory/modules/barcode_validation.dart';
import 'package:automated_inventory/modules/user_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart' as barcodeScanner;
import 'package:flutter_blue/flutter_blue.dart' as blueTooth;

class MainInventoryBloc
    extends Bloc<MainInventoryViewModel, MainInventoryBlocEvent> {

  //MainInventoryBloc() {
  //  _doBlueToothStuff();
  ///}

  @override
  void onReceiveEvent(MainInventoryBlocEvent event) {
    if (event is MainInventoryBlocEventOnInitializeView) _onInitializeView(event);
    if (event is MainInventoryBlocEventRefreshData) _refreshData(event);
    if (event is MainInventoryBlocEventDeleteItem) _deleteItem(event);
    if (event is MainInventoryBlocEventAddQtyToInventoryItem) _addQtyToInventoryItem(event);
    if (event is MainInventoryBlocEventSubtractQtyToInventoryItem) _subtractQtyToInventoryItem(event);
    if (event is MainInventoryBlocEventSearchItem) _searchItem(event);
    if (event is MainInventoryBlocEventOpenCameraToScan) _openCameraToScan(event);
    if (event is MainInventoryBlocEventRefreshBlueTooth) _refreshBlueTooth(event);
    if (event is MainInventoryBlocEventVerifyItem) _verifyItem(event);

  }

  void _onInitializeView(MainInventoryBlocEvent event) {
    _getUserInformation(event.viewModel);
    _refreshViewModelList(event.viewModel);
  }

  void _refreshData(MainInventoryBlocEventRefreshData event) {
    _refreshViewModelList(event.viewModel);
  }

  void _deleteItem(MainInventoryBlocEventDeleteItem event) async {
    String itemId = event.viewModel.items[event.itemIndex].id;
    ProductProvider productProvider = ProductProvider();
    CodeMessage codeMessage = await productProvider.delete(itemId);

    if (codeMessage.code == 1) {
      event.viewModel.responseToDeleteItem = codeMessage;
      _refreshViewModelList(event.viewModel);
    } else {
      event.viewModel.responseToDeleteItem = codeMessage;
      this.pipeOut.send(event.viewModel);
    }
  }

  void _getUserInformation(MainInventoryViewModel viewModel) {
    if (UserInformation.userName.isEmpty) {
      viewModel.screenTitle = 'My Inventory';
    } else {
      var names = UserInformation.userName.split(" ");
      viewModel.screenTitle =  names[0] + '\'s Inventory';
    }
    viewModel.userPhotoUrl = UserInformation.userPhotoUrl;
  }

  void _refreshViewModelList(MainInventoryViewModel viewModel) {
    _getItemsFromRepository()
        .then((List<MainInventoryViewModelItemModel> items) {
      viewModel.cachedItems.clear();
      viewModel.cachedItems.addAll(items);

      _applySearchArgumentToList(viewModel);

      this.pipeOut.send(viewModel);
    });
  }



  Future<List<MainInventoryViewModelItemModel>> _getItemsFromRepository() async {
    List<MainInventoryViewModelItemModel> listItems = List.empty(growable: true);
    List<ProductBusinessModel> productList = await _getProductsBusinessModelFromRepository();
    for(ProductBusinessModel product in productList) {
      InventoryProvider inventoryProvider = InventoryProvider();
      List<InventoryBusinessModel> inventoryList = await inventoryProvider.getByProductId(product.id);
      List<MainInventoryViewModelSubItemModel> subItems = List.empty(growable: true);
      inventoryList.forEach((inventory) {
        subItems.add(MainInventoryViewModelSubItemModel(inventory.id, inventory.expirationDate, inventory.qty, Colors.blue));
      });
      listItems.add(MainInventoryViewModelItemModel(
        product.id,
        product.description,
        product.measure,
        product.upcNumber,
        subItems,
        Colors.blue,
      ));

    }

    return listItems;
  }

  Future<List<ProductBusinessModel>>
      _getProductsBusinessModelFromRepository() async {
    ProductProvider productProvider = ProductProvider();
    List<ProductBusinessModel> products = await productProvider.getAll();
    return products;
  }

  void _addQtyToInventoryItem(MainInventoryBlocEventAddQtyToInventoryItem event) async {
    InventoryProvider inventoryProvider = InventoryProvider();
    InventoryBusinessModel? inventory = await inventoryProvider.get(event.inventoryItemId);
    if (inventory == null) return;
    inventory.qty++;
    inventoryProvider.put(inventory);
    _refreshViewModelList(event.viewModel);
  }

  void _subtractQtyToInventoryItem(MainInventoryBlocEventSubtractQtyToInventoryItem event) async {
    InventoryProvider inventoryProvider = InventoryProvider();
    InventoryBusinessModel? inventory = await inventoryProvider.get(event.inventoryItemId);
    if (inventory == null) return;
    inventory.qty--;

    if (inventory.qty > 0)
      inventoryProvider.put(inventory);
    else {
      inventoryProvider.delete(inventory.id);

      List<InventoryBusinessModel> list = await inventoryProvider.getByProductId(inventory.productId);
      if (list.isEmpty) {
        ProductProvider productProvider = ProductProvider();
        await productProvider.delete(inventory.productId);
      }
    }

    _refreshViewModelList(event.viewModel);
  }

  void _searchItem(MainInventoryBlocEventSearchItem event) {
    _applySearchArgumentToList(event.viewModel);
    this.pipeOut.send(event.viewModel);
  }

  void _applySearchArgumentToList(MainInventoryViewModel viewModel) {
    String searchInput = viewModel.searchController.text.toLowerCase();

    viewModel.items.clear();
    for(var item in viewModel.cachedItems) {
      if (
      (searchInput.isEmpty)
          || (item.name.toLowerCase().startsWith(searchInput))
          || (item.upcNumber.toLowerCase().startsWith(searchInput))
      ) {
        viewModel.items.add(item);
      }
    }

    viewModel.items.sort( (first,second) {
    //  String firstExpDate = first.getLowestExpirationDate();
    //  String secondExpDate = second.getLowestExpirationDate();
    //  if (firstExpDate != secondExpDate) return firstExpDate.compareTo(secondExpDate);
      return first.name.compareTo(second.name);
    });

    /*
    if (searchInput.contains("\n")) {
      if (viewModel.items.isEmpty) {
        if (BarcodeValidation(searchInput).isValidNumber()) {
          viewModel.promptDialogToUserAskingToAddNewItem = true;
        }
      }
      this.pipeOut.send(viewModel);
    }

     */


  }

  void _openCameraToScan(MainInventoryBlocEventOpenCameraToScan event) async {
    var barcodeScanRes = await barcodeScanner.FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, barcodeScanner.ScanMode.BARCODE);

    bool userHasCanceled = (barcodeScanRes == '-1');
    if (userHasCanceled) {
      event.viewModel.searchController.text = '';
      _applySearchArgumentToList(event.viewModel);
      this.pipeOut.send(event.viewModel);
    }
    else {
      event.viewModel.searchController.text = barcodeScanRes;
      _applySearchArgumentToList(event.viewModel);
      if (event.viewModel.items.isEmpty) {
        if (BarcodeValidation(barcodeScanRes).isValidNumber()) {
          event.viewModel.promptDialogToUserAskingToAddNewItem = true;
        }
      }
      this.pipeOut.send(event.viewModel);
    }





  }


  void _refreshBlueTooth(MainInventoryBlocEventRefreshBlueTooth event) async {
    print("_refreshBlueTooth");
    //blueTooth.FlutterBlue.instance.state.listen((event) {
    //  print("__________doBlueToothStuff.state: " + event.toString());
    //});
    blueTooth.FlutterBlue.instance.setLogLevel(blueTooth.LogLevel.emergency);
    blueTooth.FlutterBlue.instance.stopScan();

    blueTooth.FlutterBlue.instance.scanResults.listen((event) {
      for(int i = 0; i < event.length; i ++) {
        blueTooth.BluetoothDevice device = event[i].device;
        if (device.name == 'SAMSUNG-SM-G930V') {
          print("_refreshBlueTooth.scanResults $i) " + device.name);
          _onDeviceFound(device);
          break;
        }
      }
    });

    print("_refreshBlueTooth.startScan");
    blueTooth.FlutterBlue.instance.startScan(timeout: Duration(seconds: 4));

  }

  void _onDeviceFound(blueTooth.BluetoothDevice device) async {


    //device.services.listen((event) {
    //  print("_onDeviceFound.services: " + event.toString());
    //});
    //device.discoverServices();


    print("_onDeviceFound.tryConnect: " + device.toString());
    await device.disconnect();
    await device.connect(timeout: Duration(seconds: 10), autoConnect: true).then((value) async {
      print("_onDeviceFound.connected!!");

      device.services.listen((services) async {
        print("_onDeviceFound.services" + services.length.toString() );
        for(int i = 0; i < services.length; i++) {
          var service = services[i];
          print("_onDeviceFound.service: " + service.toString());
          var characteristics = service.characteristics;
          for(blueTooth.BluetoothCharacteristic characteristic in characteristics) {
            List<int> value = await characteristic.read();
            print(value);

/*
            // Reads all descriptors
            var descriptors = characteristic.descriptors;
            for(blueTooth.BluetoothDescriptor descriptor in descriptors) {
              List<int> value = await descriptor.read();
              print("_onDeviceFound.descriptor: " + value.toString());
            }
*/
            //print("_onDeviceFound.BluetoothCharacteristic: ");
            //List<int> value = await c.read();
            //print(value);
          }
        }

      });

      print("_onDeviceFound.discoverServices..." );
      device.discoverServices();


      //List<blueTooth.BluetoothDevice> devices = await blueTooth.FlutterBlue.instance.connectedDevices;
     // devices.forEach((device) async {
     //   print("_onDeviceFound.connectedDevice: " + device.toString());
     // });



    });



  }

  void _verifyItem(MainInventoryBlocEventVerifyItem event) {
    _applySearchArgumentToList(event.viewModel);
    if (event.viewModel.items.isEmpty) {
      if (BarcodeValidation(event.viewModel.searchController.text).isValidNumber()) {
        event.viewModel.promptDialogToUserAskingToAddNewItem = true;
      }
    }
    this.pipeOut.send(event.viewModel);
  }



}
