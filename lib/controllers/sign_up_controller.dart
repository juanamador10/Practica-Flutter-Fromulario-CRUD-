import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/usuario.dart';
import '../screens/home_screen.dart';


class SignUpController extends GetxController {
  String nombre = '';
  String apellidos = '';
  String fechaDeNacimiento = '';
  String genero = '';
  String telefono = '';
  String email = '';
  String password = '';
  

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

  handleSignUp() async {
    if (nombre == '' || apellidos == '' || fechaDeNacimiento == '' || telefono == '' || genero == '' || email == '' || password == '') {
      return;
    }
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        final user = saveUserInDB(credential.user!.uid);
        Get.offAll(() => HomeScreen(
             //nombre: user.nombre,
             id: credential.user!.uid
            ));
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.code,
          backgroundColor: Colors.blue[100],
          duration: const Duration(seconds: 5));
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Usuario saveUserInDB(
    String id,
  ) {
    final user = Usuario(
      nombre: nombre, 
      apellidos: apellidos,
      fechaDenacimiento: fechaDeNacimiento, 
      telefono: telefono,
      genero: genero, 
      email: email,
      password: password, 
      
      
      );
    final db = FirebaseFirestore.instance;
    db
        .collection("Usuarios")
        .doc(id)
        .set(user.toFirestore())
        .onError((e, _) => print("Error writing document: $e"));
        print("YEEEEES");

    return user;
  }
}
