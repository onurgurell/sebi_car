import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseService {
  List<DocumentSnapshot> documents = [];

  Future<void> saveUserData(
    TextEditingController nameController,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('userInfo');

      await users.add({
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
      });
    } catch (e) {
      print("Service Error ${e.toString()}");
    }
  }
}
