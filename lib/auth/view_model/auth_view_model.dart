import 'package:amazon_clone/profile/view/profile_screen.dart';
import 'package:amazon_clone/screens/bottomnav.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../utils/snackbar.dart';
import '../services/firebase_auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseAuthService _authService = FirebaseAuthService();
  User? _user;
  bool _isLoading = false;

  User? get user => _user;

  bool get isLoading => _isLoading;

  Future<void> signUp(
      String email, String password, BuildContext context) async {
    _setLoading(true);
    try {
      print('try block entered');
      _user = await _authService.signUp(email, password, context);
      print('user is $_user');
      _setLoading(false);
      if (_user != null) {
        debugPrint('user created : ${_user?.email}');
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showSnackBar(context, 'Account created successfully!');
        });
      } else {
        debugPrint('user is null');
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showSnackBar(context, 'Something went wrong. Try again.');
        });
      }
    } catch (e) {
      debugPrint('Exception: $e');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showSnackBar(context, e.toString());
      });
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    _setLoading(true);
    try {
      _user = await _authService.signIn(email, password, context);
      if (_user != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const BottomNavScreen()),
          );
        });
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut(BuildContext context) async {
    _setLoading(true);
    try {
      await _authService.signOut(context);
      _user = null;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context, rootNavigator: true)
            .pushReplacementNamed('/welcome');
      });
    } catch (e) {
      showSnackBar(context, 'Error signing out');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    _setLoading(true);
    try {

      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        showSnackBar(context, 'Google Sign-In cancelled.');
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential result =
      await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = result.user;

      if (user == null) {
        showSnackBar(context, 'Something went wrong. Try again.');
        return;
      }


      final userRef =
      FirebaseDatabase.instance.ref().child('users').child(user.uid);
      final snapshot = await userRef.get();

      if (snapshot.exists) {

        Navigator.pushReplacementNamed(context, '/bottom-nav');
        showSnackBar(context, 'Welcome back!');
      } else {

        await FirebaseAuth.instance.signOut();
        showSnackBar(context, 'No account found. Please create an account first.');
      }
    } catch (e) {
      showSnackBar(context, 'Error: ${e.toString()}');
    } finally {
      _setLoading(false);
    }

  }


  void _setLoading(bool value) {
    _isLoading = value;
    debugPrint('isLoading set to $value');
    notifyListeners();
  }
}
