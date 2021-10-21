


import 'package:dio/dio.dart';

abstract class HttpService{
  void init();
  Future<Response> getRequest(String endpoint,Map<String,dynamic> param);
  Future<Response> postRequest(String endpoint,Map<String,dynamic> param);
}