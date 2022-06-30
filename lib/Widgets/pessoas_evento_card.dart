import 'dart:async';
import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:missao_4/Back/FirebaseConfigs.dart';
import 'package:missao_4/Back/global.dart' as Global;
import 'package:missao_4/Telas/Backstage/Evento_Add.dart';
import 'package:missao_4/Telas/Backstage/Evento_Edit.dart';
import 'package:missao_4/Telas/Backstage/Evento_Relatorio.dart';
import 'package:missao_4/Telas/home_screen.dart';
import 'package:missao_4/Telas/visita_add.dart';

class Pessoas_Evento_Card extends StatefulWidget {
  final item;
  final referencia;
  final id_evento;
  const Pessoas_Evento_Card(
      {Key? key, this.item, this.referencia, this.id_evento})
      : super(key: key);

  @override
  State<Pessoas_Evento_Card> createState() => _Pessoas_Evento_CardState();
}

class _Pessoas_Evento_CardState extends State<Pessoas_Evento_Card> {
  @override
  Widget build(BuildContext context) {
    String nome =
        widget.item.data()['nome'].toString().characters.take(15).toString();
    // nome1 = nome.characters.take(30);
    //print(nome.toString().substring(1,5));
    Timestamp data1 = widget.item.data()['momento'];
    DateTime momento = data1.toDate();
    String incscrito_por = widget.item
        .data()['inscrito_por']
        .toString()
        .characters
        .take(12)
        .toString();
    String Tipo_Pessoa_Final = widget.item.data()['Tipo_Pessoa'];

    return ListTile(
        title: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Global.principal,
              borderRadius: BorderRadius.circular(30),
            ),
            // width: 450,
            // height: 440,
            child: Column(children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: Column(
                        children: [
                          Text(
                            nome,
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          Text(
                            'Inscrito por: ' + incscrito_por,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            'Momento Inscrição:',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: Colors.white,
                                size: 16,
                              ),
                              Text(
                                momento.day.toString() +
                                    '/' +
                                    momento.month.toString() +
                                    '/' +
                                    momento.year.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.timer,
                                color: Colors.white,
                                size: 16,
                              ),
                              Text(
                                momento.hour.toString() +
                                    ':' +
                                    momento.minute.toString() +
                                    ':' +
                                    momento.second.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    //
                    Container(
                      width: 100,
                      height: 100,
                      padding: EdgeInsets.symmetric(horizontal: 1),
                      alignment: Alignment.centerRight,
                      child: FloatingActionButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('Eventos_Log')
                              .doc(widget.id_evento.toString())
                              .collection('Data')
                              .doc('Inscritos')
                              .collection('Nomes')
                              .doc(widget.referencia.toString())
                              .delete();
                        },
                        backgroundColor: Colors.transparent,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ])));
  }
}
