import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:missao_4/Back/FirebaseConfigs.dart';
import 'package:missao_4/Back/global.dart' as Global;
import 'package:missao_4/Telas/Backstage/Evento_Add.dart';
import 'package:missao_4/Telas/home_screen.dart';
import 'package:missao_4/Widgets/evento_cards.dart';
import 'package:missao_4/Widgets/evento_config_cards.dart';

class Evento_Home extends StatefulWidget {
  const Evento_Home({ Key? key }) : super(key: key);
 
  @override
  State<Evento_Home> createState() => Evento_HomeState();

}

class Evento_HomeState extends State<Evento_Home> {
  late CollectionReference feedHome;
  @override
  void initState() {
    super.initState();
    feedHome = FirebaseFirestore.instance.collection('Eventos');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eventos'),
        centerTitle: true,
        backgroundColor: Colors.purple,
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
       floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (contexto) => const Evendo_Add()));
        },
        backgroundColor: Color.fromARGB(255, 181, 130, 190),
        child: const Icon(Icons.add),
      ),
    );
  }
}
