import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ride_card_prompt.dart';

class RideCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: Colors.white,
      ),
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: CupertinoButton(
            color: Colors.tealAccent[700],
            onPressed: () {
              // print('pressed'); 
              RideCartPrompt().createDialog(context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 40.0,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 30.0,
                        height: 30.0,
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: AssetImage('assets/images/sampleProfile.jpeg'),
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(
                            color: Colors.lightGreenAccent,
                            width: 3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}