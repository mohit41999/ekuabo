import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Utils{
  void showSnackBar(BuildContext context,String msg)
  {
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:msg.text.make()));
  }
  static bool isEmailValid(String email){
    return  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
  static bool isPasswordValid(String password)
  {
    return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(password);
  }

}