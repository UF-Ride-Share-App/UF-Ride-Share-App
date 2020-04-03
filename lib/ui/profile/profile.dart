import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileMainHeader createState() => _ProfileMainHeader();
}

class _ProfileMainHeader extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.40,
                floating: false,
                pinned: true,
                backgroundColor: Colors.lightGreenAccent,
                flexibleSpace: FlexibleSpaceBar(title: Text('John Doe')),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarTabBar(
                  TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black,
                    tabs: [
                      Tab(icon: Icon(Icons.event), text: 'Test 1'),
                      Tab(icon: Icon(Icons.departure_board), text: 'Test 2'),
                      Tab(icon: Icon(Icons.history), text: 'Test 3'),
                    ]),
                ),
                pinned: true,
              ),
              SliverFillRemaining(),
            ];
          },
          body: Center(child: Text('data'),)
        )
      )
    );
  }
}

class _SliverAppBarTabBar extends SliverPersistentHeaderDelegate {
  _SliverAppBarTabBar(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: new Material(
        color: Colors.tealAccent[700],
        child: _tabBar,
      )
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarTabBar delegate) {
    return false;
  }
}
