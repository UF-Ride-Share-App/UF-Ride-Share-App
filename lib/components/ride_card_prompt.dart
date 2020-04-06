import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RideCartPrompt extends StatelessWidget {
  
  createDialog(BuildContext context) {
    return showDialog(
      context: context, builder: (context) {
        return AlertDialog(
          title: Text('TEST'),
          content: Container(
            height: 20.0,
            width: 20.0,
            color: Colors.orange,
          ),
          actions: <Widget>[
            MaterialButton(
              child: Text('Close'),
              onPressed: () {print('close');}
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