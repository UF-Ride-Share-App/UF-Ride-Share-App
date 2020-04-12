import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: <Widget>[
    //     Center(
    //       child: Container(
    //         width: 150.0,
    //         height: 150.0,
    //         decoration: new BoxDecoration(
    //           image: new DecorationImage(
    //             image: new AssetImage('assets/images/sampleProfile.jpeg'),
    //           ),
    //           borderRadius: BorderRadius.circular(150.0),
    //           border: Border.all(
    //             color: Colors.tealAccent[700],
    //             width: 5,
    //           )
    //         ),
    //       ),
    //     ),
    //     Center(
    //       child: Text('John Doe'),
    //     ),
    //     Center(
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: <Widget>[
    //           Icon(Icons.drive_eta),
    //           Icon(Icons.star),
    //           Text('5.0'),
    //         ],
    //       ),
    //     ),
    //     Center(
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: <Widget>[
    //           Icon(Icons.event_seat),
    //           Icon(Icons.star),
    //           Text('4.9'),
    //         ],
    //       ),
    //     )
    //   ],
    // );
    
    return Center(
      child: Container(
        width: 150.0,
        height: 150.0,
        decoration: new BoxDecoration(
          image: new DecorationImage (
            image: new AssetImage('assets/images/sampleProfile.jpeg'),
          ),
          borderRadius: BorderRadius.circular(150.0),
          border: Border.all(
            color: Colors.teal[300],
            width: 5,
          )
        ),
      ),
    );
  }
}