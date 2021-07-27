import 'package:automated_inventory/features/login/login_view.dart';
import 'package:automated_inventory/features/login/login_viewevents.dart';
import 'package:automated_inventory/features/login/login_viewmodel.dart';
import 'package:automated_inventory/framework/presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'login_bloc.dart';
import 'login_blocevent.dart';

class LoginPresenter extends Presenter<LoginView, LoginViewModel, LoginViewEvents, LoginBloc> {
  LoginPresenter(LoginViewEvents viewEvents, LoginBloc bloc, LoginViewModel viewModel)
      : super(viewEvents: viewEvents, bloc: bloc, viewModel: viewModel);

  LoginPresenter.withDefaultsViewModelViewActions(LoginBloc bloc)
      : super(viewEvents: LoginViewEvents(bloc), bloc: bloc, viewModel: LoginViewModel());

  LoginPresenter.withDefaultConstructors() : this.withDefaultsViewModelViewActions(LoginBloc());

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
  LoginView buildView(BuildContext context, LoginViewModel viewModel) {
    return LoginView(viewModel: viewModel, viewEvents: this.viewEvents);
  }

  @override
  Stream<LoginViewModel> getViewModelStream() {
    bloc.pipeIn.send(LoginBlocEventOnInitializeView(this.viewModel));
    return bloc.pipeOut.receive;
  }
}
