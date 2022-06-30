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
import 'package:missao_4/Telas/Backstage/Pessoas_Evento_screen.dart';
import 'package:missao_4/Telas/home_screen.dart';
import 'package:missao_4/Telas/visita_add.dart';

class Evento_Config_Card extends StatefulWidget {
  final item;
  final chave;
  const Evento_Config_Card({Key? key, this.item, this.chave}) : super(key: key);

  @override
  State<Evento_Config_Card> createState() => _Evento_Config_CardState();
}

class _Evento_Config_CardState extends State<Evento_Config_Card> {
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
    double y_botao = 60;
    double x_botao = 200;
    String inscrito_b;
    String titulo = widget.item.data()['Nome'];
    String vagas = widget.item.data()['vagas'];

    bool visivel = widget.item.data()['visivel'];
    String insc_estado = widget.item.data()['insc_estado'];
    String pessoas_finais = widget.item.data()['presencas_finais'];

    DateTime data = DateTime.parse(widget.item.data()['data'].toString());
    var link = widget.item.data()['Imagem'];
    String id = widget.item.data()['id'];
    var t_vagas = vagas;
    String t_botao = 'teste';
    Color cor_botao;
    var eu_inscrito = widget.chave;

    var Confirmar_deletar = TextEditingController();
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
            // width: 450,
            // height: 440,
            child: Column(children: [
              Text(
                titulo,
                style: TextStyle(color: Global.texto, fontSize: 25),
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
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Image.network(
                      link.toString(),
                      height: 150,
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        //botao
                        padding: EdgeInsets.all(5),
                        height: y_botao,
                        width: x_botao,

                        child: RaisedButton(
                          textTheme: ButtonTextTheme.normal,
                          child: Text('Editar',
                              style: TextStyle(color: Colors.black)),
                          color: Global.fundo,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(
                                  color: Global.cor_botao_principal)),
                          onPressed: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (contexto) => Evento_Edit(
                                            id: id,
                                            titulo: titulo,
                                            vagas: vagas,
                                            data: data,
                                            imagem: link,
                                            visivel: visivel,
                                            insc_estado: insc_estado,
                                            presencas_finais: pessoas_finais,
                                          )));
                            });
                            //Navigator.push(context,  MaterialPageRoute(builder: (contexto) => const Tela_Principal()));
                          },
                        ),
                      ),
                      Container(
                        //botao
                        padding: EdgeInsets.all(5),
                        height: y_botao,
                        width: x_botao,

                        child: RaisedButton(
                          textTheme: ButtonTextTheme.normal,
                          child: Text('Relatório',
                              style: TextStyle(color: Colors.black)),
                          color: Global.fundo,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(
                                  color: Global.cor_botao_principal)),
                          onPressed: () {
                            Global.evento_provisorio = id;
                            CRUDFirestore()
                                .Gerar_Relatorio(id, pessoas_finais, context);
                          },
                        ),
                      ),
                      Container(
                        //botao
                        padding: EdgeInsets.all(5),
                        height: y_botao,
                        width: x_botao,

                        child: RaisedButton(
                          textTheme: ButtonTextTheme.normal,
                          child: Text('Inscritos',
                              style: TextStyle(color: Colors.black)),
                          color: Global.fundo,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(
                                  color: Global.cor_botao_principal)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (contexto) =>
                                        Pessoas_Evento_Screen(
                                          id: id,
                                        )));
                          },
                        ),
                      ),
                      
                      Container(
                        //botao
                        padding: EdgeInsets.all(5),
                        height: y_botao,
                        width: x_botao,

                        child: RaisedButton(
                          textTheme: ButtonTextTheme.normal,
                          child: Text('Deletar',
                              style:
                                  TextStyle(color: Global.cor_botao_atencao)),
                          color: Global.fundo,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side:
                                  BorderSide(color: Global.cor_botao_atencao)),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext ctx) {
                                  return AlertDialog(
                                    actionsAlignment: MainAxisAlignment.center,
                                    title: const Text(
                                      'Deletar Evento',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    content: const Text(
                                        'Voce perderá todos os relatorios e os inscritos do evento, não é possivel recuperar nada sobre ele depois, tem certeza que deseja continuar?'),
                                    actions: [
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(25, 10, 25, 10),
                                        child: TextField(
                                          controller: Confirmar_deletar,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText:
                                                'Digite "Deletar" para confirmar',
                                          ),
                                        ),
                                      ),
                                      Container(
                                        //botao
                                        padding: EdgeInsets.all(5),
                                        height: y_botao,
                                        width: x_botao,

                                        child: RaisedButton(
                                          textTheme: ButtonTextTheme.normal,
                                          child: Text('Cancelar',
                                              style: TextStyle(
                                                  color: Global.texto)),
                                          color: Global.fundo,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              side: BorderSide(
                                                  color: Global
                                                      .cor_botao_principal)),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                      Container(
                                        //botao
                                        padding: EdgeInsets.all(5),
                                        height: y_botao,
                                        width: x_botao,

                                        child: RaisedButton(
                                          textTheme: ButtonTextTheme.normal,
                                          child: Text('Deletar',
                                              style: TextStyle(
                                                  color: Global
                                                      .cor_botao_atencao)),
                                          color: Global.fundo,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              side: BorderSide(
                                                  color: Global
                                                      .cor_botao_atencao)),
                                          onPressed: () {
                                            if (Confirmar_deletar.text ==
                                                'Deletar') {
                                              setState(() {
                                                //
                                                  CRUDFirestore().Deletar_evento(id);
                                                //
                                              });
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text('O evento "' +
                                                    titulo.toString() +
                                                    '" foi deletado'),
                                                duration: Duration(seconds: 2),
                                                backgroundColor: Colors.red,
                                              ));
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text('Você digitou "' +
                                                    Confirmar_deletar.text +
                                                    '", em vez de "Deletar".'),
                                                duration: Duration(seconds: 2),
                                                backgroundColor: Colors.red,
                                              ));
                                            }
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ])));
  }
}
