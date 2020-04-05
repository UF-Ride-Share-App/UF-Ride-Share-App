import 'package:flutter/material.dart';

class Upcoming extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    print('object');
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
        ),
      ),
    );
  }
}