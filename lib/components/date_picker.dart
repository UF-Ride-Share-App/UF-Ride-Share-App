import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDatePicker extends StatefulWidget {
  MyDatePicker({Key key}) : super(key: key);

  @override
    _MyDatePickerState createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  DateTime selectedDate;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate == null
            ? DateTime.now()
            : selectedDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Row (
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 5, right: 5),
          child:
            Text(
              selectedDate == null
                ? 'No date chosen'
                : DateFormat.yMd().format(selectedDate)
            )
        ),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child:
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () => _selectDate(context),
            ),
        )
      ]));
  }
}