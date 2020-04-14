import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uf_ride_share_app/models/ride.dart';
import 'package:uf_ride_share_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class RideCartPrompt extends StatelessWidget {

  final Ride ride;
  var rating; 
  final databaseReference = Firestore.instance;
  var _numSeatsSelected = '0';
  var seatCount = 0;
  List<String> pastPassengers;

  RideCartPrompt({this.ride});

  actionToTake(int action,) {
    if (action == 3) { // User wants to join ride
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
    }else if (action == 2) {
      print(rating);
      _addRating(); // User wants to rate a ride
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
           DateTime dateTime = new DateTime.now();

      if(ride.driver == currentUser && (ride.time.compareTo(dateTime) != -1 )) { // If ride is the user's posting
      print("ride.time is " + ride.time.toString());
      print("curr time is " + dateTime.toString());
        actionType = 0;
        buttonLabel = "Edit Ride";
      }
      else if((ride.passengers.indexWhere((passenger) => passenger == currentUser) != -1 ) && (ride.time.compareTo(dateTime) != -1 )) { // User is a passenger of the posting
        actionType = 1;
        buttonLabel = "Leave";
      }
       else if((ride.passengers.indexWhere((passenger) => passenger == currentUser) != -1) && (ride.time.compareTo(dateTime) != 1 )) { // User is a passenger of the posting
        actionType = 2;
        buttonLabel = "Rate Ride";
      }
      else { // Posting is from another driver & user hasn't requested this ride
        actionType = 3;
        buttonLabel = "Join Ride";

      }
    }

    return showDialog(
      context: context, builder: (context) {
        if(actionType == 2){
          print("action type is "+ actionType.toString());
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
              ),Text(
                ride == null ? "-----" : 'ride.description', 
                style: TextStyle(height: 1.5), 
                textAlign: TextAlign.justify
              ),
             TextField(
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: 'Rating', hintText: 'Please rate from 1 -5'),
              onChanged: (value) {
                _storeVal(value);
              },
            )            ],       
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
      else {
        
          print("action type is "+ actionType.toString());
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
      
      });
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
    void _addRating() async { 
    String currentUser;
    print("outside of loop");
    if(ride.rating != null){
          double tempRating = double.parse(ride.rating);

      print('inside if');
    currentUser = await getCurrentUser();
    tempRating = (tempRating + double.parse(rating))/2;
    print('current user is' + currentUser);
    print(tempRating);
    
    await databaseReference.collection("Rides").document(ride.id).updateData({
      //'seats': seatCount,
      'rating': tempRating.toString(),
    });
    } else { 
      print("inside else loop. Rating is " + rating);
    await databaseReference.collection("Rides").document(ride.id).updateData({
          'rating': rating.toString(),
      });
      print(ride.rating);
    } 
    }
  
  void _storeVal(String val){
      rating = val;
      print(rating);

  }
}