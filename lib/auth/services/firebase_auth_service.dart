import 'package:amazon_clone/auth/models/user_model.dart';
import 'package:amazon_clone/utils/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _db = FirebaseDatabase.instance;

  Future<User?> signUp(
      String email, String password, BuildContext context) async {
    print('FirebaseAuthService.signUp called');
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print('User created: ${result.user?.email}');
      await _saveUserToDB(result.user, context);
      return result.user;
    } catch (e) {
      print('FirebaseAuthService error: $e');
      return null;
    }
  }
  Future<User?> signIn(String email, String password, BuildContext context) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print('User signed in: ${result.user?.email}');
      return result.user;
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message ?? 'Login failed');
      return null;
    } catch (e) {
      print('Error during sign in: $e');
      showSnackBar(context, 'Something went wrong');
      return null;
    }
  }
  Future<User?> googleSignIn(BuildContext context) async {
    try {
      // 🧹 Sign out Google & Firebase first to force account chooser
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        showSnackBar(context, 'Google sign-in cancelled');
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential result = await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = result.user;

      if (user == null) {
        showSnackBar(context, 'Something went wrong. Try again.');
        return null;
      }

      // 🔍 Check in Firebase Realtime Database
      final userRef = FirebaseDatabase.instance.ref().child('users').child(user.uid);
      final snapshot = await userRef.get();

      if (snapshot.exists) {
        showSnackBar(context, 'User already exists. Please log in.');
      } else {
        await userRef.set({
          'uid': user.uid,
          'email': user.email,
          'name': user.displayName ?? '',
          'profilePic': user.photoURL ?? '',
        });

        showSnackBar(context, 'Account created successfully!');
        Navigator.pushReplacementNamed(context, '/bottom-nav');
      }
    } catch (e) {
      debugPrint('Google Sign-In Error: $e');
      showSnackBar(context, 'Error during Google sign-in. Try again.');
    }

  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      showSnackBar(context, 'Signed out successfully');
    } catch (e) {
      print('Error signing out: $e');
      showSnackBar(context, 'Failed to sign out');
    }
  }

  Future<void> _saveUserToDB(User? user, BuildContext context) async {
    print('Saving user to DB: ${user?.uid}');
    try {
      if (user != null) {
        final ref = _db.ref().child('users/${user.uid}');
        await ref.set(Users(uid: user.uid, email: user.email ?? '').toJson());
        print('User saved to DB');
      }
    } catch (e) {
      showSnackBar(context, 'failed to save user');
      print('Error saving user to DB: $e');
    }
  }
}
