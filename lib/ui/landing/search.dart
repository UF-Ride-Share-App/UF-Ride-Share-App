import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:uf_ride_share_app/components/date_picker.dart';
import 'package:us_states/us_states.dart';

class Search extends StatefulWidget {
  final Function(String, String, DateTime) onSearch;

  Search({@required this.onSearch});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<String> _states = USStates.getAllAbbreviations();
  String _arrivalState;
  String _departureState;
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
        child: Row (
          children: <Widget> [
            Expanded(
              child: TextField(
                controller: startController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Starting city'))),
            SizedBox(width: 20),
            DropdownButton<String>(
              iconEnabledColor: Colors.tealAccent[700],
              items: _states.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value)
                );
              }).toList(),
              onChanged: (String value) {
                _onDepartureStateSelected(value);
              },
              value: _departureState,
            ),
    ]));
  }

  Widget _buildMiddle() {
    return Container(
        padding: EdgeInsets.all(5),
        child: Row (children: <Widget>[
          Expanded(
            child: TextField(
              controller: endController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Destination city'))),
          SizedBox(width: 20),
          DropdownButton<String>(
            iconEnabledColor: Colors.tealAccent[700],
            items: _states.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value)
              );
            }).toList(),
            onChanged: (String value) {
              _onArrivalStateSelected(value);
            },
            value: _arrivalState,
          ),
    ]));
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
                  startController.text + (_arrivalState == null ? '' : ('_' + _arrivalState)),
                  endController.text + (_departureState == null ? '' : ('_' + _departureState)),
                  searchDate
                );
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

  void _onArrivalStateSelected(String value) {
    setState(() {
      this._arrivalState = value;
    });
  }
  void _onDepartureStateSelected(String value) {
    setState(() {
      this._departureState = value;
    });
  }
}
