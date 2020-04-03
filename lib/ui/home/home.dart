import 'package:flutter/material.dart';
//import 'package:uf_ride_share_app/utils/firebase_auth.dart';
import '../landing/landing.dart';
import '../posting/posting.dart';
import '../profile/profile.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 1; //track index of currently selected tab
  
  final List<Widget> _children = [
    Profile(),
    Landing(),
    Posting(),
  ]; //list of widgets we want to render based on selected tab
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex], // show widget (b/t app bar and bot nav) from list based on index
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // function to be called when click a tab
        currentIndex: _currentIndex, // save currentIndex property of bot nav as _currentIndex from state's property
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.lightGreenAccent,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.account_circle, color: Colors.tealAccent[700]),
            title: new Text('Account'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.home, color: Colors.tealAccent[700]),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle, color: Colors.tealAccent[700]), 
              title: Text('Post')),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}