import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mbaadmin/elements/uiHelpers.dart';
import 'package:firebase_database/firebase_database.dart';
import '../elements/progressDialog.dart';
import '../globalVariables.dart';
class AuthHelper {

  void loginUser(BuildContext context, String email, String password) async {

    var _auth = FirebaseAuth.instance;

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const ProgressDialog(status: 'PIN Yoxlanır.',)
    );

    try{
      final User? user = (await _auth.signInWithEmailAndPassword(email: email, password: password)).user;
      Navigator.pop(context);
      if(user != null){
        /// must check for this user already registered
        DatabaseReference newUserRef = FirebaseDatabase.instance.ref('users/${user.uid}');
        currentFirebaseUser = user;

        print('AFTER LOGIN: ${currentFirebaseUser?.uid}');

      }
    }on FirebaseAuthException catch(e){
      Navigator.pop(context);
      print('Failed with error code: ${e.code}');
      UiHelpers.showSnackBar(context, e.message.toString());
    }finally{
      //Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false);
    }
  }


}