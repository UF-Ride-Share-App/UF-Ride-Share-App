import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:uf_ride_share_app/ui/landing/datePicker.dart';

class Search extends StatelessWidget {
  final top = Container(
  padding: EdgeInsets.all(5),
  child: TextField(
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      labelText: 'Start location'
    )
  )
);

final middle = Container(
  padding: EdgeInsets.all(5),
  child: TextField(
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      labelText: 'End location'
    )
  )
);

final bottom = Container(
  padding: EdgeInsets.all(5),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      MyDatePicker(), 
      RaisedButton(
        child: Text('Search'),
        onPressed: () {},
      )
    ],
  )
);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          top,
          middle,
          bottom,
        ]
      )
    );
  }
}