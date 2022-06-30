import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:missao_4/Back/FirebaseConfigs.dart';
import 'package:missao_4/Back/global.dart' as Global;
import 'package:missao_4/Telas/Backstage/Evento_Add.dart';
import 'package:missao_4/Telas/home_screen.dart';
import 'package:missao_4/Widgets/evento_cards.dart';
import 'package:missao_4/Widgets/evento_config_cards.dart';
import 'package:missao_4/Widgets/pessoas_card.dart';

class Pessoas_Screen extends StatefulWidget {
  const Pessoas_Screen({ Key? key }) : super(key: key);
 
  @override
  State<Pessoas_Screen> createState() => Pessoas_ScreenState();

}

class Pessoas_ScreenState extends State<Pessoas_Screen> {
  late CollectionReference feedHome;
  @override
  void initState() {
    super.initState();
    feedHome = FirebaseFirestore.instance.collection('Usuarios_data');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pessoas'),
        centerTitle: true,
        backgroundColor: Global.principal,
      ),
      backgroundColor: Colors.white,
      body: Container(
        
          decoration: BoxDecoration(color: Colors.white),
          child: StreamBuilder<QuerySnapshot>(
            stream:  feedHome.snapshots(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState){
                case ConnectionState.none:
                  return const Center(
                    child:
                        Text('Não foi possivel se conectar ao Servidor'),
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
                        return Pessoas_Card(item: dados.docs[index]);
                      });
              }
            },
          )),
    );
  }
}
