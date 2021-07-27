import 'package:automated_inventory/framework/viewmodel.dart';

abstract class BlocEvent<VM extends ViewModel> {

  final VM viewModel;

  BlocEvent(this.viewModel);

}

