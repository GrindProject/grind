import 'package:automated_inventory/framework/viewevents.dart';

import 'manage_item_bloc.dart';
import 'manage_item_blocevent.dart';
import 'manage_item_viewmodel.dart';

class ManageItemViewEvents extends ViewEvents<ManageItemBloc> {
  ManageItemViewEvents(ManageItemBloc bloc) : super(bloc);

  void saveItem(ManageItemViewModel viewModel) {
    ManageItemBlocEventSaveItem blocEvent = ManageItemBlocEventSaveItem(viewModel);
    this.bloc.pipeIn.send(blocEvent);
  }

  void searchUPCNumber(ManageItemViewModel viewModel) {
    ManageItemBlocEventSearchUPCNumber blocEvent = ManageItemBlocEventSearchUPCNumber(viewModel);
    this.bloc.pipeIn.send(blocEvent);
  }

/*
  void deleteItemToList(MainInventoryViewModel viewModel) {
    MainInventoryBlocEventDeleteItem blocEvent = MainInventoryBlocEventDeleteItem(viewModel);
    this.bloc.pipeIn.send(blocEvent);
  }
*/
}
