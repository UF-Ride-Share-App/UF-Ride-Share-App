import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uf_ride_share_app/ui/home/home.dart';
import 'package:uf_ride_share_app/ui/login.dart';
import 'package:uf_ride_share_app/ui/splash.dart';
import 'styles/style.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RideShare',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.teal[800],
        accentColor: Colors.tealAccent[400],
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(title: AppBarTextStyle),
        ),
        tabBarTheme: TabBarTheme(
          labelStyle: TabBarLabelStyle,
        ),
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return SplashPage();

        if (!snapshot.hasData || snapshot.data == null) return LoginPage();

        return Home();
      },
    );
  }
}
