import 'package:expensetracker/model/expense_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final ExpenseModel item;
  final Function selectHandler;

  ListItem({
    @required this.item,
    @required this.selectHandler,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.all(2),
      child: Card(
        child: Row(
          children: <Widget>[
            Flexible(
              fit: FlexFit.tight,
              child: Container(
                width: 50,
                height: 50,
                child: CircleAvatar(
                  backgroundColor: Colors.cyan,
                  child: Text(
                    "\$" + item.price.toStringAsFixed(2),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      item.name,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    child: Text("\$" + item.price.toStringAsFixed(2)),
                  ),
                ],
              ),
            ),
            Container(
              child: IconButton(
                color: Colors.cyan,
                icon: Icon(Icons.delete),
                onPressed: () {
                  selectHandler(item);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
