import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../elements/progressDialog.dart';

class AddHelper{

  Future<String> addNews(BuildContext context, String title, String imageUrl, String text) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('posts');
    Map<String, String> newsMap = {
      'title' : title,
      'imageUrl' : imageUrl,
      'text' : text,
      'dateAdded' : DateTime.now().toString(),
      'type': 'news'
    };
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const ProgressDialog(status: 'Xəbər əlavə edilir...',)
    );
    try {
      await ref.push().set(newsMap);
      return 'added';
    } catch (e) {
      print('Error adding news: $e');
      return 'error';
    } finally {
      Navigator.pop(context);
    }
  }


  Future<String> addMoto(BuildContext context,
      String image1, String image2, String image3,
      String maker, String model, String engine,
      String year, String trip, String price, String about) async {

    DatabaseReference ref = FirebaseDatabase.instance.ref('/motors');

    Map<String, dynamic> motoMap = {
      'images' : [image1, image2, image3],
      'maker' : maker,
      'model' : model,
      'engine' : engine,
      'year' : year,
      'trip' : trip,
      'price' : price,
      'about' : about,
      'dateAdded' : DateTime.now().toString(),
    };
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const ProgressDialog(status: 'Moto əlavə edilir...',)
    );
    try {
      await ref.push().set(motoMap);
      return 'added';
    } catch (e) {
      print('Error adding moto: $e');
      return 'error';
    } finally {
      Navigator.pop(context);
    }
  }


  Future<String> addTutor(BuildContext context, String email, String password, String fullName, String type) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const ProgressDialog(status: 'Müəllim əlavə edilir...',)
    );

    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      if(user != null){
        DatabaseReference ref = FirebaseDatabase.instance.ref('stuff/${user.uid}');
        Map <String, String> userMap = {
          'email': email,
          'name' : fullName,
          'type' : type,
        };
        ref.set(userMap);

      await auth.signOut();

      final masterUser = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: 'mirfariz@mba.az', password: 'MirKtm1290')).user;
      return 'success';
      }else{
        return 'nullUser';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }else{
        return e.message.toString();
      }
    } catch (e) {
      print(e);
      return e.toString();
    }finally{
      Navigator.pop(context);
    }
  }

}