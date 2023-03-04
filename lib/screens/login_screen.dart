import 'package:curso_flutter_formulario_amador/controllers/login_controller.dart';
import 'package:curso_flutter_formulario_amador/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginScreen extends StatelessWidget {
  final controller = Get.put(LoginController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle etiquetaNegra15 = const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black);
    TextStyle etiquetaNegra35 = const TextStyle(fontWeight: FontWeight.bold, fontSize: 35, color: Colors.black);

    return Scaffold(

      body: Container(
        margin: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text('Login', style: etiquetaNegra35,),
            const SizedBox(height: 50,),
            
            SizedBox(
              width: double.infinity, 
              child: Text('E-mail', style: etiquetaNegra15,)
            ),
            TextFormFieldCreator(
              tipoTeclado: TextInputType.emailAddress,
              hintText: 'Email', 
              icono: Icons.email,
              onChanged: controller.handleEmail,
              ),
            const SizedBox(height: 20,),

            SizedBox(
              width: double.infinity, 
              child: Text('Contraseña', style: etiquetaNegra15,)
            ),
            TextFormFieldCreator(
              hintText: 'Contraseña', 
              icono: Icons.password,
              onChanged: controller.handlePassword,
              ),
            const SizedBox(height: 40,),


            Row(
              children: [
                Expanded(
                  child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue[300],
                        
                      ),
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            //Navigator.pushNamed(context, 'sign_up');
                            controller.handleLogin();
                          }, 
                          child: const Text('Login',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),)
                      ),
                    ),
                ),
                
                const SizedBox(width: 20,),

                Expanded(
                  child: Container(
                      width: 100,
                      height: 50,
                      
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue[800],
                        
                      ),
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpScreen()));
                          }, 
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),)
                      ),
                    ),
                ),
              ],
            )



          ],
        ),
      ),
    );
  }
}

class TextFormFieldCreator extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final IconData icono;
  final TextInputType tipoTeclado;
  final TextCapitalization tipoCapitalization;
  final Function(String)? onChanged;

  const TextFormFieldCreator({
    super.key, 
    this.hintText,
    this.labelText, 
    required this.icono, 
    this.onChanged,
    this.tipoTeclado = TextInputType.text, 
    this.tipoCapitalization = TextCapitalization.none,
    });


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: tipoTeclado,
      decoration: InputDecoration(
       hintText: hintText,
        //labelText: labelText,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icono),
      ),
      textCapitalization: tipoCapitalization,
      
      onChanged: onChanged,
        //Nos sirve para realizar una accion por cada valor que se escribe

    );
  }
}

