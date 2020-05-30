import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputSheet extends StatefulWidget {
  final Function _selectHandler;

  InputSheet(this._selectHandler);

  @override
  State<StatefulWidget> createState() {
    return _InputSheetState(_selectHandler);
  }
}

class _InputSheetState extends State<InputSheet> {
  String selectedDate = new DateFormat("dd MMM, yyyy").format(DateTime.now());
  var nameController = TextEditingController();
  var priceController = TextEditingController();
  final Function _selectHandler;

  _InputSheetState(this._selectHandler);

  void _submitData() {
    if (nameController.text.isNotEmpty && priceController.text.isNotEmpty) {
      _selectHandler(nameController.text, priceController.text, selectedDate);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 500,
        height: 700,
        child: Card(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Item Name"),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Item Price"),
                ),
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        color: Colors.cyan,
                        iconSize: 40.0,
                        icon: Icon(Icons.calendar_today),
                        onPressed: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2050))
                              .then((date) => selectedDate =
                                  new DateFormat("dd MMM, yyyy").format(date));
                        },
                      ),
                      Container(
                        child: Text(
                          "Choose a date",
                          style: TextStyle(
                            color: Colors.cyan,
                            fontSize: 15.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      )
                    ],
                  )),
              FlatButton(
                onPressed: _submitData,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Add Task",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
