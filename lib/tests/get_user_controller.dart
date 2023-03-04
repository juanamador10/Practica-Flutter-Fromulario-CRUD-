import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curso_flutter_formulario_amador/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetUserController extends GetxController {
  String id = '';

  handleId(String newId) {
    id = newId;
    update();
  }

  handleUser() async {
    try {
    getUserInDB(id) {
      final db = FirebaseFirestore.instance;
      final docRef = db.collection("Usuarios").doc(id);
      docRef.get().then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      //print("<<AAAAAAAAAAAAAA>> " + data["nombre"].toString());
      return data["nombre"].toString();
    // ...
    },
      onError: (e) => print("Error getting document: $e"),
    );
  }

    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.code,
          backgroundColor: Colors.blue[100],
          duration: const Duration(seconds: 5));
    } catch (e) {
      print(e);
    }
  }
 
}
