import 'package:automated_inventory/features/manage_item/manage_item_view.dart';
import 'package:automated_inventory/features/scan_item_in/scam_item_in_blocevent.dart';
import 'package:automated_inventory/features/scan_item_in/scan_item_in_bloc.dart';
import 'package:automated_inventory/features/scan_item_in/scan_item_in_view.dart';
import 'package:automated_inventory/features/scan_item_in/scan_item_in_viewevents.dart';
import 'package:automated_inventory/features/scan_item_in/scan_item_in_viewmodel.dart';
import 'package:automated_inventory/framework/presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';


class ScanItemInPresenter extends Presenter<ScanItemInView, ScanItemInViewModel, ScanItemInViewEvents, ScanItemInBloc> {
  ScanItemInPresenter(ScanItemInViewEvents viewEvents, ScanItemInBloc bloc, ScanItemInViewModel viewModel)
      : super(viewEvents: viewEvents, bloc: bloc, viewModel: viewModel);

  ScanItemInPresenter.withDefaultsViewModelViewActions(ScanItemInBloc bloc)
      : super(viewEvents: ScanItemInViewEvents(bloc), bloc: bloc, viewModel: ScanItemInViewModel());

  ScanItemInPresenter.withDefaultConstructors() : this.withDefaultsViewModelViewActions(ScanItemInBloc());

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
  ScanItemInView buildView(BuildContext context, ScanItemInViewModel viewModel) {
    return ScanItemInView(viewModel: viewModel, viewEvents: this.viewEvents);
  }

  @override
  Stream<ScanItemInViewModel> getViewModelStream() {
    bloc.pipeIn.send(ScanItemInBlocEventOnInitializeView(this.viewModel));
    return bloc.pipeOut.receive;
  }
}
