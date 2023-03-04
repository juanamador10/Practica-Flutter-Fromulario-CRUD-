import 'package:curso_flutter_formulario_amador/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  String email = '';
  String password = '';

  handleEmail(String newEmail){
    email = newEmail;
    update();
  }

  handlePassword(String newPassword){
    password = newPassword;
    update();
  }

  handleLogin() async {
    if(email == '' || password == ''){
      return;
    }
    try{
      final credenctial = await FirebaseAuth.instance.
      signInWithEmailAndPassword(
        email: email, 
        password: password);
      Get.to(() => HomeScreen(id: credenctial.user?.uid,));
      
      print(credenctial.user?.uid);
      print("Algo");
    }on FirebaseAuthException catch (e){
      Get.snackbar('Error', e.code, backgroundColor: Colors.blue[300], duration: const Duration(seconds: 5));
      if (e.code == 'user-not-found'){
        print("No user for that email");
      }
    }
  }
}