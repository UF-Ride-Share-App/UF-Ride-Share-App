import 'package:flutter/material.dart';
import 'package:uf_ride_share_app/utils/firebase_auth.dart';
import '../styles/style.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() { 
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment:  CrossAxisAlignment.center,         
            children: <Widget>[
              Text("Ridinn' Dirty", textAlign: TextAlign.center, style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40.0,
              ),),
              const SizedBox(height: 20.0),

              Image.asset('assets/images/car.png'),
                            const SizedBox(height: 20.0),

            
              Text("Login", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0
              ),),const SizedBox(height: 20.0),
              
              const SizedBox(height: 20.0),
              RaisedButton(
                child: Text("Loginn with Google"),
                onPressed: () async {
                  bool res = await AuthProvider().loginWithGoogle();
                  if(!res)
                    print("error logging in with Google");
                },
              ),
              const SizedBox(height: 20.0),
              RaisedButton(
                child: Text("Login with Fcebook"),
                onPressed: () async {
                  bool res = await AuthProvider().loginWithFacebook();
                  if(!res)
                    print("error logging in with Facebook");
                },
              
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Email"
                ),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password"
                ),
              ),
              const SizedBox(height: 10.0),
              RaisedButton(
                child: Text("Login"),
                onPressed: ()async {
                  if(_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                    print("Email and password cannot be empty");
                    return;
                  }
                  bool res = await AuthProvider().loginWithEmail(_emailController.text, _passwordController.text);
                  if(!res) {
                    print("Login failed");
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}