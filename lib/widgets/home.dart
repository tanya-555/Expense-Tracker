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

  void _updateList(String name, String price) {
    setState(() {
      _expensesList.add(ExpenseModel(name: name, price: double.parse(price)));
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
              child: ExpenseList(
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
