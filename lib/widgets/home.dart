import 'package:expensetracker/model/expense_model.dart';
import 'package:flutter/material.dart';

import 'expense_list.dart';
import 'input_sheet.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  List<ExpenseModel> _expensesList = [];

  void _updateList(String name, String price, String date) {
    setState(() {
      _expensesList.add(
          ExpenseModel(name: name, price: double.parse(price), date: date));
    });
  }

  void removeItem(ExpenseModel model) {
    setState(() {
      _expensesList.remove(model);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Personal Expense Tracker",
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Personal Expense Tracker"),
        ),
        body: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 500,
              height: 100,
              child: Card(
                color: Colors.yellow,
              ),
            ),
            Container(
              height: 400,
              width: 500,
              child: _expensesList.isEmpty
                  ? Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: Image.asset(
                            'assets/images/attachment.jpg',
                            width: 500,
                            height: 300,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "No Item to display!",
                            style: TextStyle(
                              color: Colors.cyan,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ],
                    )
                  : ExpenseList(
                      expensesList: _expensesList,
                      selectHandler: removeItem,
                    ),
            ),
          ],
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) => InputSheet(_updateList));
          },
        ),
      ),
    );
  }
}
