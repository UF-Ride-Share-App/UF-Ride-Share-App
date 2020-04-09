import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ride_card_prompt.dart';
import 'package:uf_ride_share_app/models/ride.dart';
import 'package:intl/intl.dart';

class RideCard extends StatelessWidget {
  final Ride ride;

  RideCard({this.ride});

  Widget _buildLeft({Ride ride}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(ride == null ? "-----" : DateFormat.MMMd().format(ride.time),
            style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        Container(
          padding: EdgeInsets.all(5),
          width: 40.0,
          height: 40.0,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: AssetImage('assets/images/sampleProfile.jpeg'),
            ),
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(
              color: Colors.lightGreenAccent,
              width: 3,
            ),
          ),
        )
      ]);
  }

  Widget _buildMiddle({Ride ride}) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(ride == null ? "-----" : ride.startLocation,
              style: TextStyle(color: Colors.black)),
          Container(
              height: 16,
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

  Widget _buildRight({Ride ride}) {
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
      padding: EdgeInsets.all(15),
      color: Colors.tealAccent[700],
      child: FlatButton(
        onPressed: () {
          // print('pressed');
          RideCartPrompt().createDialog(context);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 60.0,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: _buildLeft(),
                  ),
                  Expanded(
                    flex: 5,
                    child: _buildMiddle(),
                  ),
                  Expanded(
                    flex: 3,
                    child: _buildRight(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
