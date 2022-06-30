
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:missao_4/Back/FirebaseConfigs.dart';
import 'package:missao_4/Telas/feed_screen.dart';
import 'package:missao_4/Telas/home_screen.dart';
import 'package:missao_4/Telas/login_screen.dart';
import 'package:missao_4/Back/global.dart' as Global;
import 'package:pie_chart/pie_chart.dart';

class Evento_Relatorio extends StatefulWidget {
  final vagas;
  final inscritos_usuarios;
  final visitas;
  final primeira_vez;
  final pessoas_finais;
  const Evento_Relatorio({ Key? key,this.vagas,this.inscritos_usuarios,this.primeira_vez,this.visitas,this.pessoas_finais}) : super(key: key);

  @override
  State<Evento_Relatorio> createState() => _Evento_RelatorioState();
}

class _Evento_RelatorioState extends State<Evento_Relatorio> {
  


  @override
  

  Widget build(BuildContext context) {
    
  double vagas = double.parse(widget.vagas.toString());
  double inscritos_usuarios = double.parse(widget.inscritos_usuarios.toString());
  double visitas = double.parse(widget.visitas.toString());
  double primeira_vez = double.parse(widget.primeira_vez.toString());
  double sobras = vagas - (visitas+primeira_vez+inscritos_usuarios);
  double pessoas_finais = double.parse(widget.pessoas_finais.toString());
//visao geral data
   final visao_geral = <String, double>{
    "Inscritos Membros: "+inscritos_usuarios.toString(): inscritos_usuarios,
    "Inscritos Visitas: "+visitas.toString() :visitas,
    "Primeira vez: "+primeira_vez.toString(): primeira_vez,
    "Vagas Sobrando: "+sobras.toString(): sobras
  };

  final colorList_visao_geral = <Color>[
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.grey,
  ];

// membros/visitas
final membros_e_visitas = <String, double>{
    "Inscritos Membros: "+inscritos_usuarios.toString(): inscritos_usuarios,
    "Inscritos Visitas: "+(visitas+primeira_vez).toString() :visitas+primeira_vez,
  };

  final colorList_membros_e_visitas = <Color>[
    Colors.orange,
    Colors.green,
  ];

  //primeira vez
  final primeira_vez_graph = <String, double>{
    "Outros Inscritos: "+(inscritos_usuarios+visitas).toString(): inscritos_usuarios+visitas,
    "Primeira Vez: "+primeira_vez.toString() :primeira_vez,
  };

  final colorList_primeira_vez_graph = <Color>[
    Colors.red,
    Colors.green,
  ];
  //inscritos/presentes
  final inscritos_presentes_graph = <String, double>{
    "Inscritos: "+(inscritos_usuarios+visitas+primeira_vez).toString():(inscritos_usuarios+visitas+primeira_vez),
    "Presentes: "+pessoas_finais.toString() :pessoas_finais,
  };

  final colorList_inscritos_presentes_graph = <Color>[
    Colors.red,
    Colors.blue,
  ];
  //
   //inscritos/presentes_reverso
  final inscritos_presentes_reverso_graph = <String, double>{
    "Inscritos: "+(inscritos_usuarios+visitas+primeira_vez).toString():(inscritos_usuarios+visitas+primeira_vez),
    "Penetras: "+pessoas_finais.toString() : pessoas_finais,
  };

  final colorList_inscritos_presentes_reverso_graph = <Color>[
    Colors.blue,
    Colors.green,
  ];
  //
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Relatorio'),
        centerTitle: true,
        backgroundColor: Global.principal,
      ),
      body: SingleChildScrollView(child:Column(
        children: [
  
            Container( // grafico
              padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
              child: PieChart(
                centerText: 'Visão Geral',
                dataMap: visao_geral,
                chartType: ChartType.ring,
                baseChartColor: Colors.grey,
                colorList: colorList_visao_geral,
                chartValuesOptions: const ChartValuesOptions(
                  showChartValuesInPercentage: true,
                  showChartValuesOutside: true,
                  
                ),
                totalValue: vagas,
              ),
            ),//fim grafico
             Container( // grafico
              padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
              child: PieChart(
                centerText: 'Membros/Visitas',
                dataMap: membros_e_visitas,
                chartType: ChartType.ring,
                baseChartColor: Colors.grey,
                colorList: colorList_membros_e_visitas,
                chartValuesOptions: const ChartValuesOptions(
                  showChartValuesInPercentage: true,
                   showChartValuesOutside: true,
                ),
                totalValue: inscritos_usuarios+visitas+primeira_vez,
                
              ),
            ),//fim grafico
             Container( // grafico
              padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
              child: PieChart(
                centerText: 'Primeira Vez',
                dataMap: primeira_vez_graph,
                chartType: ChartType.ring,
                baseChartColor: Colors.grey,
                colorList: colorList_primeira_vez_graph,
                chartValuesOptions: const ChartValuesOptions(
                  showChartValuesInPercentage: true,
                   showChartValuesOutside: true,
                ),
                totalValue: inscritos_usuarios+visitas+primeira_vez,
                
              ),
            ),//fim grafico

            if(pessoas_finais <= (inscritos_usuarios+visitas+primeira_vez)) ...[
               Container( // grafico
              padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
              child: PieChart(
                centerText: 'Inscritos/Presentes',
                dataMap: inscritos_presentes_graph,
                chartType: ChartType.ring,
                baseChartColor: Colors.grey,
                colorList: colorList_inscritos_presentes_graph,
                chartValuesOptions: const ChartValuesOptions(
                  showChartValuesInPercentage: true,
                   showChartValuesOutside: true,
                ),
                totalValue: (inscritos_usuarios+visitas+primeira_vez),
                
              ),
            ),//fim grafico
            ]
            else ...[
                 Container( // grafico
              padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
              child: PieChart(
                centerText: 'Inscritos/Penetras',
                dataMap: inscritos_presentes_reverso_graph,
                chartType: ChartType.ring,
                baseChartColor: Colors.grey,
                colorList: colorList_inscritos_presentes_reverso_graph,
                chartValuesOptions: const ChartValuesOptions(
                  showChartValuesInPercentage: true,
                   showChartValuesOutside: true,
                ),
                totalValue: pessoas_finais,
                
              ),
            ),//fim grafico
            ]
         ],
      )
      ),
      );
  }
 
}
 
