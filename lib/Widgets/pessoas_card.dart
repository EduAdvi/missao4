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

class Pessoas_Card extends StatefulWidget {
  final item;
  const Pessoas_Card({Key? key, this.item}) : super(key: key);

  @override
  State<Pessoas_Card> createState() => _Pessoas_CardState();
}

class _Pessoas_CardState extends State<Pessoas_Card> {
  @override
  Widget build(BuildContext context) {
    String nome = widget.item.data()['Nome'];
    String email = widget.item.data()['Email'];
    Timestamp data1 = widget.item.data()['aniversario'];
    DateTime data = data1.toDate();
    print(nome + ':' + email + ':' + data.toString());

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
              Text(
                nome,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              Text(
                email,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 2, 0),
                    child: Icon(
                      Icons.cake,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    child: Text(
                      data.day.toString() +
                          '/' +
                          data.month.toString() +
                          '/' +
                          data.year.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ])));
  }
}
