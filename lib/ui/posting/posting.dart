import 'package:flutter/material.dart';
import 'package:uf_ride_share_app/components/date_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../styles/style.dart';

/*
  Postings page with validator to check that there is no empty field
  Saves destination and arrival city in _fromCity and _toCity respectively
  Uses a TextFormField inside a Card
  Containers are used to manipulate height, width, margins, alignment
  TODO: figure out how to store in database

*/

class Posting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PostingState();
  }
}

class _PostingState extends State<Posting> {
  final _formKey = GlobalKey<FormState>();
  String _toCity, _fromCity;
  DateTime _dateTime;
  var _numSeats = ["1", "2", "3", "4", "5"];
  var _numSeatsSelected = "1";
  String _description = "";
  final databaseReference = Firestore.instance;

  //keep track of time
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay picked;
  String timeText = "";

  Future<Null> selectTime(BuildContext context) async {
    picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    if (picked != null) {
      //format time as HH:MM am/pm
      String formattedTime =
          localizations.formatTimeOfDay(picked, alwaysUse24HourFormat: false);
      if (formattedTime != null) {
        setState(() {
          timeText = formattedTime;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: new Container(
          alignment: Alignment.center,
          child: new Card(
            margin: EdgeInsets.all(30),
            child: ListView(
              children: <Widget>[
                Text("Make a Posting",
                    textAlign: TextAlign.center,
                    style: FlexibleSpaceBarTextStyle),
                // Departure form
                new Container(
                  margin:
                      EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 15),
                  child: new TextFormField(
                    style: TextStyle(fontFamily: FontNameUbuntu, fontSize: 18),
                    decoration: InputDecoration(
                        labelText: 'Departure City',
                        labelStyle:
                            TextStyle(fontFamily: FontNameUbuntu, fontSize: 18),
                        hintStyle: TextStyle(fontSize: 18),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.tealAccent[700], width: 1.0),
                        )),
                    validator: (input) =>
                        input.isEmpty ? "Please enter a city name" : null,
                    onSaved: (input) => _fromCity = input,
                  ),
                ),
                //Arrival form
                new Container(
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: new TextFormField(
                    style: TextStyle(fontFamily: FontNameUbuntu, fontSize: 18),
                    decoration: InputDecoration(
                        labelText: 'Arrival City',
                        labelStyle:
                            TextStyle(fontFamily: FontNameUbuntu, fontSize: 18),
                        hintStyle: TextStyle(fontSize: 18),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.tealAccent[700], width: 1.0),
                        )),
                    validator: (input) =>
                        input.isEmpty ? "Please enter a city name" : null,
                    onSaved: (input) => _toCity = input,
                  ),
                ),
                //Show chosen date
                new Row(children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(15),
                      alignment: Alignment.topLeft,
                      child: Text(
                          _dateTime == null
                              ? 'No date chosen'
                              : _dateTime.toString().split(' ')[0],
                          style: TextStyle(
                              fontSize: 20, fontFamily: FontNameUbuntu))),
                  //Date picker button
                  Container(
                      alignment: Alignment.topLeft,
                      child: MaterialButton(
                        color: Colors.tealAccent[700],
                        child: Icon(Icons.calendar_today),
                        onPressed: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: _dateTime == null
                                      ? DateTime.now()
                                      : _dateTime,
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2021))
                              .then((date) {
                            setState(() {
                              _dateTime = date;
                            });
                          });
                        },
                      ))
                ]),
                //Time text
                new Row(children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(15),
                      alignment: Alignment.topLeft,
                      child: Text(timeText == "" ? 'No time chosen' : timeText,
                          style: TextStyle(
                              fontSize: 20, fontFamily: FontNameUbuntu))),
                  //Time picker
                  MaterialButton(
                      color: Colors.tealAccent[700],
                      child: Icon(Icons.access_time),
                      onPressed: () {
                        selectTime(context);
                      })
                ]),
                //Seats text
                new Row(children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(right: 15, left: 15, bottom: 10),
                      child: Text('Seats:',
                          style: TextStyle(
                              fontSize: 20, fontFamily: FontNameUbuntu))),
                  //Seats picker
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: DropdownButton<String>(
                        iconEnabledColor: Colors.tealAccent[700],
                        items: _numSeats.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem,
                                style: TextStyle(
                                    fontFamily: FontNameUbuntu, fontSize: 20)),
                          );
                        }).toList(),
                        onChanged: (String newValueSelected) {
                          _onDropDownItemSelected(newValueSelected);
                        },
                        value: _numSeatsSelected,
                      ))
                ]),
                //Description text
                Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 15, bottom: 10),
                    child: Text('Description',
                        style: TextStyle(
                            fontSize: 20, fontFamily: FontNameUbuntu))),
                //Description input form
                Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: TextField(
                      decoration: new InputDecoration(
                          //To add border around input
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.tealAccent[700], width: 1.0),
                          ),
                          labelText: "Additional information"),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style:
                          TextStyle(fontSize: 20, fontFamily: FontNameUbuntu),
                      onChanged: (text) {
                        _description = text;
                      },
                    )),
                //Post button
                Container(
                    margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: new RaisedButton(
                      onPressed: _submit,
                      child: Text('Post',
                          style: TextStyle(
                              fontFamily: FontNameUbuntu, fontSize: 18)),
                      color: Colors.tealAccent[700],
                    )),
              ],
            ),
          ),
        ));
  }

//if validate, then save input in city variables, else print error message
  void _submit() async {
    if (_dateTime == null) {
      print("error");
    }
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(_fromCity);
      print(_toCity);
      print(_dateTime);
      print(timeText);
      print(_numSeatsSelected);
      print(_description);
    }

    await databaseReference.collection("Rides").add({
      'description': _description,
      'end_location': _toCity,
      'seats': int.parse(_numSeatsSelected),
      'start_location': _fromCity,
      'time': new DateTime(_dateTime.year, _dateTime.month, _dateTime.day, picked.hour, picked.minute),
      'driver': 'test',
      'passengers': ['8383hsiefoijw']
    });
  }

//update shown value in list button with selected value
  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._numSeatsSelected = newValueSelected;
    });
  }
}
