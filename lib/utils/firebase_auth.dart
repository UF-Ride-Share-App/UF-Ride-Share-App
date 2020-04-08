import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uf_ride_share_app/models/user.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> getCurrentFirebaseUser() async {
    FirebaseUser user = await _auth.currentUser();
    return user;
  }

  Future<String> storeUserLocal(FirebaseUser fbuser) async {
    User user =
        User(fbuser.uid, fbuser.displayName, fbuser.photoUrl, fbuser.email);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storeUser = userToJson(user);
    await prefs.setString('user', storeUser);
    return user.id;
  }

  Future<bool> loginWithEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      if (user != null)
        return true;
      else
        return false;
    } catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<bool> loginWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
      if (account == null) return false;
      AuthResult res =
          await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: (await account.authentication).idToken,
        accessToken: (await account.authentication).accessToken,
      ));
      if (res.user == null) return false;
      return true;
    } catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<bool> loginWithFacebook() async {
    try {
      FacebookLogin facebookLogin = FacebookLogin();
      FacebookLoginResult facebookLoginResult =
          await facebookLogin.logInWithReadPermissions(['email']);
      if (facebookLoginResult.status == FacebookLoginStatus.cancelledByUser) {
        print('Login cancelled');
        return false;
      } else if (facebookLoginResult.status == FacebookLoginStatus.error) {
        print('Error logging in with Facebook');
        return false;
      } else if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
        print('Logged in with Facebook');
        final facebookAuthCred = FacebookAuthProvider.getCredential(
            accessToken: facebookLoginResult.accessToken.token);
        AuthResult res = await _auth.signInWithCredential(facebookAuthCred);
        if (res.user == null) return false;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("error logging out");
    }
  }
}
