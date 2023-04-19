class Envios {

    final   int envi_Id;
    final   int envi_Camion;
    final   String envi_FechaSalida;
    final   int envi_UsuarioCrea ;
    final   DateTime envi_FechaCrea;
    final   int envi_UsuarioModifica;
    final   DateTime envi_FechaModifica;
    final   bool envi_Estado;



  const Envios({
    required this.envi_Id, 
    required this.envi_Camion,
    required this.envi_FechaSalida, 
    required this.envi_UsuarioCrea,
    required this.envi_FechaCrea, 
    required this.envi_UsuarioModifica,
    required this.envi_FechaModifica, 
    required this.envi_Estado,
   
  
  
  });

  factory Envios.fromJson(Map<String, dynamic> json){
    return Envios(
      envi_Id: json["envi_Id"], 
      envi_Camion: json["envi_Camion"], 
      envi_FechaSalida: json["envi_FechaSalida"], 
      envi_UsuarioCrea: json["envi_UsuarioCrea"], 
      envi_FechaCrea: json["envi_FechaCrea"], 
      envi_UsuarioModifica: json["envi_UsuarioModifica"], 
      envi_FechaModifica: json["envi_FechaModifica"], 
      envi_Estado: json["envi_Estado"], 
     
    );
  }
}