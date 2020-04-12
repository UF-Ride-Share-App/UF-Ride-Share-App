import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ride_card_prompt.dart';
import 'package:uf_ride_share_app/models/ride.dart';
import 'package:intl/intl.dart';

class RideCard extends StatelessWidget {
  final Ride ride;

  RideCard({this.ride});

  Widget _buildLeft(Ride ride) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(ride == null ? "-----" : DateFormat.MMMd().format(ride.time),
            style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
        Text(ride == null ? "--:--" : DateFormat.jm().format(ride.time),
          style:
              TextStyle(color: Colors.black)),
      ]);
  }

  Widget _buildMiddle(Ride ride) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(ride == null ? "-----" : ride.startLocation,
              style: TextStyle(color: Colors.black)),
          Container(
              height: 16.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                      child: Divider(
                    color: Colors.black.withOpacity(.7),
                  )),
                  Text("  to  ",
                      style: TextStyle(color: Colors.black.withOpacity(.7))),
                  Expanded(child: Divider(color: Colors.black.withOpacity(.7))),
                ],
              )),
          Text(ride == null ? "-----" : ride.endLocation,
              style: TextStyle(color: Colors.black))
        ]);
  }

  Widget _buildRight(Ride ride) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(ride == null ? "-" : ride.getAvailableSeats().toString(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 28,
            )),
        Text("seats", style: TextStyle(color: Colors.black))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: FlatButton(
         color: Colors.teal[300],
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(15.0),
          side: BorderSide(color: Colors.lightGreenAccent)
        ),
        onPressed: () {
          // print('pressed');
          RideCartPrompt(ride: ride).createDialog(context);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 75.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: _buildLeft(ride),
              ),
              Expanded(
                flex: 5,
                child: _buildMiddle(ride),
              ),
              Expanded(
                flex: 3,
                child: _buildRight(ride),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
