import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDatePicker extends StatefulWidget {
  MyDatePicker({Key key}) : super(key: key);

  @override
    _MyDatePickerState createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
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
        Text(DateFormat.yMd().format(selectedDate)),
        IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () => _selectDate(context),
        ),
      ]));
  }
}