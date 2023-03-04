import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  final String nombre;
  final String apellidos;
  final String fechaDenacimiento;
  final String genero;
  final String telefono;
  final String email;
  final String password;

  Usuario({
    required this.nombre,
    required this.apellidos,
    required this.fechaDenacimiento,
    required this.genero,
    required this.telefono,
    required this.email,
    required this.password,
  });

  factory Usuario.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Usuario(
      nombre: data?['name'],
      apellidos: data?['apellidos'],
      fechaDenacimiento: data?['tiempo'],
      genero: data?['genero'],
      telefono: data?['telefono'],
      email: data?['email'],
      password: data?['password'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (nombre != null) "nombre": nombre,
      if (apellidos != null) "apellidos": apellidos,
      if (fechaDenacimiento != null) "fechaDeNacimiento": fechaDenacimiento,
      if (genero != null) "genero": genero,
      if (telefono != null) "telefono": telefono,
      if (email != null) "email": email,
      if (password != null) "password": password,
    };
  }
}
