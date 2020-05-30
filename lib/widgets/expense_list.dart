import 'package:expensetracker/model/expense_model.dart';
import 'package:flutter/material.dart';

import 'list_item.dart';

class ExpenseList extends StatelessWidget {
  final List<ExpenseModel> expensesList;
  final Function selectHandler;

  ExpenseList({
    @required this.expensesList,
    @required this.selectHandler,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemCount: expensesList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListItem(
          item: expensesList[index],
          selectHandler: selectHandler,
        );
      },
    );
  }
}
