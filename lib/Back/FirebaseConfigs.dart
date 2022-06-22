import 'dart:io';
import 'dart:async';
import 'dart:math' as Math;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:missao_4/Telas/feed_screen.dart';
import 'package:missao_4/Telas/home_screen.dart';
import 'package:missao_4/Telas/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:missao_4/Back/global.dart' as Global;

class AutenticarComFirebase{
  
  Future criar_conta(email,c_email, senha,c_senha,nome,data_n,contexto) async{
   var mensagem = '';
   var senha_text = senha.toString();
  if (email == ''  || c_email == ''  || senha == '' || c_senha == ''){
     ScaffoldMessenger.of(contexto).showSnackBar(const SnackBar(
          content: Text('Preencha todos os campos'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
     ));
  }
   else if(senha != c_senha){ 
          ScaffoldMessenger.of(contexto).showSnackBar(const SnackBar(
          content: Text('A confirmação de senha está diferente da senha'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ));
     }
    else if(senha_text.length < 8){
          ScaffoldMessenger.of(contexto).showSnackBar(const SnackBar(
          content: Text('A senha deve ter no minimo 8 caracteres'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ));
      }
    else if(email != c_email){
          ScaffoldMessenger.of(contexto).showSnackBar(const SnackBar(
          content: Text('A confirmação de email está diferente do email'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ));
    }
    else if (nome == ''){
          ScaffoldMessenger.of(contexto).showSnackBar(const SnackBar(
          content: Text('Insira seu nome, ele é muito lindo pra ficar de fora :D'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ));
    }
    else if (data_n == null){
          ScaffoldMessenger.of(contexto).showSnackBar(const SnackBar(
          content: Text('Insira sua data de aniversario, sempre preparamos algo especial pra você :D'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ));
    }
    else{
              //
try{
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.toString(), password: senha.toString()).then((value)async{

                      Global.UserUid = value.user!.uid;
                      print(value.user!);
                    await FirebaseFirestore.instance
                      .collection('Usuarios_data')
                      .doc(value.user!.uid)
                      .set({
                      'Nome': nome,
                      'Email': email,
                      'aniversario': data_n,
                      'backstage_account': false,
                  
                  }).then((value) {
                      
                      mensagem = 'Conta criada com sucesso';
                      Navigator.pop(contexto);
                      ScaffoldMessenger.of(contexto).showSnackBar(const SnackBar(
                        content: Text('Usuario criado, Agora entre com sua conta'),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.green,
                      ));

                  }).catchError((erro){
                    print(erro);
                    ScaffoldMessenger.of(contexto).showSnackBar( SnackBar(
                        content: Text('Houve um Erro:'+erro),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.green,
                      ));
                  });

              }).catchError((erro){
                if (erro.code == 'email already in use') {
                  mensagem = 'Este email já está em uso';
                    ScaffoldMessenger.of(contexto).showSnackBar( const SnackBar(
                      content: Text('Este email já está em uso'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.red,
                  ));
                } else {

                  var mensagem = 'Erro: ' + erro.message;
                    ScaffoldMessenger.of(contexto).showSnackBar( SnackBar(
                    content: Text('Erro:' + mensagem),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.red,
                  ));
                }
              });
              } catch(e){
                mensagem = e.toString();

              }
              //
    }
  }

  Future login(email, senha,contexto) async{
    CRUDFirestore().Gerar_id();

   try{
   await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: senha).then((value){
        Global.UserUid = value.user!.uid;
        //Username = 
        DocumentReference Userdata_read = FirebaseFirestore.instance.collection('Usuarios_data').doc(Global.UserUid);

        Userdata_read.get().then((value){
            Global.Username = value.get('Nome').toString();
           print( Global.Username);
           print( Global.UserUid);

        Navigator.pushAndRemoveUntil(contexto,  MaterialPageRoute(builder: (contexto) => const Tela_Principal()),ModalRoute.withName('/'));
        ScaffoldMessenger.of(contexto).showSnackBar(const SnackBar(
          content: Text('Login efetuado com sucesso'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ));
        });
       
    
    }).catchError((erro){
      var mensagem = "";
      if (erro.code == 'user-not-found'){mensagem = 'ERRO: Usuário não encontrado.';
       ScaffoldMessenger.of(contexto).showSnackBar(const SnackBar(
          content: Text('ERRO: Usuário não encontrado.'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ));
      }else if (erro.code == 'wrong-password'){mensagem = 'ERRO: Senha incorreta.';
       ScaffoldMessenger.of(contexto).showSnackBar(const SnackBar(
          content: Text('ERRO: Senha incorreta.'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ));
      }else if (erro.code == 'invalid-email'){mensagem = 'ERRO: Email inválido.';
       ScaffoldMessenger.of(contexto).showSnackBar(const SnackBar(
          content: Text('ERRO: Email inválido.'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ));
      }else{ mensagem = 'ERRO: ${erro.message}';
         ScaffoldMessenger.of(contexto).showSnackBar(const SnackBar(
          content: Text('ERRO: entre em contato com o suporte'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ));
      }
      
      return mensagem;
      
    });
   }
   catch(e){
    print(e);
      ScaffoldMessenger.of(contexto).showSnackBar(const SnackBar(
          content: Text('Erro de conexão com o servidor'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ));
   }

   
  }

  Future recuperar_senha(email,contexto) async{
   if (email == ''){
       ScaffoldMessenger.of(contexto).showSnackBar( const SnackBar(
            content: Text('Insira pelomenos o email para enviarmos a recuperação de senha'),
            duration: Duration(seconds: 2),
             backgroundColor: Colors.red,
       ));
   }
   else{
     FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
        ScaffoldMessenger.of(contexto).showSnackBar(  SnackBar(
            content: Text('Email de recuperação de senha enviado'),
            duration: Duration(seconds: 2),
             backgroundColor: Colors.green,
       ));
     }).catchError((erro){
        ScaffoldMessenger.of(contexto).showSnackBar(  SnackBar(
            content: Text('Erro: '+erro),
            duration: Duration(seconds: 2),
             backgroundColor: Colors.red,
       ));
     });
   }
 }
 
}

class CRUDFirestore{
  Future Marcar_evento(nome,link,vagas,data,context) async{
   var contexto = context;
   var mensagem;
                 await  FirebaseFirestore.instance.collection('Eventos').get().then((value)async{
      Global.id = (value.size.toInt() + 1).toString()+':'+ DateTime.now().year.toString()+':'+ DateTime.now().month.toString()+':'+ DateTime.now().day.toString()+':'+TimeOfDay.now().hour.toString()+':'+TimeOfDay.now().minute.toString();
       print(Global.id);
         await FirebaseFirestore.instance
                      .collection('Eventos')
                      .doc(nome).set({
                      'Nome': nome,
                      'Imagem': link,
                      'vagas': vagas,
                      'data': data.toString(),
                      'id': Global.id
                  
                  }).then((value) async{
                      
                      Navigator.pop(contexto);
                      ScaffoldMessenger.of(contexto).showSnackBar(const SnackBar(
                        content: Text('Evento marcado com sucesso'),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.green,
                      ));

                       await FirebaseFirestore.instance
                      .collection('Eventos_Log')
                      .doc(Global.id).collection('Data').doc('Info').set({
                          'Nome': nome,
                      'Imagem': link,
                      'vagas': vagas,
                      'data': data.toString(),
                      'id': Global.id
                      }).then((value) {
                         }).catchError((erro){
                          print(erro);
                          ScaffoldMessenger.of(contexto).showSnackBar( SnackBar(
                          content: Text('Houve um Erro:'+erro),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.green,
                      ));
                         });
                  }).then((value) {
                  }).catchError((erro){
                    print(erro);
                    ScaffoldMessenger.of(contexto).showSnackBar( SnackBar(
                        content: Text('Houve um Erro:'+erro),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.green,
                      ));
                  });
    }).catchError((erro){
                 ScaffoldMessenger.of(contexto).showSnackBar( SnackBar(
                        content: Text('Houve um Erro:'+erro),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.green,
                      ));
    });
                  
   
 }

  Future Me_inscrever(id_evento,uid,context)async{//Refazer ESTA MUITO LENTO

    await FirebaseFirestore.instance.collection('Eventos_Log').doc(id_evento).collection('Data').doc('Inscritos').collection('Nomes').doc(uid).set({
             'nome': Global.Username,
             "inscrito_por":"si mesmo",
             'id': Global.UserUid,
             'cadastro':true,
             'primeira_vez':false
  }).then((value) {
                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Você foi inscrito'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green));
  });
  
  }

  Future Inscrever_Visita(id_evento,uid,nome_visita,primeira_vez,context)async{//Refazer ESTA MUITO LENTO

    await FirebaseFirestore.instance.collection('Eventos_Log').doc(id_evento).collection('Data').doc('Inscritos').collection('Nomes').doc(uid+':::'+nome_visita).set({
             'nome':nome_visita,
             "inscrito_por":Global.Username,
             'id': Global.UserUid,
             'cadastro':true,
             'primeira_vez':primeira_vez
  }).then((value) {
                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Visita Inscrita'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green));
  });
  
  }

  Future Me_Desinscrever(pessoa,id_evento,context) async{
     var evento = await FirebaseFirestore.instance.collection('Eventos_Log').doc(id_evento).collection('Data').doc('Inscritos').collection('Nomes').doc(pessoa).delete().then((value) => {
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Inscrição cancelada'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red))
     });
  }

  Future Gerar_id() async{

     await  FirebaseFirestore.instance.collection('Eventos').get().then((value){
      Global.id = (value.size.toInt() + 1).toString()+':'+ DateTime.now().year.toString()+':'+ DateTime.now().month.toString()+':'+ DateTime.now().day.toString()+':'+TimeOfDay.now().hour.toString()+':'+TimeOfDay.now().minute.toString();
       print(Global.id);
    });
    print(Global.id);
    return Global.id;
}

  Future<bool> Conferir_Inscricao(pessoa,id_evento) async{
    var evento = await FirebaseFirestore.instance.collection('Eventos_Log').doc(id_evento).collection('Data').doc('Inscritos').collection('Nomes').get();
    print('inscritos para o evento clicado('+id_evento+'):');
    var tem = false;
    for(var doc in evento.docs){
      print('   - '+doc.reference.id.toString());
      if(doc.reference.id.toString() == pessoa.toString()){
        tem = true;
        break;
      }
    }
    if(tem == true){
      print(' - tem');
      return true;
    }
    else{
      print(' - nao tem');
      return false;
    }
  }

  Future<int> Calcular_vagas(id_evento) async{
    //var vagas = await FirebaseFirestore.instance.collection('')
    var evento = await FirebaseFirestore.instance.collection('Eventos_Log').doc(id_evento).collection('Data').doc('Inscritos').collection('Nomes').get();
    //print(evento.size);
    return evento.size;
  }

}

class GoogleCloud{
  Future EnviarImagem(file) async{
     var referencia = "eventos/"+file.toString();
     final  firebaseStorageRef = await FirebaseStorage.instance
          .ref()
          .child(referencia);

      //MANDAR PRO FIREBASE
      if(file != null){
        try{
         firebaseStorageRef.putFile(file).then((p0) => {
            get_link(referencia)
         });  
         }catch(e){
          print('Erro no upload para o firebase storage:');
          print('     - '+e.toString());
        }
      }
  }

  Future<String> get_link(referencia) async{
    var link = await FirebaseStorage.instance.ref(referencia).getDownloadURL();
    Global.imagem_provisoria = link;
    return link;
  }

}
