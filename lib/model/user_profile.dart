

import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String name;
  final String email;
  final String uid;

  //constructor
  const UserProfile(
      {required this.email, required this.uid, required this.name});

  factory UserProfile.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot){
    final data = snapshot.data()!;
    return UserProfile(email: data['email'], uid: data['uid'], name: data['name']);
  }

  toJson(){
    return {
      'name':name,
      'email':email,
      'uid':uid
    };
  }
}
