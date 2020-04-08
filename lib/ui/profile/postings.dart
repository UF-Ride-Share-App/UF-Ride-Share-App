import 'package:flutter/material.dart';
import '../../components/ride_card.dart';

class Postings extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    print('object');
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: RideCard(),
      ),
    );
  }

}