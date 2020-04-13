import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uf_ride_share_app/models/ride.dart';
import 'package:uf_ride_share_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class RideCartPrompt extends StatelessWidget {

  final Ride ride;
  final databaseReference = Firestore.instance;
  var _numSeatsSelected = '0';
  var seatCount = 0;
  List<String> pastPassengers;

  RideCartPrompt({this.ride});

  actionToTake(int action) {
    if (action == 2) { // User wants to join ride
    int rideCount = ride.getAvailableSeats();
    
    print(ride.passengers);
    //print(currentUser);S
    print('Ride count is '+ rideCount.toString());
      if(ride.getAvailableSeats() > 0){
        // seatCount = rideCount - 1;
        // print(seatCount);     
        _addRider();
      } else{
        print('Cannot add seats');
      }
    }
    else if (action == 1) { // User wants to leave a ride
      _removeRider();
    }
    else { // User wants to edit a ride

    }
  }
  
  createDialog(BuildContext context) async {
    int actionType;
    String buttonLabel;

    actionType = -1;
    buttonLabel = "Error";

    String currentUser;
    currentUser = await getCurrentUser();

    if(ride != null) {
      if(ride.driver == currentUser) { // If ride is the user's posting
        actionType = 0;
        buttonLabel = "Edit Ride";
      }
      else if(ride.passengers.indexWhere((passenger) => passenger == currentUser) != -1) { // User is a passenger of the posting
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
                    ride == null ? "-----" : ride.getAvailableSeats().toString(),
                    style: TextStyle(height: 1.5))
                ],
              ),
              //Text(' ',style: TextStyle(height: 1.5)),
              Divider(color: Colors.black,),
              Text(
                ride == null ? "-----" : ride.description, 
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
    
  void _addRider() async {  
    String currentUser;
    pastPassengers = ride.passengers;
    currentUser = await getCurrentUser();
    pastPassengers.add(currentUser);

    print('current user is' + currentUser);
    print(pastPassengers);
    
    await databaseReference.collection("Rides").document(ride.id).updateData({
      //'seats': seatCount,
      'passengers': pastPassengers,
    });
  }
  
  void _removeRider() async { 
    String currentUser;
    pastPassengers = ride.passengers;
    currentUser = await getCurrentUser();
    pastPassengers.remove(currentUser);

    print('current user is' + currentUser);
    print(pastPassengers);
    
    await databaseReference.collection("Rides").document(ride.id).updateData({
      //'seats': seatCount,
      'passengers': pastPassengers,
    });
  }
}