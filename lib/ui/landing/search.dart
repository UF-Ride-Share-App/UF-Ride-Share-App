import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:uf_ride_share_app/components/date_picker.dart';

class Search extends StatefulWidget {
  final Function(String, String, DateTime) onSearch;

  Search({@required this.onSearch});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final startController = TextEditingController();
  final endController = TextEditingController();
  DateTime searchDate;

  @override
  void dispose() {
    startController.dispose();
    endController.dispose();
    super.dispose();
  }

  Widget _buildTop() {
    return Container(
        padding: EdgeInsets.all(5),
        child: TextField(
            controller: startController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Starting city')));
  }

  Widget _buildMiddle() {
    return Container(
        padding: EdgeInsets.all(5),
        child: TextField(
            controller: endController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Destination city')));
  }

  Widget _buildBottom() {
    return Container(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MyDatePicker(
              getDate: (DateTime selectedDate) {
                setState(() {
                  this.searchDate = selectedDate;
                });
              },
            ),
            RaisedButton(
              child: Text('Search'),
              onPressed: () {
                this.widget.onSearch(
                    startController.text, endController.text, searchDate);
              },
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildTop(),
              _buildMiddle(),
              _buildBottom(),
            ]));
  }
}
