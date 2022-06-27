import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:missao_4/Telas/feed_screen.dart';
import 'package:missao_4/Telas/home_screen.dart';
import 'package:missao_4/Telas/login_screen.dart';
import 'package:missao_4/Back/FirebaseConfigs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ini/ini.dart';


import 'package:image_picker/image_picker.dart';

//import 'package:firebase_core/firebase_firestore.dart';

var nome = 'Missão 4';
var debug = false;
var backstage_account = false;
var UserUid;
var Username;
var borda = 10;
var g_snapshots;
var data_t = 'Defina a data e hora';
var data_final = DateTime.now().toString();
var id;
var imagem_provisoria;
var arquivo_imagem;
var evento_provisorio;

Widget start(){
  print('teste');
  if (debug == true){
    Username = 'Eduardo';
    UserUid = 'XwRik0lQOwawQYsT2stTd6e80HW2';
    //Carregar_eventos();
   return Tela_Principal();
  }
  else{
    return Login_Screen();
  }
}

Future<File> Pegar_imagem() async{
    final ImagePicker picker = ImagePicker();
     final XFile? pickedfile = await picker.pickImage(source: ImageSource.gallery);
     File file = File(pickedfile!.path);
     GoogleCloud().EnviarImagem(file);
     arquivo_imagem = file;
     return file;
}

void Ler_INI() {
  var email;
  var senha;
 
  print('ler ini');
  new File("config.ini").readAsLines()
    .then((lines) => new Config.fromStrings(lines))
    .then((Config config) => {
      email = config.get("conta", "email"),
      senha = config.get("conta", "senha"),
      print(email+senha)
    }).catchError((erro){
      print(erro.toString());
    });
}

void Gravar_ini(email,senha){
  print('Gravar ini');
  var config = File(''); 
}