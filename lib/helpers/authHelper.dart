import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mbaadmin/MbaUser.dart';
import 'package:mbaadmin/elements/uiHelpers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import '../elements/progressDialog.dart';
import '../globalVariables.dart';
import '../pages/homepage.dart';
import '../providers/authProvider.dart';
class AuthHelper{
  Future<void> loginUser(BuildContext context, String email, String password) async {

    var _auth = FirebaseAuth.instance;

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const ProgressDialog(status: 'Giriş edilir...',)
    );

    try{

      final User? user = (await _auth.signInWithEmailAndPassword(email: email, password: password)).user;

      Navigator.pop(context);

      if(user != null){

        /// must check for this user already registered
        Provider.of<MbaAuthProvider>(context, listen: false).login();
        Navigator.pushNamedAndRemoveUntil(context, HomePage.id, (route) => false);
      }
    }on FirebaseAuthException catch(e){
      Navigator.pop(context);
      print('Failed with error code: ${e.code}');
      UiHelpers.showSnackBar(context, e.message.toString());
    }
  }

  static Future<MbaUser?> loadLoggedUserData(String id) async {
    DatabaseReference userRef = FirebaseDatabase.instance.ref('stuff/$id');
    try {
      DataSnapshot snapshot = await userRef.once().then((event) => event.snapshot);
      if (snapshot.exists) {
        return MbaUser.fromSnapshot(snapshot);
      } else {
        print('No user data');
        return null;
      }
    } catch (error) {
      print('Error : $error');
      return null;
    }
  }
}