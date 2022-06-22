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


import 'package:image_picker/image_picker.dart';

//import 'package:firebase_core/firebase_firestore.dart';

var nome = 'Missão 4';
var debug = true;
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
