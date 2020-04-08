import 'package:flutter/material.dart';
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
  var _numSeats = ["1", "2", "3", "4"];
  var _numSeatsSelected = "1";
  String _description = "";

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: new Container(
          alignment: Alignment.center,
          child: new Card(
            margin: EdgeInsets.all(20),
            child: ListView(
              children: <Widget>[
<<<<<<< HEAD
                Text("Make a Posting",
                    textAlign: TextAlign.center,
                    style: FlexibleSpaceBarTextStyle),
=======
                Text(
                  "Make a Posting",
                  textAlign: TextAlign.center,
                  style: FlexibleSpaceBarTextStyle
                ),
>>>>>>> 05850db544e4bdae5bbe0077eeb536b0195af870
                // Departure form
                new Container(
                  margin: EdgeInsets.all(10),
                  child: new TextFormField(
<<<<<<< HEAD
                    style: TextStyle(fontFamily: FontNameUbuntu, fontSize: 18),
                    decoration: InputDecoration(
                        hintText: 'Enter the city you are leaving from',
                        labelText: 'Departure City',
                        labelStyle: TextStyle(
                            color: Colors.tealAccent[700],
                            fontFamily: FontNameUbuntu),
                        hintStyle: TextStyle(fontSize: 18)),
=======
                    decoration: const InputDecoration(
                      hintText: 'Enter the city you are leaving from',
                      labelText: 'Departure City',
                    ),
>>>>>>> 05850db544e4bdae5bbe0077eeb536b0195af870
                    validator: (input) =>
                        input.isEmpty ? "Please enter a city name" : null,
                    onSaved: (input) => _fromCity = input,
                  ),
                ),
                //Arrival form
                new Container(
                  margin: EdgeInsets.all(10),
                  child: new TextFormField(
<<<<<<< HEAD
                    style: TextStyle(fontFamily: FontNameUbuntu, fontSize: 18),
                    decoration: InputDecoration(
                        hintText: 'Enter the city you are going to',
                        labelText: 'Arrival City',
                        labelStyle: TextStyle(
                            color: Colors.tealAccent[700],
                            fontFamily: FontNameUbuntu),
                        hintStyle: TextStyle(fontSize: 18)),
=======
                    decoration: const InputDecoration(
                      hintText: 'Enter the city you are going to',
                      labelText: 'Arrival City',
                    ),
>>>>>>> 05850db544e4bdae5bbe0077eeb536b0195af870
                    validator: (input) =>
                        input.isEmpty ? "Please enter a city name" : null,
                    onSaved: (input) => _toCity = input,
                  ),
                ),
                //Show chosen date
                new Row(children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      alignment: Alignment.topLeft,
                      child: Text(
                          _dateTime == null
                              ? 'No date chosen'
                              : _dateTime.toString().split(' ')[0],
<<<<<<< HEAD
                          style: TextStyle(
                              fontSize: 16, fontFamily: FontNameUbuntu))),
=======
                          style: TextStyle(fontSize: 16.0))),
>>>>>>> 05850db544e4bdae5bbe0077eeb536b0195af870
                  //Date picker button
                  Container(
                      margin: EdgeInsets.only(right: 20),
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
                      )),
<<<<<<< HEAD
                  Text('Seats:',
                      style: TextStyle(
                          fontSize: 16.0, fontFamily: FontNameUbuntu)),
=======
                  Text('Seats:', style: TextStyle(fontSize: 16.0)),
>>>>>>> 05850db544e4bdae5bbe0077eeb536b0195af870
                  //Seats picker
                  Container(
                      margin: EdgeInsets.only(left: 10, right: 20),
                      child: DropdownButton<String>(
                        items: _numSeats.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(dropDownStringItem),
                          );
                        }).toList(),
                        onChanged: (String newValueSelected) {
                          _onDropDownItemSelected(newValueSelected);
                        },
                        value: _numSeatsSelected,
                      )),
                ]),
                Container(
                    alignment: Alignment.topLeft,
<<<<<<< HEAD
                    margin: EdgeInsets.all(10),
                    child: Text('Description',
                        style: TextStyle(
                            fontSize: 20, fontFamily: FontNameUbuntu))),
=======
                    margin: EdgeInsets.only(left: 10, top: 10),
                    child: Text('Description', style: TextStyle(fontSize: 16))),
>>>>>>> 05850db544e4bdae5bbe0077eeb536b0195af870
                Container(
                    margin: EdgeInsets.all(10),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      onChanged: (text) {
                        _description = text;
                      },
                    )),
                //Post button
                Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: new RaisedButton(
                      onPressed: _submit,
<<<<<<< HEAD
                      child: Text('Post',
                          style: TextStyle(
                              fontFamily: FontNameUbuntu, fontSize: 18)),
=======
                      child: Text('Post'),
>>>>>>> 05850db544e4bdae5bbe0077eeb536b0195af870
                      color: Colors.tealAccent[700],
                    )),
              ],
            ),
          ),
        ));
  }

//if validate, then save input in city variables, else print error message
  void _submit() {
    if (_dateTime == null) {
      print("error");
    }
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print(_fromCity);
      print(_toCity);
      print(_dateTime);
      print(_numSeatsSelected);
      print(_description);
    }
  }

//update shown value in list button with selected value
  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._numSeatsSelected = newValueSelected;
    });
  }
}
