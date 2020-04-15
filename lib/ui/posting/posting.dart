import 'package:flutter/material.dart';
// import 'package:uf_ride_share_app/components/date_picker.dart';
import 'package:intl/intl.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uf_ride_share_app/components/counter.dart';
import 'package:us_states/us_states.dart';
import 'package:uf_ride_share_app/models/user.dart';

/*
  Postings page with validator to check that there is no empty field
  Saves destination and arrival city in _fromCity and _toCity respectively
  Uses a TextFormField inside a Card
  Containers are used to manipulate height, width, margins, alignment

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
  int _numSeats = 1;
  List<String> _states = USStates.getAllAbbreviations();
  String _arrivalStateSelected = "FL";
  String _departureStateSelected = "FL";
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

  Widget _buildDeparture() {
    // Departure form
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TextFormField(
              validator: (input) =>
                  input.isEmpty ? "Please enter a city name" : null,
              onChanged: (input) => _fromCity = input,
              decoration: InputDecoration(
                labelText: 'Starting City',
                border: OutlineInputBorder(
                  borderSide:
                    BorderSide(color: Colors.teal[300], width: 1.0),
            )),
          )),
          SizedBox(width: 20),
          DropdownButton<String>(
            iconEnabledColor: Colors.tealAccent[700],
            items: _states.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String newValueSelected) {
              _onDepartureStateSelected(newValueSelected);
            },
            value: _departureStateSelected,
          )
      ])
    );
  }

  Widget _buildArrival() {
    //Arrival form
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [
          Expanded(
            child:TextFormField(
            validator: (input) =>
                input.isEmpty ? "Please enter a city name" : null,
            onChanged: (input) => _toCity = input,
            decoration: InputDecoration(
                labelText: 'Destination City',
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.teal[300], width: 1.0),
                )
              ),
            )
          ),
          SizedBox(width: 20),
          DropdownButton<String>(
            iconEnabledColor: Colors.tealAccent[700],
            items: _states.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value)
              );
            }).toList(),
            onChanged: (String newValueSelected) {
              _onArrivalStateSelected(newValueSelected);
            },
            value: _arrivalStateSelected,
          )
      ])
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildDeparture(),
            _buildArrival(),
            //Show chosen date
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(15),
                  alignment: Alignment.topLeft,
                  child: Text(
                    _date == null
                      ? 'No date chosen'
                      : DateFormat.yMMMd().format(_date),
                )),

            //Date picker button
            Container(
              alignment: Alignment.topLeft,
              child: RaisedButton(
                color: Colors.tealAccent[700],
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
            )),
          ]),

          //Time text
          Row(children: <Widget>[
            Container(
              margin: EdgeInsets.all(15),
              alignment: Alignment.topLeft,
              child: Text(timeText == "" ? 'No time chosen' : timeText,
            )),

            //Time picker
            RaisedButton(
              child: Icon(Icons.access_time),
              onPressed: () {
                selectTime(context);
              },
              color: Colors.tealAccent[700])
          ]),

          //Seats text
          Row(children: <Widget>[
            Container(
                margin: EdgeInsets.only(right: 15, left: 15, bottom: 10),
                child: Text('Seats:',
            )),

            //Seats picker
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Counter(
                minValue: 1,
                maxValue: 99,
                onChanged: (value) => setState(() {_numSeats = value;})
              )
            )
          ]),

          //Description text
          Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 15, bottom: 10),
              child: Text('Description',
          )),

          //Description input form
          Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                decoration: InputDecoration(
                    //To add border around input
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.tealAccent[700], width: 1.0),
                    ),
                    labelText: "Please include contact information."),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onChanged: (text) {
                  _description = text;
                },
              )),

          //Post button
          Container(
              margin: EdgeInsets.only(top: 40, left: 80, right: 80),
              child: RaisedButton(
                onPressed: _submit,
                child: Text('Post'),
                color: Colors.teal[300],
              )),
            ],
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
         backgroundColor: Colors.lightGreenAccent,
          title: Text("Make a Posting"),
          centerTitle: true,
      ),
      body: _buildForm()
    );
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
        'end_location': _toCity + '_' + _arrivalStateSelected,
        'seats': _numSeats,
        'start_location': _fromCity + '_' + _departureStateSelected,
        'time': DateTime(
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
  void _onArrivalStateSelected(String newValueSelected) {
    setState(() {
      this._arrivalStateSelected = newValueSelected;
    });
  }
  void _onDepartureStateSelected(String newValueSelected) {
    setState(() {
      this._departureStateSelected = newValueSelected;
    });
  }
}
