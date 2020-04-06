import 'package:flutter/material.dart';
import '../../components/ride_card.dart';

class History extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    print('object');
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: RideCard(),
      ),
    );
  }

}