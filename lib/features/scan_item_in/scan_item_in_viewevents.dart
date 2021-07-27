import 'package:automated_inventory/features/scan_item_in/scam_item_in_blocevent.dart';
import 'package:automated_inventory/features/scan_item_in/scan_item_in_bloc.dart';
import 'package:automated_inventory/features/scan_item_in/scan_item_in_viewmodel.dart';
import 'package:automated_inventory/framework/viewevents.dart';


class ScanItemInViewEvents extends ViewEvents<ScanItemInBloc> {
  ScanItemInViewEvents(ScanItemInBloc bloc) : super(bloc);

  void scanItemByUPCCode(ScanItemInViewModel viewModel) {
    ScanItemInBlocEventScanUsingUPC blocEvent = ScanItemInBlocEventScanUsingUPC(viewModel);
    this.bloc.pipeIn.send(blocEvent);
  }


}

