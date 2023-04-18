class Usuario {
  final int usua_Id;
  final String usua_Usuario;
  final String usua_Clave;
  final int usua_Empleado;
  final String pers_Nombres;
  const Usuario({
    required this.usua_Id, 
    required this.usua_Usuario,
    required this.usua_Clave, 
    required this.usua_Empleado, 
    required this.pers_Nombres
  });

  factory Usuario.fromJson(Map<String, dynamic> json){
    return Usuario(
      usua_Id: json["usua_Id"], 
      usua_Usuario: json["usua_Usuario"], 
      usua_Clave: json["usua_Clave"], 
      usua_Empleado: json["usua_Empleado"], 
      pers_Nombres: json["pers_Nombres"]
    );
  }
}