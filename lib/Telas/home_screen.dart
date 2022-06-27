import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:missao_4/Back/global.dart' as Global;
import 'package:missao_4/Telas/Backstage/backstage_home.dart';

import 'package:missao_4/Telas/feed_screen.dart';
import 'package:missao_4/Telas/Backstage/Evento_Add.dart';

class Tela_Principal extends StatefulWidget {
  const Tela_Principal({ Key? key }) : super(key: key);

  @override
  State<Tela_Principal> createState() => _Tela_PrincipalState();

}

class _Tela_PrincipalState extends State<Tela_Principal> {
  
  @override
  
  Widget build(BuildContext context) {
    //Global.Carregar_eventos();
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) => // Ensure Scaffold is in context
            IconButton(
             
               icon: Icon(Icons.menu),
               onPressed: () => Scaffold.of(context).openDrawer()
         )),
      
        title: Text(Global.nome), backgroundColor: Colors.purple,automaticallyImplyLeading: false,
       
      ),
      body: Container(
        child: Feed() //call feed node - show stream builder constructor
      ),
      
      drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(children:[ 

              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Missão 4',
                  style: TextStyle(color: Colors.white, fontSize: 25),
            ),),
               Container(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Olá '+Global.Username+', que a paz seja convosco',
                  style: TextStyle(color: Colors.white, fontSize: 16),
            ),),
             ]),
            decoration: BoxDecoration(
                color: Colors.purple,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/preto.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Perfil'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Backstage Account'),
            onTap: () => { Navigator.push(context,  MaterialPageRoute(builder: (contexto) => const Backstage_Home()))},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configurações'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app,color: Colors.red,),
            title: Text('Deslogar',style: TextStyle(color: Colors.red),),
            onTap: () => {Navigator.of(context).pop()},
          ),
           ListTile(
            leading: Icon(Icons.exit_to_app,color: Colors.red,),
            title: Text('Gravar ini',style: TextStyle(color: Colors.red),),
            onTap: () => {
              Global.Gravar_ini('email', 'senha')
            },
          ),
           ListTile(
            leading: Icon(Icons.exit_to_app,color: Colors.red,),
            title: Text('Ler ini',style: TextStyle(color: Colors.red),),
            onTap: () => {
              Global.Ler_INI()
            },
          ),
        ],
      ),
    ) ,
    );
  }

}