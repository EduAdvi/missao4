import 'package:flutter/material.dart';
import 'package:missao_4/Telas/feed_screen.dart';
import 'package:missao_4/Telas/home_screen.dart';
import 'package:missao_4/Telas/login_screen.dart';

import 'package:missao_4/Back/global.dart' as Global;
import 'package:missao_4/Back/FirebaseConfigs.dart';

//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_auth_web/firebase_auth_web.dart';


class Cadastro_Screen extends StatefulWidget {
  const Cadastro_Screen({ Key? key }) : super(key: key);

  @override
  State<Cadastro_Screen> createState() => _Cadastro_ScreenState();
}

class _Cadastro_ScreenState extends State<Cadastro_Screen> {
  
  @override

  var TextoNome = TextEditingController();
  var TextoSenha = TextEditingController();
  var TextoCSenha = TextEditingController();
  var TextoEmail = TextEditingController();
  var TextoCEmail = TextEditingController();



  Widget build(BuildContext context) {
    
   var  _aniversario;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children:[
          Container(
          child:  Column(
            
            children: [
             
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
                  controller: TextoCEmail,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirmar Email',
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
                padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: TextField(
                  controller: TextoCSenha,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirmar Senha',
                    
                  ),
                ),
              ),
             Container(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: TextField(
                  controller: TextoNome,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome',
                  ),
                ),
              ),

              
              Container( //botao
                padding: EdgeInsets.all(5),
                height: 70,
                width: 200,
               
                child: ElevatedButton(
                    onPressed: () async{
                    _aniversario = await showDatePicker(
                          context: context, 
                          initialEntryMode: DatePickerEntryMode.input,
                        
                 builder: (context, child) {
                   return Theme(
                          data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: Colors.purple, // header background color
                          onPrimary: Colors.white, // header text color
                          onSurface: Colors.black, // body text color
                        ),
                       
                      ),
                      child: child!,
                    );
                  },
    
                          //locale:  const Locale('es','ES'),
                          fieldLabelText: 'Escreva o dia que você nasceu :D',
                          //locale: Locale('pt','BR'),
                          helpText: 'Selecione o dia que você nasceu',
                          initialDate: DateTime(2000), 
                          firstDate: DateTime(1920), 
                          lastDate: DateTime.now()
                          );  
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.purple)),
                    child: Text('Selecionar Aniversario'),
                  ),
              ),
          
              Container( //botao
                padding: EdgeInsets.all(5),
                height: 70,
                width: 200,
               
                child: ElevatedButton(
                    onPressed: () {
                      print(_aniversario);
                      AutenticarComFirebase().criar_conta(TextoEmail.text,TextoCEmail,TextoSenha.text,TextoCSenha.text,TextoNome.text,_aniversario,context);
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.purple)),
                    child: Text('Cadastrar'),
                  ),
              ),
             
             
              
          ],)),
           
        ], 
      ),
      bottomSheet:  Text(' @Powered by IEQ Barrinha', textAlign: TextAlign.center,)       
    );
  }
 
}
 
