import 'package:automated_inventory/features/scan_item_in/scan_item_in_viewevents.dart';
import 'package:automated_inventory/features/scan_item_in/scan_item_in_viewmodel.dart';
import 'package:automated_inventory/framework/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';



class ScanItemInView extends View<ScanItemInViewModel, ScanItemInViewEvents> {



  ScanItemInView({required ScanItemInViewModel viewModel, required ScanItemInViewEvents viewEvents}) : super(viewModel: viewModel, viewEvents: viewEvents);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(''),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
               // this.viewEvents.saveItem(this.viewModel);
              }),
        ],
      ),
      body: Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: this.viewModel.upcTextController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'UPC',
            ),
          ),
        ),
        ElevatedButton(onPressed: () {
          this.viewEvents.scanItemByUPCCode(this.viewModel);
        }, child: Text("Search"),),

        Expanded(child: ListView.builder(
          padding: const EdgeInsets.all(4),
          itemCount: this.viewModel.inventoryItems.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              color: Colors.blue,
              child: InkWell(
                onTap: () {
                  // this.viewEvents.manageItem(context, this.viewModel, index);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              this.viewModel.product!.name,
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              'Measure: ' + this.viewModel.product!.measure,
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Exp.Date: ' + this.viewModel.inventoryItems[index].expirationDate,
                              style: TextStyle(color: Colors.white),
                            ),

                            Text(
                              'Qty: ' + this.viewModel.inventoryItems[index].qty.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),

                      Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),),


      ]),

    );
  }


}
