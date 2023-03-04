import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/usuario.dart';
import '../screens/home_screen.dart';


class UpdateUserController extends GetxController {

  
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

  handleUpdateUser() async {
    if (nombre == '' || apellidos == '' || fechaDeNacimiento == '' || telefono == '' || genero == '' || email == '' || password == '') {
      return Get.snackbar('Error', "Hay Campos Vacios",
          backgroundColor: Colors.blue[100],
          duration: const Duration(seconds: 5));
    }
    try {
        saveUserInDB(id);
        Get.snackbar('Actualizado', "Tus datos se han actualizado correctamente",
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

  saveUserInDB(String id) {
    final userUpdate = {
      "nombre": nombre, 
      "apellidos": apellidos,
      "fechaDenacimiento": fechaDeNacimiento, 
      "telefono": telefono,
      "genero": genero, 
      "email": email,
      "password": password, 
      
      
    };
    final db = FirebaseFirestore.instance;
    db
    .collection("Usuarios")
    .doc(id)
    .set(userUpdate)
    .onError((e, _) => print("Error writing document: $e"));

    
  }
}
