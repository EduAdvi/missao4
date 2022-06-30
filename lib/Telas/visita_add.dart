import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:missao_4/Back/FirebaseConfigs.dart';
import 'package:missao_4/Telas/feed_screen.dart';
import 'package:missao_4/Telas/home_screen.dart';
import 'package:missao_4/Telas/login_screen.dart';
import 'package:missao_4/Back/global.dart' as Global;
import 'package:image_picker/image_picker.dart';

//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_auth_web/firebase_auth_web.dart';

class Visita_Add extends StatefulWidget {
  final id;
  const Visita_Add({Key? key, this.id}) : super(key: key);
  @override
  State<Visita_Add> createState() => _Visita_AddState();
}

enum Tipo_Pessoa { membro, visita, primeira_vez }

var Tipo_Pessoa_Final = 'Membro';

class _Visita_AddState extends State<Visita_Add> {
  Tipo_Pessoa? _character = Tipo_Pessoa.membro;

  @override
  var link_imagem;
  var TextoNome = TextEditingController();
  var TextoSenha = TextEditingController();
  var TextoCSenha = TextEditingController();
  var TextoEmail = TextEditingController();
  var TextoCEmail = TextEditingController();

  bool? checkedValue = false;
  var imagem_arquivo;
  var memoria = false;

  Widget build(BuildContext context) {
    var _data;

    return Scaffold(
        appBar: AppBar(
          title: Text('Inscrever Pessoa'),
          centerTitle: true,
          backgroundColor: Global.principal,
        ),
        body: SingleChildScrollView(
          // scrollDirection: ScrollDirection.idle,
          child: Column(
            children: [
              Container(
                  child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                    child: TextField(
                      controller: TextoNome,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nome da Pessoa',
                      ),
                    ),
                  ),

//
                  Container(
                    width: 300,
                    //alignment: Alignment.center,
                    child: ListTile(
                      title: const Text('Membro'),
                      subtitle: Text(
                          'Selecione esta opção se você esta inscrevendo uma pessoa que já é batizada na igreja'),
                      leading: Radio<Tipo_Pessoa>(
                        value: Tipo_Pessoa.membro,
                        groupValue: _character,
                        onChanged: (Tipo_Pessoa? value) {
                          setState(() {
                            _character = value;
                            Tipo_Pessoa_Final = 'Membro';
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    //alignment: Alignment.center,
                    child: ListTile(
                      title: const Text('Visita'),
                      subtitle: Text(
                          'Selecione esta opção se você esta inscrevendo uma pessoa que ainda não é batizada na igreja'),
                      leading: Radio<Tipo_Pessoa>(
                        value: Tipo_Pessoa.visita,
                        groupValue: _character,
                        onChanged: (Tipo_Pessoa? value) {
                          setState(() {
                            _character = value;
                            Tipo_Pessoa_Final = 'Visita';
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    //alignment: Alignment.center,
                    child: ListTile(
                      title: const Text('Primeira Vez'),
                      subtitle: Text(
                          'Selecione esta opção se você esta inscrevendo uma pessoa que esta indo pela primeira vez na igreja'),
                      leading: Radio<Tipo_Pessoa>(
                        value: Tipo_Pessoa.primeira_vez,
                        groupValue: _character,
                        onChanged: (Tipo_Pessoa? value) {
                          setState(() {
                            _character = value;
                            Tipo_Pessoa_Final = 'Primeira Vez';
                          });
                        },
                      ),
                    ),
                  ),

                  //
                  Container(
                    //botao
                    padding: EdgeInsets.all(10),
                    height: 70,
                    width: 200,

                    child: RaisedButton(
                      textTheme: ButtonTextTheme.normal,
                      child: Text('Inscrever Pessoa',
                          style: TextStyle(color: Global.texto1)),
                      color: Global.principal,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: Global.principal)),
                      onPressed: () {
                        CRUDFirestore().Inscrever_Visita(
                            widget.id.toString(),
                            Global.UserUid,
                            TextoNome.text,
                            Tipo_Pessoa_Final,
                            context);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              )),
            ],
          ),
          // bottomSheet:  Text(' @Powered by IEQ Barrinha', textAlign: TextAlign.center,)
        ));
  }
}
