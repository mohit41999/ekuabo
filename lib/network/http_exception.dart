class HttpException implements Exception{
  String response;
  HttpException(this.response);
}