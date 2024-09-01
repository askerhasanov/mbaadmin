import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MbaUser {
  String id;
  String email;
  String imageUrl;
  String exp;
  String bio;
  List<dynamic> lang;
  String moto;
  String name;
  String rating;
  String type;
  bool isAddingNewLanguage = false;
  final TextEditingController newLanguageController = TextEditingController();

  MbaUser ({
    required this.id,
    required this.email,
    required this.imageUrl,
    required this.exp,
    required this.lang,
    required this.moto,
    required this.name,
    required this.rating,
    required this.type,
    required this.bio
  });

  factory MbaUser.fromSnapshot(DataSnapshot snapshot) {
    final data = snapshot.value as Map;
    final List<dynamic> languages = [];
    if (data['lang'] != null) {
      for (var e in (data['lang'] as List)) {
        languages.add(e);
      }
    }

    return MbaUser(
      id: snapshot.key!,
      email: data['email'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      exp: data['exp'] ?? '',
      lang: languages,
      moto: data['moto'] ?? '',
      name: data['name'] ?? '',
      rating: data['rating'].toString(),
      type: data['type'] ?? '',
      bio: data['bio'] ?? '',
    );
  }

}
