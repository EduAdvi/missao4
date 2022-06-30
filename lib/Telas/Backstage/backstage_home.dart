
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:missao_4/Back/FirebaseConfigs.dart';
import 'package:missao_4/Telas/Backstage/Evento_Add.dart';
import 'package:missao_4/Telas/Backstage/Eventos_home.dart';
import 'package:missao_4/Telas/Backstage/Pessoas_Evento_screen.dart';
import 'package:missao_4/Telas/Backstage/Pessoas_screen.dart';
import 'package:missao_4/Telas/feed_screen.dart';
import 'package:missao_4/Telas/home_screen.dart';
import 'package:missao_4/Telas/login_screen.dart';
import 'package:missao_4/Back/global.dart' as Global;
import 'package:image_picker/image_picker.dart';


//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_auth_web/firebase_auth_web.dart';


class Backstage_Home extends StatefulWidget {
  

  const Backstage_Home({ Key? key}): super(key: key);
  @override
  State<Backstage_Home> createState() => _Backstage_HomeState();
}

class _Backstage_HomeState extends State<Backstage_Home> {
  
  @override


  Widget build(BuildContext context) {
    
   var  _data;


    return Scaffold(
      
      appBar: AppBar(
        title: Text('Backstage Account'),
        centerTitle: true,
        backgroundColor: Global.principal,
      ),
      body: 
      Container(
      decoration: BoxDecoration(color: Global.fundo),
      child:SingleChildScrollView(
    
      // scrollDirection: ScrollDirection.,
        child: Column(
          
        children:[

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.fromLTRB(10, 10, 0, 10),  // botao
              child:   Container(
                padding: EdgeInsets.all(0),
                
                width: 100,
                height: 100,
                decoration: BoxDecoration(color: Global.principal,borderRadius: BorderRadius.circular(30) ),
                child:  ElevatedButton(

                  style: ButtonStyle(
                    
                    backgroundColor:  MaterialStateProperty.all<Color>(Global.principal),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: Global.principal)
                    )
                  ) ),
                    onPressed: () {
                         Navigator.push(context,  MaterialPageRoute(builder: (contexto) => const Evento_Home()));
                    },
                    //style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
                    child: Center( child: Column( children: [
                      Icon(Icons.event , size: 70,),
                      Text('Eventos')
                    ],))
                  ),
              ),
              ),
              //
               Padding(padding: EdgeInsets.fromLTRB(10, 10, 0, 10),  // botao
              child:   Container(
                padding: EdgeInsets.all(0),
                width: 100,
                height: 100,
                decoration: BoxDecoration(color: Global.principal,borderRadius: BorderRadius.circular(30) ),
                child:  ElevatedButton(

                  style: ButtonStyle(
                    
                    backgroundColor:  MaterialStateProperty.all<Color>(Global.principal),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: Global.principal)
                    )
                  ) ),
                    onPressed: () {
                        Navigator.push(context,  MaterialPageRoute(builder: (contexto) => const Pessoas_Screen()));
                    },
                    //style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
                    child: Center( child: Column( children: [
                      Icon(Icons.person , size: 70,),
                      Text('Pessoas')
                    ],))
                  ),
              ),
              ),

            ],
          )              
        ], 
      ),
     // bottomSheet:  Text(' @Powered by IEQ Barrinha', textAlign: TextAlign.center,)       
    )));
  }
 
}
 
