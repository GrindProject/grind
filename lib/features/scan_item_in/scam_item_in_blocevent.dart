import 'package:automated_inventory/features/scan_item_in/scan_item_in_viewmodel.dart';
import 'package:automated_inventory/framework/blocevent.dart';



abstract class ScanItemInBlocEvent extends BlocEvent<ScanItemInViewModel> {
  ScanItemInBlocEvent(ScanItemInViewModel viewModel) : super(viewModel);
}

/// base events

class ScanItemInBlocEventOnInitializeView extends ScanItemInBlocEvent {
  ScanItemInBlocEventOnInitializeView(ScanItemInViewModel viewModel) : super(viewModel);
}

/// custom events

class ScanItemInBlocEventScanUsingUPC extends ScanItemInBlocEvent {
  ScanItemInBlocEventScanUsingUPC(ScanItemInViewModel viewModel) : super(viewModel);
}

/*

class MainInventoryBlocEventDeleteItem  extends MainInventoryBlocEvent {
  MainInventoryBlocEventDeleteItem(MainInventoryViewModel viewModel) : super(viewModel);
}
*/
