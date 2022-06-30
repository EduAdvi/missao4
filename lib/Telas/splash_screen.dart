import 'dart:core';
import 'package:flutter/material.dart';
import 'package:missao_4/Back/FirebaseConfigs.dart';
import 'package:missao_4/Back/global.dart' as Global;
import 'package:shared_preferences/shared_preferences.dart';
class Splash_Screen extends StatefulWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  State<Splash_Screen> createState() => Splash_ScreenState();
}

class Splash_ScreenState extends State<Splash_Screen> {
  @override
  Widget build(BuildContext context) {
    tentar_login(context);
    return Scaffold(
      backgroundColor: Global.fundo,
      body: Center(
        child: Container(

          child: Image.asset(
            'images/preto.png',
            width: 200,
            height: 200,
          ),

        ),
      ),
    );
  }
}

void tentar_login(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('LOGIN_INFO_EMAIL').toString();
  var senha = prefs.getString('LOGIN_INFO_SENHA').toString();
  
  AutenticarComFirebase().relogar(email, senha, context);
}

