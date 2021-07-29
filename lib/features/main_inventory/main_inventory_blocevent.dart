import 'package:automated_inventory/features/main_inventory/main_inventory_viewmodel.dart';
import 'package:automated_inventory/framework/blocevent.dart';

abstract class MainInventoryBlocEvent extends BlocEvent<MainInventoryViewModel> {
  MainInventoryBlocEvent(MainInventoryViewModel viewModel) : super(viewModel);
}

/// base events

class MainInventoryBlocEventOnInitializeView extends MainInventoryBlocEvent {
  MainInventoryBlocEventOnInitializeView(MainInventoryViewModel viewModel) : super(viewModel);
}

/// custom events

class MainInventoryBlocEventAddQtyToInventoryItem extends MainInventoryBlocEvent {
  final String inventoryItemId;

  MainInventoryBlocEventAddQtyToInventoryItem(MainInventoryViewModel viewModel, this.inventoryItemId) : super(viewModel);
}

class MainInventoryBlocEventSubtractQtyToInventoryItem extends MainInventoryBlocEvent {
  final String inventoryItemId;

  MainInventoryBlocEventSubtractQtyToInventoryItem(MainInventoryViewModel viewModel, this.inventoryItemId) : super(viewModel);
}

class MainInventoryBlocEventSearchItem extends MainInventoryBlocEvent {
  MainInventoryBlocEventSearchItem(MainInventoryViewModel viewModel) : super(viewModel);
}

class MainInventoryBlocEventOpenCameraToScan extends MainInventoryBlocEvent {
  MainInventoryBlocEventOpenCameraToScan(MainInventoryViewModel viewModel) : super(viewModel);
}

class MainInventoryBlocEventRefreshBlueTooth extends MainInventoryBlocEvent {
  MainInventoryBlocEventRefreshBlueTooth(MainInventoryViewModel viewModel) : super(viewModel);
}

class MainInventoryBlocEventVerifyItem extends MainInventoryBlocEvent {
  MainInventoryBlocEventVerifyItem(MainInventoryViewModel viewModel) : super(viewModel);
}






//class MainInventoryBlocEventAddItem extends MainInventoryBlocEvent {
//  MainInventoryBlocEventAddItem(MainInventoryViewModel viewModel) : super(viewModel);
//}

//class MainInventoryBlocEventDeleteItem extends MainInventoryBlocEvent {
//  MainInventoryBlocEventDeleteItem(MainInventoryViewModel viewModel) : super(viewModel);
//}

class MainInventoryBlocEventRefreshData extends MainInventoryBlocEvent {
  MainInventoryBlocEventRefreshData(MainInventoryViewModel viewModel) : super(viewModel);
}

class MainInventoryBlocEventDeleteItem extends MainInventoryBlocEvent {
  final int itemIndex;

  MainInventoryBlocEventDeleteItem(MainInventoryViewModel viewModel, this.itemIndex) : super(viewModel);
}
