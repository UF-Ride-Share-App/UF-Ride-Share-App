import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uf_ride_share_app/models/ride.dart';

class RideCartPrompt extends StatelessWidget {

  final Ride ride;

  RideCartPrompt({this.ride});

  actionToTake(int action) {
    if (action == 2) { // User wants to join ride

    }
    else if (action == 1) { // User wants to leave a ride

    }
    else { // User wants to edit a ride

    }
  }
  
  createDialog(BuildContext context) {
    int actionType;
    String buttonLabel;

    actionType = -1;
    buttonLabel = "Error";

    if(ride != null) {
      if(ride.driver == "") { // If ride is the user's posting
        actionType = 0;
        buttonLabel = "Edit Ride";
      }
      else if(ride.passengers.indexWhere((passenger) => passenger == "") != -1) { // User is a passenger of the posting
        actionType = 1;
        buttonLabel = "Leave";
      }
      else { // Posting is from another driver & user hasn't requested this ride
        actionType = 2;
        buttonLabel = "Join Ride";
      }
    }

    return showDialog(
      context: context, builder: (context) {
        return AlertDialog(
          title: Text('Ride Details', textAlign: TextAlign.center,),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text(
                  ride == null ? "-----" : ride.startLocation, 
                  style: TextStyle(color: Colors.black, height: 1.0)
              )),
              Center(
                child: Text('to', textAlign: TextAlign.center,style: TextStyle(height: 1.5))
              ),
              Center(
                child: Text(
                  ride == null ? "-----" : ride.endLocation, 
                  style: TextStyle(color: Colors.black, height: 1.5)
              )),
              Center(
                child: Text(
                  ride == null ? "-----" : DateFormat.yMMMd().format(ride.time),
                  style: TextStyle(height: 1.5)
                )
              ),
              Center(
                child: Text(
                  ride == null ? "-----" : DateFormat.jm().format(ride.time),
                  style: TextStyle(height: 1.5)
                )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.people),
                  Text(" "),
                  // Text('Seats Available: ', style: TextStyle(height: 1.5)),
                  Text(
                    ride == null ? "-----" : ride.seats.toString(),
                    style: TextStyle(height: 1.5))
                ],
              ),
              //Text(' ',style: TextStyle(height: 1.5)),
              Divider(color: Colors.black,),
              Text(
                'This is where the driver can add a description regarding anything from luggage to pets' , 
                style: TextStyle(height: 1.5), 
                textAlign: TextAlign.justify
              )
            ],       
          ),
          actions: <Widget>[
            MaterialButton(
              child: Text(buttonLabel, textAlign: TextAlign.center,),
              color: Colors.teal[700] ,
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              onPressed: () {
                actionToTake(actionType);
                Navigator.of(context).pop();
              }
            ),
          ],
        );
      }
    );
  }
  
  @override
  Widget build(BuildContext context){
    return createDialog(context);
  }
}