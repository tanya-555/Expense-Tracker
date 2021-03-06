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
  var switchState = false;

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
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return new MaterialApp(
      title: "Personal Expense Tracker",
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Personal Expense Tracker"),
        ),
        body: LayoutBuilder(builder: (ctx, constraint) {
          return Container(
              child: _expensesList.isEmpty
                  ? Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/attachment.jpg',
                            width: constraint.maxWidth * 0.8,
                            height: constraint.maxHeight * 0.6,
                            alignment: Alignment.center,
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
                  : (!isLandscape
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                width: constraint.maxWidth * 1,
                                height: constraint.maxHeight * 0.4,
                                child: Container(
                                  child: PieChartRep(chart),
                                )),
                            Container(
                              height: constraint.maxHeight * 0.6,
                              width: constraint.maxWidth * 1,
                              child: ExpenseList(
                                expensesList: _expensesList,
                                selectHandler: removeItem,
                              ),
                            ),
                          ],
                        )
                      : Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                  width: constraint.maxWidth * 1,
                                  height: constraint.maxHeight * 0.2,
                                  child: Column(
                                    children: <Widget>[
                                      Switch(
                                        value: switchState,
                                        onChanged: (value) {
                                          setState(() {
                                            switchState = value;
                                          });
                                        },
                                      ),
                                      Text(
                                        "Show Chart",
                                        style: TextStyle(
                                          color: Colors.cyan,
                                        ),
                                      )
                                    ],
                                  )),
                              Container(
                                width: constraint.maxWidth * 1,
                                height: constraint.maxHeight * 0.8,
                                child: switchState
                                    ? Container(
                                        child: PieChartRep(chart),
                                      )
                                    : ExpenseList(
                                        expensesList: _expensesList,
                                        selectHandler: removeItem,
                                      ),
                              ),
                            ],
                          ),
                        )));
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => InputSheet(_updateList));
          },
        ),
      ),
    );
  }
}
