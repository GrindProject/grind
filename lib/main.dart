import 'package:automated_inventory/features/main_inventory/main_inventory_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';


import 'features/login/login_presenter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    themeMode: ThemeMode.light,
    theme: new ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: LoginPresenter.withDefaultConstructors(),

   // home: MainInventory.withDefaultConstructors(),
  ));
}

/*
class MyApp extends StatefulWidget {

  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  final List<String> names = <String>['Aby', 'Aish', 'Ayan', 'Ben', 'Bob', 'Charlie', 'Cook', 'Carline'];
  final List<String> expiration = <String>['Aby', 'Aish', 'Ayan', 'Ben', 'Bob', 'Charlie', 'Cook', 'Carline'];
  final List<String> measure = <String>['Aby', 'Aish', 'Ayan', 'Ben', 'Bob', 'Charlie', 'Cook', 'Carline'];
  final List<String> addedOn = <String>['Aby', 'Aish', 'Ayan', 'Ben', 'Bob', 'Charlie', 'Cook', 'Carline'];

  final List<int> msgCount = <int>[2, 0, 10, 6, 52, 4, 0, 2];

  TextEditingController nameController = TextEditingController();
  TextEditingController expController = TextEditingController();
  TextEditingController measureController = TextEditingController();
  TextEditingController addedOnController = TextEditingController();


  void addItemToList(){
    setState(() {
      names.insert(0,nameController.text);
      expiration.insert(0,expController.text);
      measure.insert(0,measureController.text);
      msgCount.insert(0, 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Tutorial - googleflutter.com'),
        ),
        body: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: expController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Expiration Date',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: measureController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Measure',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: addedOnController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Added On',
                  ),
                ),
              ),

              ElevatedButton(
                child: Text('Add'),
                onPressed: () {
                  addItemToList();
                },
              ),
              Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: names.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 50,
                          margin: EdgeInsets.all(2),
                          color: msgCount[index]>=10? Colors.blue[400]:
                          msgCount[index]>3? Colors.blue[100]: Colors.grey,
                          child: Center(
                              child: Text('${names[index]}  ${expiration[index]} ${measure[index]} ${addedOn[index]}  ',
                                style: TextStyle(fontSize: 18),

                              )
                          ),
                        );
                      }
                  )
              )
            ]
        )
    );
  }
}





    /* Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: this.viewModel.nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: this.viewModel.expController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Expiration Date',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: this.viewModel.measureController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Measure',
              ),
            ),
          ),
          ElevatedButton(
            child: Text('Add'),
            onPressed: () {
              this.viewEvents.addItemToList(this.viewModel);
            },
          ),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: this.viewModel.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.blue,
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(this.viewModel.items[index].id),
                                    Text(this.viewModel.items[index].name),
                                    Text(this.viewModel.items[index].expirationDate),
                                    Text(this.viewModel.items[index].measure),
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
                  }))
        ]));
     */



 */
