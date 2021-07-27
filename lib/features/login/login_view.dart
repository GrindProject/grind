import 'package:automated_inventory/framework/view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';


import 'login_viewevents.dart';
import 'login_viewmodel.dart';

import 'package:google_sign_in/google_sign_in.dart';

class LoginView extends View<LoginViewModel, LoginViewEvents> {
  bool isSwitched = false;

  LoginView(
      {required LoginViewModel viewModel, required LoginViewEvents viewEvents})
      : super(viewModel: viewModel, viewEvents: viewEvents);

  @override
  Widget build(BuildContext context) {
    _checkIfThereIsResponseForSigningIn(context);
    return Scaffold(

      backgroundColor: Colors.blue,

      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
            crossAxisAlignment: CrossAxisAlignment.center, //Center Column contents horizontally,
          children: [
            Text('AITS', style: new TextStyle(fontSize: 96, color: Colors.white)),
              Image.asset('assets/images/AITSLogo.PNG'),
            Text('Automated Inventory Tracking System', style: new TextStyle(fontSize: 20, color: Colors.white)),
            Text(''),
            Text(''),
            Text(''),

            /*  /// login/out button
            ElevatedButton(
              onPressed: () {
                this.viewEvents.startLogin(context, viewModel);
              },
              child: Text("Login GMail"),
            ),



            ElevatedButton(
              onPressed: () {

              },
              child: Text("Login FaceBook"),
            ), */

            SignInButton(
              Buttons.Google,
              text: "Sign up with Google",
              onPressed: () {
                this.viewEvents.startLogin(context, viewModel);
              },
            ),


           /* SignInButton(
              Buttons.Facebook,
              text: "Sign up with FaceBook",
              onPressed: () {
                this.viewEvents.startLoginWithFacebook(context, viewModel);
              },
            ),
            */


            /// user's email
              (this.viewModel.userEmail != null)
                ? Text(this.viewModel.userEmail!)
                : SizedBox.shrink(),


          ],
        ),
      ),
    );
  }

  void _checkIfThereIsResponseForSigningIn(BuildContext context) {
    if (this.viewModel.userEmail != null) {
      Future.delayed(Duration(milliseconds: 300), () {
        this.viewEvents.navigateToTheMainInventoryScreen(context, this.viewModel);
      });
    }
  }

}
