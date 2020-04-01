import 'package:flutter/material.dart';
import 'placeholder_widget.dart' as first;

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0; //track index of currently selected tab
  final List<Widget> _children = [
    first.PlaceholderWidget(),
    first.PlaceholderWidget(),
    first.PlaceholderWidget(),
  ]; //list of widgets we want to render based on selected tab
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Flutter App'),
      ),
      body: _children[
          _currentIndex], // show widget (b/t app bar and bot nav) from list based on index
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // function to be called when click a tab
        currentIndex:
            _currentIndex, // save currentIndex property of bot nav as _currentIndex from state's property
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.account_circle),
            title: new Text('Account'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle), title: Text('Post'))
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
