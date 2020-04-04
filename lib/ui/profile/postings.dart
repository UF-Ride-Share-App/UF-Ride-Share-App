import 'package:flutter/material.dart';

class Postings extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    print('object');
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Container(
          color: Colors.blue,
          height: MediaQuery.of(context).size.height,
        ),
      ),
    );
  }

}