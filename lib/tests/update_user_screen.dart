import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curso_flutter_formulario_amador/controllers/delete_user_controller.dart';
import 'package:curso_flutter_formulario_amador/controllers/sign_up_controller.dart';
import 'package:curso_flutter_formulario_amador/controllers/update_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/get_user_controller.dart';
    
final controller = Get.put(UpdateUserController());
final controllerGetUser = Get.put(GetUserController());
final controllerDelete = Get.put(DeleteUserController());


class UpdateUserScreen extends StatelessWidget {
  final String documentId;
  
  

  const UpdateUserScreen({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {
    Future<Map<String, dynamic>> data;
    
    //CollectionReference users = FirebaseFirestore.instance.collection('Usuarios');
    controller.handleId(documentId);
    controllerDelete.handleId(documentId);
    

    Future<Map<String, dynamic>> getUser() async {
      Map<String, dynamic> data = await controllerGetUser.handleUser();
      return data;
    }
    data = getUser();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Info"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_back_ios)),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(25),
          child: Column(
            children: [
              TextFormFieldCreator(
                textoEscondido: 'Nombre',
                ////info: data,
                icono: Icons.person, 
                tipoCapitalization: TextCapitalization.words,
                onChanged:  controller.handleName,
                controllerUpdate: "Nombre",

                
                
              ),
              const SizedBox(height: 20,),

              TextFormFieldCreator(
                textoEscondido: 'Apellido(s)',
                ////info: data['apellidos'].toString(), 
                icono: Icons.person,
                tipoCapitalization: TextCapitalization.words,
                onChanged: controller.handleApellidos,
                controllerUpdate: "Apellidos",
              ),
    
              const SizedBox(height: 20,),

              TextFormFieldCreator(
                textoEscondido: 'Telefono',
                //info: data['telefono'].toString(),
                icono: Icons.phone, 
                tipoTeclado: TextInputType.phone,
                onChanged: controller.handleTelefono,
                controllerUpdate: "Telefono",
              ),
              const SizedBox(height: 20,),

               // D A T E   F I E L D 
              Row(
                children: [
                  Expanded(
                    child: Calendario(
                      //info: data['fechaDeNacimiento'].toString()
                    )
                  ),
                  
                  SizedBox(width: 20,),

                  Expanded(
                    child: GeneroDropdown(
                      //info: data['genero'].toString()
                    )
                  ),
                ],
              ),
              const SizedBox(height: 20,),

              TextFormFieldCreator(
                textoEscondido: 'E-mail',
                //info: data['email'].toString(),
                icono: Icons.email, 
                tipoTeclado: TextInputType.emailAddress,
                enable: false,
                onChanged: controller.handleEmail,
                controllerUpdate: "Email",
              ),
              const SizedBox(height: 20,),

              TextFormFieldCreator(
                textoEscondido: 'Contraseña', 
                ////info: data['password'].toString(),
                icono: Icons.password, 
                tipoTeclado: TextInputType.text,
                onChanged: controller.handlePassword,
                controllerUpdate: "Password",
              ),
              const SizedBox(height: 40,),
              
              Container(
                width: 200,
                height: 50,
                
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue[800],
                  
                ),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      
                     controller.handleUpdateUser();
                     print("Updated");
                    }, 
                    child: const Text(
                      'Actualizar Datos',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                ),
              ),
            SizedBox(height: 20,),
            Container(
                width: 200,
                height: 50,
                
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.red[900],
                  
                ),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      
                     controllerDelete.handleDeleteUser();
                     print("Updated");
                    }, 
                    child: const Text(
                      'Eliminar Cuenta',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                ),
              ),
            ]
          ),
        ),
      ),
    );

      }
    
  }


class TextFormFieldCreator extends StatefulWidget {
final String textoEscondido;
final IconData icono;
final TextInputType tipoTeclado;
final TextCapitalization tipoCapitalization;
final SignUpController? controller;
final Function(String)? onChanged;
//final String info;
final bool enable;
final String controllerUpdate;

  const TextFormFieldCreator({
    super.key, 
    required this.textoEscondido, 
    required this.icono, 
    //required this.info,
    this.tipoTeclado = TextInputType.text, 
    this.tipoCapitalization = TextCapitalization.none,
    this.enable = true,
    this.controller, 
    this.onChanged,
    required this.controllerUpdate,
    });

  @override
  State<TextFormFieldCreator> createState() => _TextFormFieldCreatorState();
}

class _TextFormFieldCreatorState extends State<TextFormFieldCreator> {
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      builder:(BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        /*String info = widget.info;

        switch(widget.controllerUpdate){
          case "Nombre":
            controller.handleName(widget.info);
          break;
          case "Apellidos":
            controller.handleApellidos(widget.info);
          break;
          case "Telefono":
            controller.handleTelefono(widget.info);
          break;
          case "Email":
            controller.handleEmail(widget.info);
          break;
          case "Password":
            controller.handlePassword(widget.info);
          break;
        }*/

        return TextFormField(
          enableInteractiveSelection: widget.enable,
          //controller: TextEditingController(text: info),
          keyboardType: widget.tipoTeclado,
          decoration: InputDecoration(
            hintText: widget.textoEscondido,
            labelText: widget.textoEscondido,
            border: const OutlineInputBorder(),
            prefixIcon: Icon(widget.icono),
          ),
          textCapitalization: widget.tipoCapitalization,
          onChanged: widget.onChanged,
      
    );
          }
    );
  }
}

class Calendario extends StatefulWidget {
  //final String info;
  const Calendario({super.key, 
  //required this.info
  
  });

  @override
  State<Calendario> createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
      String info = "";
  @override
  Widget build(BuildContext context) {

    
    
    return TextFormField(
      controller: TextEditingController(text: info),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: 'Fecha de nacimiento',
        labelText: 'Fecha de nacimiento',
        suffixIcon: IconButton(
          onPressed: ()  {
              showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now().subtract(const Duration(days: 3650)),
              lastDate: DateTime.now().add(const Duration(days: 3650)),
            ).then((pickedDate) {
              setState(() {
                var fecha = "${pickedDate?.month}/${pickedDate?.day}/${pickedDate?.year}";
                info = fecha;
                controller.handleFechaDeNacimiento(info);
                print(info);
              });
            },);
          },
          icon: const Icon(Icons.calendar_month_outlined)
        )  
        
      ), 
      
    );
  }
}

class GeneroDropdown extends StatefulWidget{
  //String info;
  GeneroDropdown({super.key, 
  //required this.info
  });
  
  @override
  State<GeneroDropdown> createState() => _GeneroDropdownState();
}

class _GeneroDropdownState extends State<GeneroDropdown> {
  List<String> itemsDropdown = ['Hombre', 'Mujer', 'Otro'];

  
  @override
  Widget build(BuildContext context) {
    //controller.handleGenero(widget.info);
    //print(widget.info);
    return DropdownButton(
      borderRadius: BorderRadius.circular(10),
      //value: widget.info,
      items: itemsDropdown
          .map((item) =>
              DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: (value) {
        
        setState(
          () {
            //widget.info = value!;
            
          },
        );
      },
    );
  }
}


