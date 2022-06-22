import 'dart:async';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:missao_4/Back/FirebaseConfigs.dart';
import 'package:missao_4/Back/global.dart' as Global;
import 'package:missao_4/Telas/Evento_Add.dart';
import 'package:missao_4/Telas/home_screen.dart';
import 'package:missao_4/Telas/inscrever_visita.dart';


class Evento_Config_Card extends StatefulWidget {
  final item;
  final chave;
  const Evento_Config_Card({ Key? key, this.item,this.chave }): super(key: key);

  @override
  State<Evento_Config_Card> createState() => _Evento_Config_CardState();
}

class _Evento_Config_CardState extends State<Evento_Config_Card> {
  @override
  Widget build(BuildContext context){
    
  
  String inscrito_b;
  String titulo = widget.item.data()['Nome'];
  String vagas = widget.item.data()['vagas'];
  DateTime data = DateTime.parse(widget.item.data()['data'].toString());
  String link = widget.item.data()['Imagem'];
  String id = widget.item.data()['id'];
  var t_vagas = vagas;
  String t_botao = 'teste';
  Color cor_botao;
  var eu_inscrito = widget.chave;
  print('OIA: '+eu_inscrito.toString());

    if (eu_inscrito == false){
       inscrito_b = 'Confirmar presença';
       cor_botao = Colors.blue;
       print('Voce nao esta escrito para:' + titulo);
    }
    else if (eu_inscrito == true){
       inscrito_b = 'Cancelar inscricão';
       cor_botao = Colors.red;
       print('Voce esta escrito para:' + titulo);
    }
    else{
       inscrito_b = 'Inscriçoes pausadas';
       cor_botao = Colors.orange;
       //print('Voce esta escrito para:' + titulo);
    }

     return ListTile(
      title: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.purple,borderRadius: BorderRadius.circular(30), ),
     // width: 450,
     // height: 440,
      child: Column(
        children: [
          Text(titulo,style: TextStyle(color: Colors.white, fontSize: 25),),
          
          Row(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Container( padding: EdgeInsets.fromLTRB(10,0,2,0), child: Icon(Icons.calendar_month,color: Colors.white,),),
            Container(child: Text(data.day.toString()+'/'+data.month.toString()+'/'+data.year.toString(),style: TextStyle(color: Colors.white, fontSize: 20),),),
          

            Container(padding: EdgeInsets.fromLTRB(10,0,2,5), child: Icon(Icons.watch_later,color: Colors.white),),
            Container(child: Text(data.hour.toString()+':'+data.minute.toString(),style: TextStyle(color: Colors.white, fontSize: 20),),),
          
            Container(padding: EdgeInsets.fromLTRB(10,0,2,5), child: Icon(Icons.person,color: Colors.white),),
            FutureBuilder(
              future: CRUDFirestore().Calcular_vagas(id),
              builder: (context,AsyncSnapshot snapshot){
                Timer.periodic(Duration(minutes: 120),(tempo){
                  try{
                      setState(() {});
                  }catch(e){
                    print(e);
                  }
                  
                } );
                return Container(
                  
                  child: Text(snapshot.data.toString()+'/'+t_vagas.toString(),style: TextStyle(color: Colors.white, fontSize: 20),)
                
                );
              })
          ],),
         
          Container(child: Image.network(link.toString(),height:350,),),
           FutureBuilder(
                future: CRUDFirestore().Conferir_Inscricao(Global.UserUid, id),
                builder: (context,AsyncSnapshot value){
                if(value.data.toString() == 'true'){
                  return  Container( //botao
                padding: EdgeInsets.all(5),
                height: 70,
                width: 330,

                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                   
                          CRUDFirestore().Me_Desinscrever(Global.UserUid, id,context);
                        
                          //Navigator.push(context, MaterialPageRoute(builder: (contexto) => const Tela_Principal()));
                      });
                     //Navigator.push(context,  MaterialPageRoute(builder: (contexto) => const Tela_Principal()));
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
                    child: Text('Cancelar Inscrição',style: TextStyle(color: Colors.black),),
                  ),
              );
                }
                else{
                return  Container( //botao
  
                padding: EdgeInsets.all(5),
                height: 70,
                width: 330,

                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                   
                          
                          Future(() { setState(() {CRUDFirestore().Me_inscrever(id, Global.UserUid, context);}); });
                          //Navigator.push(context, MaterialPageRoute(builder: (contexto) => const Tela_Principal()));
                       
                          //Navigator.push(context, MaterialPageRoute(builder: (contexto) => const Tela_Principal()));
                      });
                     //Navigator.push(context,  MaterialPageRoute(builder: (contexto) => const Tela_Principal()));
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
                    child: Text('Fazer Inscrição',style: TextStyle(color: Colors.black),),
                  ),
              );
                }
                }
                
                ),
          Container( //botao
                padding: EdgeInsets.all(5),
                height: 70,
                width: 330,
               
                child: ElevatedButton(
                    onPressed: () {
                       Global.evento_provisorio = id;
                         Navigator.push(context,  MaterialPageRoute(builder: (contexto) => const Visita_Add()));
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
                    child: Text('Inscrever uma visita',style: TextStyle(color: Colors.black),),
                    
                  ),
              ),
      
             
                
              
                
          
        ]))
        );
  }
}