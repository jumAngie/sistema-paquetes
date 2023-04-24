class Camiones {
  final int cami_Id;
  final String transportista;

  
  const Camiones({
    required this.cami_Id, 
    required this.transportista,
   
  });

  factory Camiones.fromJson(Map<String, dynamic> json){
    return Camiones(
      cami_Id: json["cami_Id"], 
      transportista: json["transportista"], 
     
    );
  }
}