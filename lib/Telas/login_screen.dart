import 'package:flutter/material.dart';
import 'package:missao_4/Telas/feed_screen.dart';
import 'package:missao_4/Telas/home_screen.dart';
import 'package:missao_4/Telas/cadastro_screen.dart';
import 'package:missao_4/Back/global.dart' as Global;
import 'package:missao_4/Telas/cadastro_screen.dart';
import 'package:missao_4/Back/FirebaseConfigs.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  @override
  var TextoSenha = TextEditingController();
  var TextoEmail = TextEditingController();
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          centerTitle: true,
          backgroundColor: Global.principal,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  child: Column(
                children: [
                  Container(
                    child: Image.asset(
                      'images/preto.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                    child: TextField(
                      controller: TextoEmail,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                    child: TextField(
                      controller: TextoSenha,
                      obscureText: true,
                      decoration: InputDecoration(
                        hoverColor: Global.principal,
                        // border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                        border: UnderlineInputBorder(),
                        labelText: 'Senha',
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: TextButton(
                      onPressed: () {
                        AutenticarComFirebase()
                            .recuperar_senha(TextoEmail.text, context);
                      },
                      //style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Global.principal)),
                      child: Text(
                        'Esqueci minha senha',
                        style: TextStyle(color: Global.principal),
                      ),
                    ),
                  ),
                  Container(
                    //botao
                    padding: EdgeInsets.all(5),
                    height: 70,
                    width: 200,

                    child: RaisedButton(
                      textTheme: ButtonTextTheme.normal,
                      child:
                          Text('Login', style: TextStyle(color: Global.texto1)),
                      color: Global.principal,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: Global.principal)),
                      onPressed: () {
                        AutenticarComFirebase()
                            .login(TextoEmail.text, TextoSenha.text, context);
                      },
                    ),
                  ),
                  Container(
                    //botao
                    padding: EdgeInsets.all(5),
                    height: 70,
                    width: 200,

                    child: RaisedButton(
                      textTheme: ButtonTextTheme.normal,
                      child: Text('Cadastrar',
                          style: TextStyle(color: Colors.black)),
                      color: Global.fundo,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: Global.cor_botao_principal)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Cadastro_Screen()));
                      },
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
        bottomSheet: Container(
            height: 15,
            alignment: Alignment.bottomCenter,
            child: Text(
              '  @Powered by IEQ Barrinha',
              textAlign: TextAlign.center,
            )));
  }
}

