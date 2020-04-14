import 'package:flutter/material.dart';
// import 'package:uf_ride_share_app/components/date_picker.dart';
import 'package:intl/intl.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../styles/style.dart';
import 'package:uf_ride_share_app/models/user.dart';

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
  DateTime _date;
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
    return Scaffold (
      appBar: AppBar(
         backgroundColor: Colors.lightGreenAccent,
          title: Text("Make a Posting"),
          centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: new Container(
          alignment: Alignment.center,
          child: new Card(
            margin: EdgeInsets.all(30),
            child: ListView(
              children: <Widget>[


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
                          borderSide:
                              BorderSide(color: Colors.teal[300], width: 1.0),
                        )),
                    validator: (input) =>
                        input.isEmpty ? "Please enter a city name" : null,
                    onChanged: (input) => _fromCity = input,
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
                          borderSide:
                              BorderSide(color: Colors.teal[300], width: 1.0),
                        )),
                    validator: (input) =>
                        input.isEmpty ? "Please enter a city name" : null,
                    onChanged: (input) => _toCity = input,
                  ),
                ),

                //Show chosen date
                new Row(children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(15),
                      alignment: Alignment.topLeft,
                      child: Text(
                          _date == null
                              ? 'No date chosen'
                              : DateFormat.yMMMd().format(_date),
                          style: TextStyle(
                              fontSize: 20, fontFamily: FontNameUbuntu))),

                  //Date picker button
                  Container(
                      alignment: Alignment.topLeft,
                      child: RaisedButton(
                          child: Icon(Icons.calendar_today),
                          onPressed: () {
                            showDatePicker(
                                    context: context,
                                    initialDate:
                                        _date == null ? DateTime.now() : _date,
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime(2021))
                                .then((date) {
                              setState(() {
                                _date = date;
                              });
                            });
                          },
                          color: Colors.tealAccent[700]))
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
                  RaisedButton(
                      child: Icon(Icons.access_time),
                      onPressed: () {
                        selectTime(context);
                      },
                      color: Colors.tealAccent[700])
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
                          labelText: "Please include contact information."),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style:
                          TextStyle(fontSize: 15, fontFamily: FontNameUbuntu),
                      onChanged: (text) {
                        _description = text;
                      },
                    )),
                //Post button
                Container(
                    margin: EdgeInsets.only(top: 20, left: 15, right: 15),
                    child: new RaisedButton(
                      onPressed: _submit,
                      child: Text('Post',
                          style: TextStyle(
                              fontFamily: FontNameUbuntu, fontSize: 18)),
                      color: Colors.teal[300],
                    )),
              ],
            ),
          ),
        )));
  }

//if validate, then save input in city variables, else print error message
  void _submit() async {
    // if (_date == null) {
    //   print("error");
    // }
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      //   print(_fromCity);
      //   print(_toCity);
      //   print(_date);
      //   print(timeText);
      //   print(_numSeatsSelected);
      //   print(_description);
    }

    //get id of logged in user
    // final FirebaseAuth _auth = FirebaseAuth.instance;
    // FirebaseUser user = await _auth.currentUser();
    // final uid = user.uid;
    if (_toCity != null &&
        _toCity.isNotEmpty &&
        _fromCity != null &&
        _fromCity.isNotEmpty &&
        picked != null &&
        _date != null) {
      print("pass");
      String currentUser;
      currentUser = await getCurrentUser();

      await databaseReference.collection("Rides").add({
        'description': _description,
        'end_location': _toCity,
        'seats': int.parse(_numSeatsSelected),
        'start_location': _fromCity,
        'time': new DateTime(
            _date.year, _date.month, _date.day, picked.hour, picked.minute),
        'driver': currentUser,
        'passengers': [],
        'rating': null,
      });
    } else {
     //show snack bar
     Scaffold.of(context).showSnackBar(
       SnackBar(
         content: Text("Please fill out all required information!"),
         backgroundColor: Colors.red,
       )
     ); 
    }
  }

//update shown value in list button with selected value
  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._numSeatsSelected = newValueSelected;
    });
  }
}
