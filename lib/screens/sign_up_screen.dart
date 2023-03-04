import 'package:curso_flutter_formulario_amador/controllers/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class SignUpScreen extends StatelessWidget {
  final controller = Get.put(SignUpController());
  final String texto = '';


  SignUpScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
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
                icono: Icons.person, 
                tipoCapitalization: TextCapitalization.words,
                onChanged: (value) {
                  controller.handleName(value);
                  print(value);
                }
                
              ),
              const SizedBox(height: 20,),

              TextFormFieldCreator(
                textoEscondido: 'Apellido(s)', 
                icono: Icons.person,
                tipoCapitalization: TextCapitalization.words,
                onChanged: controller.handleApellidos
              ),
    
              const SizedBox(height: 20,),

              TextFormFieldCreator(
                textoEscondido: 'Telefono', 
                icono: Icons.phone, 
                tipoTeclado: TextInputType.phone,
                onChanged: controller.handleTelefono
              ),
              const SizedBox(height: 20,),

               // D A T E   F I E L D 
              Row(
                children: const [
                  Expanded(
                    child: Calendario(
                    )
                  ),
                  
                  SizedBox(width: 20,),

                  Expanded(
                    child: GeneroDropdown(
                    )
                  ),
                ],
              ),
              const SizedBox(height: 20,),

              TextFormFieldCreator(
                textoEscondido: 'E-mail', 
                icono: Icons.email, 
                tipoTeclado: TextInputType.emailAddress,
                onChanged: controller.handleEmail
              ),
              const SizedBox(height: 20,),

              TextFormFieldCreator(
                textoEscondido: 'Contraseña', 
                icono: Icons.password, 
                tipoTeclado: TextInputType.text,
                onChanged: controller.handlePassword
              ),
              const SizedBox(height: 40,),
              
              Container(
                width: 100,
                height: 50,
                
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue[800],
                  
                ),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                     controller.handleSignUp();
                     print("dd");
                    }, 
                    child: const Text(
                      'Sign Up',
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

  const TextFormFieldCreator({
    super.key, 
    required this.textoEscondido, 
    required this.icono, 
    this.tipoTeclado = TextInputType.text, 
    this.tipoCapitalization = TextCapitalization.none,
    this.controller, 
    this.onChanged,
    });

  @override
  State<TextFormFieldCreator> createState() => _TextFormFieldCreatorState();
}

class _TextFormFieldCreatorState extends State<TextFormFieldCreator> {
  String texto = '';
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
}

class Calendario extends StatefulWidget {
  const Calendario({super.key});

  @override
  State<Calendario> createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  String tiempo = '';
  final controller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    
    return TextFormField(
      controller: TextEditingController(text: tiempo),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: 'Fecha de nacimiento',
        labelText: 'Fecha de nacimiento',
        suffixIcon: IconButton(
          onPressed: ()  {
              showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now().subtract(const Duration(days: 29200)),
              lastDate: DateTime.now().add(const Duration(days: 0)),
            ).then((pickedDate) {
              setState(() {
                var fecha = "${pickedDate?.month}/${pickedDate?.day}/${pickedDate?.year}";
                tiempo = fecha;
                controller.handleFechaDeNacimiento(tiempo);
                print(tiempo);
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
  const GeneroDropdown({super.key});

  @override
  State<GeneroDropdown> createState() => _GeneroDropdownState();
}

class _GeneroDropdownState extends State<GeneroDropdown> {
  final controller = Get.put(SignUpController());

  List<String> itemsDropdown = ['Hombre', 'Mujer', 'Otro'];
  String valueDropdown = 'Hombre';
  
  @override
  Widget build(BuildContext context) {
    controller.handleGenero(valueDropdown);
    print(valueDropdown);
    return DropdownButton(
      borderRadius: BorderRadius.circular(10),
      value: valueDropdown,
      items: itemsDropdown
          .map((item) =>
              DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: (value) {
        
        setState(
          () {
            valueDropdown = value!;
            
          },
        );
      },
    );
  }
}