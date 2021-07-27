import 'package:automated_inventory/framework/viewevents.dart';
import 'package:automated_inventory/framework/viewmodel.dart';
import 'package:flutter/cupertino.dart';

abstract class View<VM extends ViewModel, VE extends ViewEvents> extends StatelessWidget {

  final VM viewModel;
  final VE viewEvents;

  const View({Key? key, required this.viewModel, required this.viewEvents}) : super(key: key);

  /*
   @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();

  (viewModel as LoginViewModel).errorMessage

  }
  */

}