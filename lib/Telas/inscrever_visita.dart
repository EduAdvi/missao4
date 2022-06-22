
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:missao_4/Back/FirebaseConfigs.dart';
import 'package:missao_4/Telas/feed_screen.dart';
import 'package:missao_4/Telas/home_screen.dart';
import 'package:missao_4/Telas/login_screen.dart';
import 'package:missao_4/Back/global.dart' as Global;
import 'package:image_picker/image_picker.dart';


//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_auth_web/firebase_auth_web.dart';


class Visita_Add extends StatefulWidget {

  const Visita_Add({ Key? key}): super(key: key);
  @override
  State<Visita_Add> createState() => _Visita_AddState();
}

class _Visita_AddState extends State<Visita_Add> {
  

  

  @override
  var link_imagem;
  var TextoNome = TextEditingController();
  var TextoSenha = TextEditingController();
  var TextoCSenha = TextEditingController();
  var TextoEmail = TextEditingController();
  var TextoCEmail = TextEditingController();
  bool? checkedValue = false;
  var imagem_arquivo;


  Widget build(BuildContext context) {
    
   var  _data;


    return Scaffold(
      
      appBar: AppBar(
        title: Text('Inscrever visita'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
       // scrollDirection: ScrollDirection.idle,
        child: Column(
        children:[
          Container(
          child:  Column(
            
            children: [
              
              Container(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: TextField(
                  controller: TextoNome,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome da Visita',
                  ),
                ),
              ),
              
         
        


              Container( //botao
                padding: EdgeInsets.all(5),
                height: 80,
                width: 400,
               
                child: CheckboxListTile(
  title: Text("Primeira vez"),
  subtitle: Text("Marque se for a primeira vez que essa visita vem no Missao 4"),
      value: checkedValue,
       onChanged: (newValue) {
          setState(() {
          checkedValue = newValue;
          print(checkedValue);
        });
  },
  controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
)
              ),          
          
             
              Container( //botao
                padding: EdgeInsets.all(5),
                height: 70,
                width: 200,
               
                child: ElevatedButton(
                    onPressed: () {
                      CRUDFirestore().Inscrever_Visita(Global.evento_provisorio, Global.UserUid, TextoNome.text, checkedValue, context);
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.purple)),
                    child: Text('Inscrever Visita'),
                  ),
              ),
             
             
              
          ],)),
           
        ], 
      ),
     // bottomSheet:  Text(' @Powered by IEQ Barrinha', textAlign: TextAlign.center,)       
    ));
  }
 
}
 
