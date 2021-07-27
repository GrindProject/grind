import 'package:automated_inventory/features/login/login_viewmodel.dart';
import 'package:automated_inventory/framework/blocevent.dart';

abstract class LoginBlocEvent extends BlocEvent<LoginViewModel> {
  LoginBlocEvent(LoginViewModel viewModel) : super(viewModel);
}

/// base events

class LoginBlocEventOnInitializeView extends LoginBlocEvent {
  LoginBlocEventOnInitializeView(LoginViewModel viewModel) : super(viewModel);
}

/// custom events

class LoginBlocEventSignIn extends LoginBlocEvent {
  LoginBlocEventSignIn(LoginViewModel viewModel) : super(viewModel);
}

class LoginBlocEventSignInWithFacebook extends LoginBlocEvent {
  LoginBlocEventSignInWithFacebook(LoginViewModel viewModel) : super(viewModel);
}

class LoginBlocEventSignOut extends LoginBlocEvent {
  LoginBlocEventSignOut(LoginViewModel viewModel) : super(viewModel);
}
