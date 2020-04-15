import 'package:flutter/material.dart';
import 'package:uf_ride_share_app/ui/profile/driveHistory.dart';
import 'package:uf_ride_share_app/ui/profile/history.dart';
import 'package:uf_ride_share_app/ui/profile/postings.dart';
import 'package:uf_ride_share_app/ui/profile/upcoming.dart';
import 'package:uf_ride_share_app/utils/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_header.dart';
import '../../styles/style.dart';

class Profile extends StatefulWidget {
  final _auth = new AuthProvider();

  @override
  _ProfileMainHeader createState() => _ProfileMainHeader();
}

class _ProfileMainHeader extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
            length: 4,
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: MediaQuery.of(context).size.height * 0.40,
                    floating: false,
                    pinned: true,
                    backgroundColor: Colors.lightGreenAccent,
                    flexibleSpace: FutureBuilder(
                      future: this.widget._auth.getCurrentFirebaseUser(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return FlexibleSpaceBar(
                            background: Center(
                              child: Container(
                                width: 60.0,
                                height: 60.0,
                                decoration: new BoxDecoration(
                                  image: new DecorationImage (
                                    image: NetworkImage(snapshot.data.photoUrl),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(
                                    color: Colors.teal[300],
                                    width: 5,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            centerTitle: true,
                            title: Text(snapshot.data.displayName,
                                style: FlexibleSpaceBarTextStyle));
                      },
                    ),
                    actions: <Widget>[
                      PopupMenuButton(
                        onSelected: settingsButtonAction,
                        icon: Icon(Icons.settings),
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'Logout',
                            child: ListTile(
                              leading: Icon(Icons.exit_to_app),
                              title: Text('Logout'),
                            ),
                          ),
                        ],
                      ),
                    ],
                    actionsIconTheme:
                        IconThemeData(size: 30.0, color: Colors.teal[700]),
                  ),
                  SliverPersistentHeader(
                    delegate: _SliverAppBarTabBar(
                      TabBar(
                          // onTap: onTabTapped,
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.black,
                          indicatorColor: Colors.lightGreenAccent,
                          isScrollable: true,
                          tabs: [
                            Tab(text: 'My Posts'),
                            Tab(text: 'Future Trips'),
                            Tab(text: 'Past Rides'),
                            Tab(text: 'Past Drives'),
                          ]),
                    ),
                    pinned: true,
                  ),
                  // SliverFillRemaining(),
                ];
              },
              body: TabBarView(children: [
                Postings(),
                Upcoming(),
                History(),
                DriveHistory(),
              ]),
            )));
  }

  // void onTabTapped(int index) {
  //   _currentIndex = index;
  // }

  void settingsButtonAction(String choice) {
    if (choice == 'Logout') {
      AuthProvider().logOut();
    }
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
      color: Colors.teal[300],
      child: _tabBar,
    ));
  }

  @override
  bool shouldRebuild(_SliverAppBarTabBar oldDelegate) {
    return false;
  }
}
