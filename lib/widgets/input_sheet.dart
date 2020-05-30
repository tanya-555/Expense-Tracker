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
  String weekDay = new DateFormat("E").format(DateTime.now());
  var nameController = TextEditingController();
  var priceController = TextEditingController();
  final Function _selectHandler;

  _InputSheetState(this._selectHandler);

  void _submitData() {
    if (nameController.text.isNotEmpty && priceController.text.isNotEmpty) {
      _selectHandler(
          nameController.text, priceController.text, selectedDate, weekDay);
      Navigator.of(context).pop();
    }
  }

  void _updateSheet(DateTime date) {
    setState(() {
      selectedDate = new DateFormat("dd MMM, yyyy").format(date);
      weekDay = new DateFormat("E").format(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 500,
        height: 700,
        child: Card(
          margin: EdgeInsets.only(top: 50),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                alignment: Alignment.topRight,
                child: Text(
                  selectedDate,
                  style: TextStyle(
                    color: Colors.cyan,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: "Item Name"),
                  onSubmitted: (_) {
                    _submitData();
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Item Price"),
                  onSubmitted: (_) {
                    _submitData();
                  },
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
                              .then((date) {
                            _updateSheet(date);
                          });
                        },
                      ),
                      Container(
                        child: Text(
                          "Change date",
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
                    "Add Item",
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
