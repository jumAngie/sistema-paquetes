class responseApi {
  int code;
  bool success ;
  String message;
  dynamic data;
  responseApi({
    required this.code, 
    required this.success,
    required this.message, 
    required this.data
  });

   factory responseApi.fromJson(Map<String, dynamic> json){
    return responseApi(
      code: json["code"], 
      success: json["success"], 
      message: json["message"], 
      data: json["data"]
    );
  }
}

