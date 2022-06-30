import 'dart:async';

import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:missao_4/Back/FirebaseConfigs.dart';
import 'package:missao_4/Back/global.dart' as Global;
import 'package:missao_4/Telas/Backstage/Evento_Add.dart';
import 'package:missao_4/Telas/home_screen.dart';
import 'package:missao_4/Telas/inscrever_visitas.dart';
import 'package:missao_4/Telas/visita_add.dart';

class Evento_Card extends StatefulWidget {
  final item;
  final chave;

  const Evento_Card({Key? key, this.item, this.chave})
      : super(
          key: key,
        );

  @override
  State<Evento_Card> createState() => _Evento_CardState();
}

class _Evento_CardState extends State<Evento_Card> {
  late CollectionReference evento;
  @override
  void initState() {
    super.initState();
    evento = FirebaseFirestore.instance
        .collection('Eventos_Log')
        .doc(widget.item.data()['id'])
        .collection('Data')
        .doc('Inscritos')
        .collection('Nomes');
  }

  Widget build(BuildContext context) {
    String inscrito_b;
    String titulo = widget.item.data()['Nome'];
    String vagas = widget.item.data()['vagas'];
    DateTime data = DateTime.parse(widget.item.data()['data'].toString());
    var link = widget.item.data()['Imagem'];
    var id_evento = widget.item.data()['id'];
    var t_vagas = vagas;
    String t_botao = 'teste';
    String insc_estado = widget.item.data()['insc_estado'];
    Color cor_botao;
    var eu_inscrito = widget.chave;
    print('OIA: ' + eu_inscrito.toString());

    if (eu_inscrito == false) {
      inscrito_b = 'Confirmar presença';
      cor_botao = Colors.blue;
      print('Voce nao esta escrito para:' + titulo);
    } else if (eu_inscrito == true) {
      inscrito_b = 'Cancelar inscricão';
      cor_botao = Colors.red;
      print('Voce esta escrito para:' + titulo);
    } else {
      inscrito_b = 'Inscriçoes pausadas';
      cor_botao = Colors.orange;
      //print('Voce esta escrito para:' + titulo);
    }

    return ListTile(
        title: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Global.fundo,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(),
            ),
            child: Column(children: [
              Text(
                titulo,
                style: TextStyle(color: Global.texto, fontSize: 25),
              ),

              Container(
                child: Image.network(
                  link.toString(),
                  height: 350,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Icon(
                      Icons.calendar_month,
                      color: Global.texto,
                    ),
                  ),
                  Container(
                    child: Text(
                      data.day.toString() +
                          '/' +
                          data.month.toString() +
                          '/' +
                          data.year.toString(),
                      style: TextStyle(color: Global.texto, fontSize: 20),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Icon(Icons.watch_later, color: Global.texto),
                  ),
                  Container(
                    child: Text(
                      data.hour.toString() + ':' + data.minute.toString(),
                      style: TextStyle(color: Global.texto, fontSize: 20),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Icon(Icons.person, color: Global.texto),
                  ),
                  FutureBuilder(
                      future: evento.get().then((value) {
                        return value.size;
                      }),
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.data.toString() + '/' + t_vagas.toString(),
                          style: TextStyle(color: Global.texto, fontSize: 20),
                        );
                      }),
                ],
              ),

              if (insc_estado == "Abertas") ...[
                Column(
                  children: [
                    // CONTAINER BOTOES
                    FutureBuilder(
                        future: CRUDFirestore()
                            .Conferir_Inscricao(Global.UserUid, id_evento),
                        builder: (context, AsyncSnapshot value) {
                          if (value.data.toString() == 'true') {
                            //CRUDFirestore().Me_Desinscrever(Global.UserUid, id_evento,context);
                            return Container(
                              //botao
                              padding: EdgeInsets.all(5),
                              height: 70,
                              width: 330,

                              child: RaisedButton(
                                textTheme: ButtonTextTheme.normal,
                                child: Text('Cancelar Inscrição',
                                    style: TextStyle(color: Global.texto1)),
                                onPressed: () {
                                  CRUDFirestore().Me_Desinscrever(
                                      Global.UserUid, id_evento, context);
                                },
                                color: Global.cor_botao_atencao,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(
                                        color: Global.cor_botao_atencao)),
                              ),
                            );
                          } else {
                            return Container(
                              //botao
                              padding: EdgeInsets.all(5),
                              height: 70,
                              width: 330,

                              child: RaisedButton(
                                textTheme: ButtonTextTheme.normal,
                                child: Text('Inscrever outra pessoa',
                                    style: TextStyle(color: Colors.black)),
                                onPressed: () {
                                  Future(() {
                                    setState(() {
                                      CRUDFirestore().Me_inscrever(
                                          id_evento, Global.UserUid, context);
                                    });
                                  });
                                },
                                color: Global.fundo,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(
                                        color: Global.cor_botao_principal)),
                              ),
                            );
                          }
                        }),
                    Container(
                      //botao
                      padding: EdgeInsets.all(5),
                      height: 70,
                      width: 330,

                      child: RaisedButton(
                        textTheme: ButtonTextTheme.normal,
                        child: Text('Inscrever outra pessoa',
                            style: TextStyle(color: Colors.black)),
                        color: Global.fundo,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side:
                                BorderSide(color: Global.cor_botao_principal)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (contexto) =>
                                      Inscrever_Visitas(id: id_evento)));
                        },
                      ),
                    ),
                  ],
                )
              ] else ...[
                Text(
                  'Inscrições ' + insc_estado.toString(),
                  style: TextStyle(color: Global.texto, fontSize: 30),
                ),
              ]
              // fim if
            ])));
  }
}
