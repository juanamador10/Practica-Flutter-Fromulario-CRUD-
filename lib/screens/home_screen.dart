import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curso_flutter_formulario_amador/controllers/get_user_controller.dart';
import 'package:curso_flutter_formulario_amador/screens/update_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final controllerGetUser = Get.put(GetUserController());
class HomeScreen extends StatefulWidget {
  //final String nombre;
  final id;
  
  const HomeScreen({super.key,  required this.id});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  
  
  @override
  Widget build(BuildContext context) {
    controllerGetUser.handleId(widget.id);
    return Scaffold(
      appBar: AppBar(
        title: (Text(nombreUsuario().toString())),
        centerTitle: true,
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop();
        },
          icon: const Icon(Icons.logout_rounded),
        ),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateUserScreen(documentId: widget.id)));
          }, icon: Icon(Icons.settings)),
        ]) ,
      body: Container(
        margin: const EdgeInsets.all(20),
        width: double.infinity,
        
        child: Column(
          //mainAxisSize: MainAxisSize.max,
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(nombreUsuario().toString()),
            //const Text('Bienvenido', style: TextStyle(fontSize: 20,), textAlign: TextAlign.end,),
            //Text(nombre, style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),      

          ],
        ),
      ),
    );

    
  }
  nombreUsuario () async {
    
     final userName = await controllerGetUser.handleUser();
     return userName;
  }

}