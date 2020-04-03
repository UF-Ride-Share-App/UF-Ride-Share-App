import 'package:flutter/material.dart';
import 'package:uf_ride_share_app/utils/firebase_auth.dart';
// class Landing extends StatelessWidget {
  
//   Landing();

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }


class Landing extends StatelessWidget {
  
  Landing();
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Home page"),
            RaisedButton(
              child: Text("Log out"),
              onPressed: (){
                AuthProvider().logOut();
              },
            )
          ],
        ),
      ),
    );
  }
}