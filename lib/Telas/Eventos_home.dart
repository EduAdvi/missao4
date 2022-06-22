
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:missao_4/Back/FirebaseConfigs.dart';
import 'package:missao_4/Telas/Evento_Add.dart';
import 'package:missao_4/Telas/feed_screen.dart';
import 'package:missao_4/Telas/home_screen.dart';
import 'package:missao_4/Telas/login_screen.dart';
import 'package:missao_4/Back/global.dart' as Global;
import 'package:image_picker/image_picker.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:missao_4/Widgets/evento_config_cards.dart';


//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_auth_web/firebase_auth_web.dart';


class Eventos_Home extends StatefulWidget {

  const Eventos_Home({ Key? key}): super(key: key);
  
  @override
  
  State<Eventos_Home> createState() => _Eventos_HomeState();
}

class _Eventos_HomeState extends State<Eventos_Home> {
  

  @override

  Widget build(BuildContext context) {
    
   var  _data;


    return Scaffold(
      
      appBar: AppBar(
        title: Text('Gerenciar eventos'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
      // scrollDirection: ScrollDirection.,
        child:  Container(
        
          decoration: BoxDecoration(color: Colors.white),
          child: StreamBuilder<QuerySnapshot>(
            stream:  FirebaseFirestore.instance.collection('Eventos').snapshots(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState){
                case ConnectionState.none:
                  return const Center(
                    child:
                        Text('Não foi possivel se conectar ao Banco de Dados'),
                  );
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                default:
                  final dados = snapshot.requireData;
                  return ListView.builder(
                      
                      itemCount: dados.size,
                      itemBuilder: (context, index) {
                     
                       // return itemLista(dados.docs[index],context);
                       //CRUDFirestore().Conferir_Inscricao(Global.UserUid, dados.docs[index].get('id')).then((value) => value)
                        return Evento_Config_Card(item: dados.docs[index],chave: false);
                      });
              }
            },
          )),
     // bottomSheet:  Text(' @Powered by IEQ Barrinha', textAlign: TextAlign.center,)       
    ),
   floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
      ));
  }
 
}
 
