import 'package:automated_inventory/features/main_inventory/main_inventory_view.dart';
import 'package:automated_inventory/features/main_inventory/main_inventory_viewevents.dart';
import 'package:automated_inventory/features/main_inventory/main_inventory_viewmodel.dart';
import 'package:automated_inventory/framework/blocevent.dart';
import 'package:automated_inventory/framework/presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'main_inventory_bloc.dart';
import 'main_inventory_blocevent.dart';

class MainInventoryPresenter extends Presenter<MainInventoryView, MainInventoryViewModel, MainInventoryViewEvents, MainInventoryBloc> {
  MainInventoryPresenter(MainInventoryViewEvents viewEvents, MainInventoryBloc bloc, MainInventoryViewModel viewModel)
      : super(viewEvents: viewEvents, bloc: bloc, viewModel: viewModel);

  MainInventoryPresenter.withDefaultsViewModelViewActions(MainInventoryBloc bloc)
      : super(viewEvents: MainInventoryViewEvents(bloc), bloc: bloc, viewModel: MainInventoryViewModel());

  MainInventoryPresenter.withDefaultConstructors() : this.withDefaultsViewModelViewActions(MainInventoryBloc());

  @override
  Widget buildLoadingView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Text("Loading..."),
      ),
    );
  }

  @override
  MainInventoryView buildView(BuildContext context, MainInventoryViewModel viewModel) {
    return MainInventoryView(viewModel: viewModel, viewEvents: this.viewEvents);
  }

  @override
  Stream<MainInventoryViewModel> getViewModelStream() {
    bloc.pipeIn.send(MainInventoryBlocEventOnInitializeView(this.viewModel));
    return bloc.pipeOut.receive;
  }

}
