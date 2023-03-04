import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curso_flutter_formulario_amador/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteUserController extends GetxController {
  String id = '';

  handleId(String newId) {
    id = newId;
    update();
  }

  handleDeleteUser() async {
    try {
        deleteUserInDB(id);
        Get.offAll((context) => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()) ));
        Get.snackbar('Cuenta Eliminada', "El Usuario Ha Sido Eliminado",
          backgroundColor: Colors.blue[100],
          duration: const Duration(seconds: 5));

    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.code,
          backgroundColor: Colors.blue[100],
          duration: const Duration(seconds: 5));
    } catch (e) {
      print(e);
    }
  }

  deleteUserInDB(String id) {
    final db = FirebaseFirestore.instance;
    db
    .collection("Usuarios")
    .doc(id).delete()
    .onError((e, _) => print("Error writing document: $e"));

    
  }
}
