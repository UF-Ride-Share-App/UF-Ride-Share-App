import 'package:flutter/material.dart';

class Landing extends StatelessWidget {
  
  Landing();
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        title: Text("Share & Ride"),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(Icons.filter_list),
            ),
          ),
        ],
        actionsIconTheme: IconThemeData(
          color: Colors.tealAccent[700],
          size: 30.0,
        ),
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: <Widget>[
      //       Text("Home page"),
      //       RaisedButton(
      //         child: Text("Log out"),
      //         onPressed: (){
      //           AuthProvider().logOut();
      //         },
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}