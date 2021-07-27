import 'package:automated_inventory/features/main_inventory/main_inventory_bloc.dart';
import 'package:automated_inventory/framework/view.dart';
import 'package:automated_inventory/framework/viewevents.dart';
import 'package:automated_inventory/framework/viewmodel.dart';
import 'package:flutter/cupertino.dart';

import 'bloc.dart';

abstract class Presenter<V extends View, VM extends ViewModel, VE extends ViewEvents, B extends Bloc> extends StatelessWidget {

  final VE viewEvents;
  final VM viewModel;
  final B bloc;

  const Presenter({Key? key, required this.viewEvents, required this.bloc, required this.viewModel}) : super(key: key);

  Stream<VM> getViewModelStream();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<VM>(
      stream: getViewModelStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return buildLoadingView(context);
        } else if (!snapshot.hasData) {
          return buildLoadingView(context);
        } else {
          return buildView(context, snapshot.data!);
        }
      },
    );
  }

  V buildView(BuildContext context, VM viewModel);

  Widget buildLoadingView(BuildContext context);


}