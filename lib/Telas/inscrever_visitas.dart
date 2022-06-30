import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:missao_4/Back/FirebaseConfigs.dart';
import 'package:missao_4/Back/global.dart' as Global;
import 'package:missao_4/Telas/Backstage/Evento_Add.dart';
import 'package:missao_4/Telas/home_screen.dart';
import 'package:missao_4/Telas/visita_add.dart';
import 'package:missao_4/Widgets/evento_cards.dart';
import 'package:missao_4/Widgets/evento_config_cards.dart';
import 'package:missao_4/Widgets/pessoas_card.dart';
import 'package:missao_4/Widgets/pessoas_evento_card.dart';

class Inscrever_Visitas extends StatefulWidget {

  final id;

  const Inscrever_Visitas({ Key? key,this.id }) : super(key: key);
 
  @override
  State<Inscrever_Visitas> createState() => Inscrever_VisitasState();

}

class Inscrever_VisitasState extends State<Inscrever_Visitas> {
  late CollectionReference feedHome;
  @override
  void initState() {
    super.initState();
    feedHome = FirebaseFirestore.instance.collection('Eventos_Log').doc(widget.id.toString()).collection('Data').doc('Inscritos').collection('Nomes');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pessoas inscritas por você'),
        centerTitle: true,
        backgroundColor: Global.principal,
      ),
      backgroundColor: Colors.white,
      body: Container(
        
          decoration: BoxDecoration(color: Colors.white),
          child: StreamBuilder<QuerySnapshot>(
            stream:  feedHome.where('id', isEqualTo: Global.UserUid).snapshots(),
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
                        return Pessoas_Evento_Card(item: dados.docs[index],referencia: dados.docs[index].id,id_evento: widget.id.toString(),);
                      });
              }
            },
          )),
          floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (contexto) => Visita_Add(id: widget.id.toString(),)));
        },
        backgroundColor: Global.secundaria,
        child: const Icon(Icons.add),
      ),
    );
  }
}
