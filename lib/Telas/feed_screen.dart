import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:missao_4/Back/FirebaseConfigs.dart';
import 'package:missao_4/Back/global.dart' as Global;
import 'package:missao_4/Telas/Backstage/Evento_Add.dart';
import 'package:missao_4/Telas/home_screen.dart';
import 'package:missao_4/Widgets/evento_cards.dart';

class Feed extends StatefulWidget {
  const Feed({ Key? key }) : super(key: key);
 
  @override
  State<Feed> createState() => FeedState();

}

class FeedState extends State<Feed> {
  late CollectionReference feedHome;
  @override
  void initState() {
    super.initState();
    feedHome =  FirebaseFirestore.instance.collection('Eventos');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Global.fundo,
      body: Container(
        
          decoration: BoxDecoration(color: Global.fundo),
          child: StreamBuilder<QuerySnapshot>(
            stream:  feedHome.where('visivel',isEqualTo: true).snapshots(),
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
                        return Evento_Card(item: dados.docs[index],chave: false);
                      });
              }
            },
          )),
    
    );
  }
}
