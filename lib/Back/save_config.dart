import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class SalvarUser {

  void Salvar(email,senha,uid) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('LOGIN_INFO_EMAIL', email);
    prefs.setString('LOGIN_INFO_SENHA', senha);
    prefs.setString('LOGIN_INFO_UID', uid);
  }


  void LER(context)async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     print(prefs.getString('LOGIN_INFO_EMAIL'));
     String Texto = prefs.getString('LOGIN_INFO_EMAIL').toString();
     
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          content: Text(Texto.toString()),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green));
  }
}

