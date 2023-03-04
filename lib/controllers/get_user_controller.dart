import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/usuario.dart';
import '../screens/home_screen.dart';


class GetUserController extends GetxController {

  
  String id = '';
  String nombre = '';
  String apellidos = '';
  String fechaDeNacimiento = '';
  String genero = '';
  String telefono = '';
  String email = '';
  String password = '';
  
  handleId(String newId) {
    id = newId;
    update();
  }

  handleName(String newName) {
    nombre = newName;
    update();
  }

  handleApellidos(String newApellidos) {
    apellidos = newApellidos;
    update();
  }

  handleFechaDeNacimiento(String handleFechaDeNacimiento) {
    fechaDeNacimiento = handleFechaDeNacimiento;
    update();
  }

  handleGenero(String newGenero) {
    genero = newGenero;
    update();
  }

  handleTelefono(String newTelefono) {
    telefono = newTelefono;
    update();
  }

  handleEmail(String handleEmail) {
    email = handleEmail;
    update();
  }

  handlePassword(String newPassword) {
    password = newPassword;
    update();
  }

  handleUser() async {
    try {
        await saveUserInDB(id);

    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.code,
          backgroundColor: Colors.blue[100],
          duration: const Duration(seconds: 5));
    } catch (e) {
      print(e);
    }
  }

  saveUserInDB(String id) {
    final db = FirebaseFirestore.instance;
    final docRef = db.collection("Usuarios").doc(id);
    docRef.get().then((DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
      print("PALABRAS " + data.toString());
    return data;

    // ...
  },
  onError: (e) => print("Error getting document: $e"),
);
    
  }
}
