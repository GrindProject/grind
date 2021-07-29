import 'package:automated_inventory/framework/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'manage_item_viewevents.dart';
import 'manage_item_viewmodel.dart';

class ManageItemView extends View<ManageItemViewModel, ManageItemViewEvents> {

  /*
  DateTime _date = DateTime.now();
  Future<Null> selectDate(BuildContext context) async
  {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1970),
        lastDate: DateTime(2030)
    );
  }
   */

  ManageItemView({required ManageItemViewModel viewModel, required ManageItemViewEvents viewEvents}) : super(viewModel: viewModel, viewEvents: viewEvents);

  @override
  Widget build(BuildContext context) {
    _checkIfThereIsResponseForSavingItem(context);
    _checkIfThereIsResponseForSearchItem(context);
    return Scaffold(
      backgroundColor: Colors.blue,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(this.viewModel.screenTitle),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                this.viewEvents.saveItem(this.viewModel);
              }),
        ],
      ),
      body: Column(children: <Widget>[

        Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: this.viewModel.upcNumberController,
            decoration: InputDecoration(
              fillColor: Colors.white, filled: true,
              border: UnderlineInputBorder(borderSide: new BorderSide(width: 16.0)),
              labelText: 'UPC Number',
              suffixIcon: IconButton(
                icon: Icon(MdiIcons.searchWeb),
                onPressed: () {
                  this.viewEvents.searchUPCNumber(this.viewModel);
                },

              ),

            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: this.viewModel.nameController,
            decoration: InputDecoration(
              fillColor: Colors.white, filled: true,
              border: UnderlineInputBorder(borderSide: new BorderSide(width: 16.0)),
              labelText: 'Description',
            ),
          ),
        ),


        Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: this.viewModel.measureController,
            decoration: InputDecoration(
              fillColor: Colors.white, filled: true,
              border: UnderlineInputBorder(borderSide: new BorderSide(width: 16.0)),
              labelText: 'Measure',
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            readOnly: true,
            showCursor: true,
            controller: this.viewModel.expirationDateController,
            onTap: () {
              _pickDate(context);
            },
            decoration: InputDecoration(
              fillColor: Colors.white, filled: true,
              border: UnderlineInputBorder(borderSide: new BorderSide(width: 16.0)),
              labelText: 'Expiration Date',
            ),
          ),
        ),

      ]),

    );
  }

  void _checkIfThereIsResponseForSavingItem(BuildContext context) {
    if (this.viewModel.responseToSaveItem != null) {
      Future.delayed(Duration(milliseconds: 300), () {
        if (this.viewModel.responseToSaveItem!.code == 1)
          _showAlertDialogItemSavedOK(context);
        else
          _showAlertDialogItemSaveError(context, this.viewModel.responseToSaveItem!.message);
      });
    }
  }

  void _checkIfThereIsResponseForSearchItem(BuildContext context) {
    if (this.viewModel.responseToSearchItem != null) {
      Future.delayed(Duration(milliseconds: 300), () {
        if (this.viewModel.responseToSearchItem!.code == 1)
          _showAlertDialogItemSearchOK(context);
        else
          _showAlertDialogItemSearchError(context, this.viewModel.responseToSearchItem!.message);
      });
    }
  }

  void _showAlertDialogItemSavedOK(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Success!'),
        content: Text('Your item was saved!'),
        actions: <Widget>[
          new TextButton(
            onPressed: () {
              this.viewModel.responseToSaveItem = null;
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.of(context).pop();
            },
            child: new Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showAlertDialogItemSaveError(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Error!'),
        content: Text('There were errors while saving your item! ' + errorMessage),
        actions: <Widget>[
          new TextButton(
            onPressed: () {
              this.viewModel.responseToSaveItem = null;
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: new Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showAlertDialogItemSearchOK(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Success!'),
        content: Text('1 item was found! Description and Measure were updated'),
        actions: <Widget>[
          new TextButton(
            onPressed: () {
              this.viewModel.responseToSearchItem = null;
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: new Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showAlertDialogItemSearchError(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Error!'),
        content: Text(errorMessage),
        actions: <Widget>[
          new TextButton(
            onPressed: () {
              this.viewModel.responseToSearchItem = null;
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: new Text('OK'),
          ),
        ],
      ),
    );
  }

  void _pickDate(BuildContext context) async {
    DateTime? date = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 9999)),);
    if (date != null) {
      this.viewModel.expirationDateController.text = date.year.toString() + "-" + date.month.toString()+ "-" + date.day.toString();
    }
  }
}
