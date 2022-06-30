

import 'package:firebase_core/firebase_core.dart';

//import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:missao_4/Telas/feed_screen.dart';
import 'package:missao_4/Telas/home_screen.dart';
import 'package:missao_4/Telas/login_screen.dart';
import 'package:missao_4/Back/global.dart' as Global;


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  

  await Firebase.initializeApp();
  runApp(
    
    MaterialApp(
      //localizationsDelegates: Applo,
      title: 'Missão 4',
        localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
         GlobalWidgetsLocalizations.delegate
      ],
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blueGrey,
          iconTheme: IconThemeData(
            color: Global.principal,
          ),

        ),
      supportedLocales: [const Locale('pt','BR')],
      home: await Global.start(),
      debugShowCheckedModeBanner: false,
    )
  );
}