import 'package:automated_inventory/businessmodels/inventory/inventory_businessmodel.dart';
import 'package:automated_inventory/businessmodels/inventory/inventory_provider.dart';
import 'package:automated_inventory/businessmodels/product/product_businessmodel.dart';
import 'package:automated_inventory/businessmodels/product/product_provider.dart';
import 'package:automated_inventory/features/scan_item_in/scam_item_in_blocevent.dart';
import 'package:automated_inventory/features/scan_item_in/scan_item_in_viewmodel.dart';
import 'package:automated_inventory/framework/bloc.dart';
import 'package:automated_inventory/framework/codemessage.dart';
import 'package:flutter/material.dart';


class ScanItemInBloc extends Bloc<ScanItemInViewModel, ScanItemInBlocEvent> {
  @override
  void onReceiveEvent(ScanItemInBlocEvent event) {
    if (event is ScanItemInBlocEventOnInitializeView) _onInitializeView(event);
    if (event is ScanItemInBlocEventScanUsingUPC) _onScanItemUsingUPC(event);

  }

  void _onInitializeView(ScanItemInBlocEventOnInitializeView event) {
    this.pipeOut.send(event.viewModel);
  }

  void _onScanItemUsingUPC(ScanItemInBlocEventScanUsingUPC event) async {
    event.viewModel.product = null;
    event.viewModel.inventoryItems.clear();

    String upcNumber = event.viewModel.upcTextController.text;


    ProductProvider productProvider = ProductProvider();
    ProductBusinessModel? product = await productProvider.getbyUPCNumber(upcNumber);
    if (product != null) {

      event.viewModel.product = ScanItemInViewModelProductModel(product.id, product.description, product.measure, Colors.blue);

      InventoryProvider inventoryProvider = InventoryProvider();
      List<InventoryBusinessModel> list = await inventoryProvider.getByProductId(product.id);

      list.forEach((inventory) {
        event.viewModel.inventoryItems.add(ScanItemInViewModelInventoryModel(
            inventory.productId,
          inventory.expirationDate,
          inventory.qty,
          Colors.blue,
        ));
      });
    }

    this.pipeOut.send(event.viewModel);
  }


}
