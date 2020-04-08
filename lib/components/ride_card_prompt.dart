import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RideCartPrompt extends StatelessWidget {
  
  createDialog(BuildContext context) {
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
              Text('Gainesville, FL',style: TextStyle(height: 1)),
              Text('to', textAlign: TextAlign.center,style: TextStyle(height: 1.5)),
              Text('Miami, FL' , style: TextStyle(height: 1.5),),
              Row(children: <Widget>[
              Text('June 13th, 2020',style: TextStyle(height: 1.5)), Text('|',style: TextStyle(height: 1.5)), Text(' 3:00PM',style: TextStyle(height: 1.5))],),
              Row(children: <Widget>[
                Text('Seats Available: ',style: TextStyle(height: 1.5)),
                Text('3' ,style: TextStyle(height: 1.5))
              ],),
              Text(' ',style: TextStyle(height: 1.5)),
              Text('Description: This is where the driver can add a description regarding anything from luggage to pets' ,style: TextStyle(height: 1.5))
              
              
            ],
                
          ),
          actions: <Widget>[
            MaterialButton(
              child: Text('Join Ride ', textAlign: TextAlign.center,),
              color: Colors.tealAccent[700] ,
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              onPressed: () {
                 Navigator.of(context).pop();
                print('ride join clicked');}
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