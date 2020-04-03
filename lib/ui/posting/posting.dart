import 'package:flutter/material.dart';

class Posting extends StatelessWidget {

  Posting();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(decoration: new BoxDecoration(color: Colors.red), height: 200.0,)
        ],
      ),
    );
  }
}