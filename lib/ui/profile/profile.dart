import 'package:flutter/material.dart';
import 'profile_header.dart';

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
                flexibleSpace: FlexibleSpaceBar(
                  background: ProfileHeader(),
                  centerTitle: true,
                  title: Text('John Doe')
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.settings), 
                    onPressed: () {},
                  ),
                ],
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarTabBar(
                  TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black,
                    indicatorColor: Colors.lightGreenAccent,
                    tabs: [
                      Tab(text: 'Postings'),
                      Tab(text: 'Upcoming Trips'),
                      Tab(text: 'Ride History'),
                    ]),
                ),
                pinned: true,
              ),
              SliverFillRemaining(),
            ];
          },
          body: Center(child: Text('data'))
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
