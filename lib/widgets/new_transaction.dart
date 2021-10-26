import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime _selectedDate;

  submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (!(enteredTitle.isEmpty ||
        enteredAmount <= 0 ||
        _selectedDate == null)) {
      widget.addTx(enteredTitle, enteredAmount, _selectedDate);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => submitData(),
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
              // onChanged: (val) => amountInput = val,
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Text(_selectedDate == null
                      ? 'No Date chosen.'
                      : DateFormat.yMMMd().format(_selectedDate)),
                  FlatButton(
                    onPressed: () => _openDatePicker(context),
                    child: Text('Choose date',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    textColor: Theme.of(context).colorScheme.secondary,
                  )
                ],
              ),
            ),
            RaisedButton(
              child: Text('Add Transaction'),
              textColor:
                  Theme.of(context).buttonTheme.colorScheme.primaryVariant,
              color: Theme.of(context).buttonTheme.colorScheme.background,
              onPressed: submitData,
            ),
          ],
        ),
      ),
    );
  }

  void _openDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            lastDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 14)))
        .then((date) {
      print("Date ${date}");
      if (date != null) {
        setState(() {
          print("Set state");
          _selectedDate = date;
        });
      }
    });
  }
}
