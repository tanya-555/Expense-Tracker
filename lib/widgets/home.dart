import 'package:expensetracker/model/expense_model.dart';
import 'package:expensetracker/widgets/pie_chart.dart';
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

  //Map for chart
  var chart = {
    'Sun': 0.0,
    'Mon': 0.0,
    'Tue': 0.0,
    'Wed': 0.0,
    'Thu': 0.0,
    'Fri': 0.0,
    'Sat': 0.0
  };

  void _updateList(String name, String price, String date, String weekDay) {
    setState(() {
      _expensesList.add(ExpenseModel(
          name: name,
          price: double.parse(price),
          date: date,
          weekDay: weekDay));
      chart[weekDay] = chart[weekDay] + double.parse(price);
    });
  }

  void removeItem(ExpenseModel model) {
    setState(() {
      _expensesList.remove(model);
      chart[model.weekDay] = chart[model.weekDay] - model.price;
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
                height: 200,
                child: _expensesList.isEmpty
                    ? SizedBox()
                    : Container(
                        child: PieChartRep(chart),
                      )),
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
