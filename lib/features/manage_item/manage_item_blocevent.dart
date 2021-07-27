import 'package:automated_inventory/framework/blocevent.dart';

import 'manage_item_viewmodel.dart';

abstract class ManageItemBlocEvent extends BlocEvent<ManageItemViewModel> {
  ManageItemBlocEvent(ManageItemViewModel viewModel) : super(viewModel);
}

/// base events

class ManageItemBlocEventOnInitializeView extends ManageItemBlocEvent {
  ManageItemBlocEventOnInitializeView(ManageItemViewModel viewModel) : super(viewModel);
}

/// custom events

class ManageItemBlocEventSaveItem extends ManageItemBlocEvent {
  ManageItemBlocEventSaveItem(ManageItemViewModel viewModel) : super(viewModel);
}

class ManageItemBlocEventSearchUPCNumber extends ManageItemBlocEvent {
  ManageItemBlocEventSearchUPCNumber(ManageItemViewModel viewModel) : super(viewModel);
}

/*
class MainInventoryBlocEventDeleteItem  extends MainInventoryBlocEvent {
  MainInventoryBlocEventDeleteItem(MainInventoryViewModel viewModel) : super(viewModel);
}
*/
