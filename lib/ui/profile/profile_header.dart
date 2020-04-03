import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            color: Colors.tealAccent[700],
            width: 5,
          )
        ),
      ),
    );
  }
}