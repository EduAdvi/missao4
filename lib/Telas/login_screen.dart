import 'package:flutter/material.dart';
import 'package:missao_4/Telas/feed_screen.dart';
import 'package:missao_4/Telas/home_screen.dart';
import 'package:missao_4/Telas/cadastro_screen.dart';
import 'package:missao_4/Back/global.dart' as Global;
import 'package:missao_4/Telas/cadastro_screen.dart';
import 'package:missao_4/Back/FirebaseConfigs.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_auth/firebase_auth.dart';


class Login_Screen extends StatefulWidget {
  const Login_Screen({ Key? key }) : super(key: key);

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
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children:[
          Container(
          child:  Column(
            
            children: [
              Container(
                  child: Image.asset(
                    'images/preto.png',
                    width: 200,
                    height: 200,
                  ),
                    
                ),
              Container(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: TextField(
                  controller: TextoEmail,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),
           Container(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: TextField(
                  controller: TextoSenha,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Senha',
                  ),
                ),
              ),
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: TextButton(
                    onPressed: () {
                        AutenticarComFirebase().recuperar_senha(TextoEmail.text, context);
                    },
                    //style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.purple)),
                    child: Text('Esqueci minha senha',style: TextStyle(color: Colors.purple),),
                  ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                height: 70,
                width: 200,
               
                child: ElevatedButton(
                    onPressed: () {
                      AutenticarComFirebase().login(TextoEmail.text,TextoSenha.text,context);
                      //Global.login(TextoEmail.text, TextoSenha.text, context);
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.purple)),
                    child: Text('Login'),
                  ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                height: 70,
                width: 200,
               
                child: ElevatedButton(
                    onPressed: () {
                                                  Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => Cadastro_Screen()));
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.purple)),
                    child: Text('Cadastrar'),
                  ),
              ),
             
             
              
          ],)),
           
        ], 
      ),
      bottomSheet:  Container(
        height: 15,
        alignment: Alignment.bottomCenter,
         child: Text('  @Powered by IEQ Barrinha', 
         textAlign: TextAlign.center,
         ))       
    );
  }




}
 
