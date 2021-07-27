import 'package:automated_inventory/businessmodels/product/product_businessmodel.dart';
import 'package:automated_inventory/businessmodels/product/product_provider.dart';
import 'package:automated_inventory/features/login/login_blocevent.dart';
import 'package:automated_inventory/features/login/login_viewmodel.dart';
import 'package:automated_inventory/framework/bloc.dart';
import 'package:automated_inventory/framework/codemessage.dart';
import 'package:automated_inventory/modules/user_information.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginBloc extends Bloc<LoginViewModel, LoginBlocEvent> {

  @override
  void onReceiveEvent(LoginBlocEvent event) {
    if (event is LoginBlocEventOnInitializeView) _onInitializeView(event);
    if (event is LoginBlocEventSignIn) _onSignIn(event);
    if (event is LoginBlocEventSignInWithFacebook) _onSignInWithFacebook(event);
    if (event is LoginBlocEventSignOut) _onSignOut(event);
  }

  void _onInitializeView(LoginBlocEvent event) async {
    UserCredential? userCredential = await _signInWithGoogle(true);
    if ((userCredential == null) || (userCredential.user == null)) {
      event.viewModel.userEmail = null;
      this.pipeOut.send(event.viewModel);
    } else {
      event.viewModel.userEmail = userCredential.user!.email!;
      this.pipeOut.send(event.viewModel);
    }
  }

  void _onSignIn(LoginBlocEventSignIn event) async {
    UserCredential? userCredential = await _signInWithGoogle(false);
    if ((userCredential == null) || (userCredential.user == null)) {
      event.viewModel.userEmail = null;
      this.pipeOut.send(event.viewModel);
    } else {
      event.viewModel.userEmail = userCredential.user!.email!;
      this.pipeOut.send(event.viewModel);
    }
  }

  void _onSignOut(LoginBlocEventSignOut event) async {
    /// which one?
    await GoogleSignIn().signOut();
    event.viewModel.userEmail = null;
    this.pipeOut.send(event.viewModel);
  }

  Future<UserCredential?> _signInWithGoogle(bool signInSilently) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser =  signInSilently ? await GoogleSignIn().signInSilently() : await GoogleSignIn().signIn();
    if (googleUser == null) return null;


    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser
        .authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserInformation.userName = googleUser.displayName ?? '';
    UserInformation.userPhotoUrl = googleUser.photoUrl ?? '';

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);

  }

  Future<UserCredential?> _onSignInWithFacebook(LoginBlocEventSignInWithFacebook event) async {
    // Trigger the sign-in flow
    LoginResult result = await FacebookAuth.instance.login();
    if (result.accessToken == null) return null;

    // Create a credential from the access token
    final facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken!.token);

    UserInformation.userName = result.accessToken!.userId;
    UserInformation.userPhotoUrl = '';

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }



}
