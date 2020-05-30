import 'package:flutter/material.dart';

class InputSheet extends StatefulWidget {
  final Function _selectHandler;

  InputSheet(this._selectHandler);

  @override
  State<StatefulWidget> createState() {
    return _InputSheetState(_selectHandler);
  }
}

class _InputSheetState extends State<InputSheet> {
  var nameController = TextEditingController();
  var priceController = TextEditingController();
  final Function _selectHandler;

  _InputSheetState(this._selectHandler);

  void _submitData() {
    if (nameController.text.isNotEmpty && priceController.text.isNotEmpty) {
      _selectHandler(nameController.text, priceController.text);
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
                  onSubmitted: (_) {
                    _submitData();
                  },
                  decoration: InputDecoration(labelText: "Item Name"),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) {
                    _submitData();
                  },
                  decoration: InputDecoration(labelText: "Item Price"),
                ),
              ),
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
