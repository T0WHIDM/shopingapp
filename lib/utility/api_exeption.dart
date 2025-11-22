class ApiExeption implements Exception {
  String? message;
  int? code;

  ApiExeption(this.code, this.message);
}
