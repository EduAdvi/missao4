import 'dart:convert';
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
import 'package:missao_4/Back/save_config.dart';
import 'package:missao_4/Telas/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

//cores
Color principal = Color.fromARGB(255, 46, 43, 43);
Color secundaria =Color.fromARGB(255, 68, 68, 68);
Color terciaria = Colors.purple;
Color cor_botao_principal = Colors.black;
Color cor_botao_atencao = Colors.red;
Color texto = Colors.black;
Color texto1 = Colors.white;
Color fundo = Color.fromARGB(255, 255, 255, 255);
//
Future<Widget> start() async{
  print('teste');
  if (debug == true){
    Username = 'Eduardo';
    UserUid = 'XwRik0lQOwawQYsT2stTd6e80HW2';
    //Carregar_eventos();
   return Tela_Principal();
  }
  else{
   return Splash_Screen(); 
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