import 'package:automated_inventory/features/login/login_bloc.dart';
import 'package:automated_inventory/features/login/login_viewmodel.dart';
import 'package:automated_inventory/features/main_inventory/main_inventory_presenter.dart';
import 'package:automated_inventory/features/manage_item/manage_item_presenter.dart';
import 'package:automated_inventory/framework/viewevents.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_blocevent.dart';

class LoginViewEvents extends ViewEvents<LoginBloc> {
  LoginViewEvents(LoginBloc bloc) : super(bloc);

  void startLogin(BuildContext context, LoginViewModel viewModel) {
    LoginBlocEventSignIn blocEvent = LoginBlocEventSignIn(viewModel);
    this.bloc.pipeIn.send(blocEvent);
  }

  void startLoginWithFacebook(BuildContext context, LoginViewModel viewModel) {
    LoginBlocEventSignInWithFacebook blocEvent = LoginBlocEventSignInWithFacebook(viewModel);
    this.bloc.pipeIn.send(blocEvent);
  }

  void navigateToTheMainInventoryScreen(BuildContext context, LoginViewModel viewModel) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainInventoryPresenter.withDefaultConstructors()),
    ).then((value) {
      startLogout(context, viewModel);
    });
  }

  void startLogout(BuildContext context, LoginViewModel viewModel) {
    LoginBlocEventSignOut blocEvent = LoginBlocEventSignOut(viewModel);
    this.bloc.pipeIn.send(blocEvent);
  }




}
