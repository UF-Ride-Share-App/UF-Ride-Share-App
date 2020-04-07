import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RideCartPrompt extends StatelessWidget {
  
  createDialog(BuildContext context) {
    return showDialog(
      context: context, builder: (context) {
        return AlertDialog(
          title: Text('Ride Details', textAlign: TextAlign.center,),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          elevation: 120,
          child: Container(
            height: 20.0,
            width: 20.0,
            color: Colors.orange,          
          ),
          actions: <Widget>[
            MaterialButton(
              child: Text('Join Ride ', textAlign: TextAlign.left,),
              onPressed: () {print('ride join clicked');}
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