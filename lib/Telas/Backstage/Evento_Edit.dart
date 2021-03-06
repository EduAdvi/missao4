import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:missao_4/Back/FirebaseConfigs.dart';
import 'package:missao_4/Telas/feed_screen.dart';
import 'package:missao_4/Telas/home_screen.dart';
import 'package:missao_4/Telas/login_screen.dart';
import 'package:missao_4/Back/global.dart' as Global;
import 'package:image_picker/image_picker.dart';

class Evento_Edit extends StatefulWidget {
  final id;
  final titulo;
  final vagas;
  final data;
  final imagem;
  final visivel;
  final insc_estado;
  final presencas_finais;
  
  const Evento_Edit({ Key? key,this.id,this.titulo,this.vagas,this.data,this.imagem,this.visivel,this.insc_estado,this.presencas_finais}) : super(key: key);

  @override
  State<Evento_Edit> createState() => _Evento_EditState();
}

class _Evento_EditState extends State<Evento_Edit> {
  
  Future Pegar_imagem_galeria() async{
    final ImagePicker picker = ImagePicker();
     final XFile? pickedfile = await picker.pickImage(source: ImageSource.gallery);
     File file = File(pickedfile!.path);
     link_imagem = GoogleCloud().EnviarImagem(file);
     setState(() {
       imagem_arquivo =  File(pickedfile.path);
     });
     

}

  @override
  var link_imagem;
  var TextoNome = TextEditingController();
  var TextoSenha = TextEditingController();
  var TextoCSenha = TextEditingController();
  var TextoEmail = TextEditingController();
  var TextoCEmail = TextEditingController();
  var Text_presencas_totais = TextEditingController();
  var imagem_arquivo;
  var imagem_link;
  bool? checkedValue = false;
  String dropdownValue = 'Abertas';

  var memoria = false;

  Widget build(BuildContext context) {
    
   var  _data;
   var mexi_na_hora = false;
    TextoEmail.text = widget.titulo.toString();
    TextoCSenha.text = widget.vagas;
    imagem_link = widget.imagem;
    if(imagem_link == null){
      imagem_link = '';
    }

    
    
  if(memoria == false){
    checkedValue = widget.visivel;
    dropdownValue = widget.insc_estado;
    Global.data_t = widget.data.toString();
    Global.data_final = widget.data.toString();
    Text_presencas_totais.text = widget.presencas_finais.toString();
    memoria = true;
  }
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Marcar Evento'),
        centerTitle: true,
        backgroundColor: Global.principal,
      ),
      body: SingleChildScrollView(
       // scrollDirection: ScrollDirection.idle,
        child: Column(
        children:[
          Container(
          child:  Column(
            
            children: [
              
              Container(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: TextField(
                  controller: TextoEmail,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome do evento',
                  ),
                ),
              ),
              
         
              Container(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: TextField(
                  controller: TextoCSenha,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    
                    labelText: 'Numero de vagas',
                    
                  ),
                ),
              ),
        
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                 Container(
                 
                padding: EdgeInsets.fromLTRB(5,5,5,5),
                height: 70,
                width: 100,
                //alignment: Alignment.centerLeft, //botao
                child: ElevatedButton(
                  
                    onPressed: () async{
                    
                        _data = await showDatePicker(
                          context: context, 
                          initialEntryMode: DatePickerEntryMode.input,
                        
                 builder: (context, child) {
                   return Theme(
                          data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: Global.principal, // header background color
                          onPrimary: Colors.white, // header text color
                          onSurface: Colors.black, // body text color
                        ),
                       
                      ),
                      child: child!,
                    );
                    
                  },
                        
                          //locale:  const Locale('es','ES'),
                          fieldLabelText: 'Informe o dia do evento',
                          //locale: Locale('pt','BR'),
                          helpText: 'Informe o dia do evento',
                           initialDatePickerMode: DatePickerMode.day,
                          initialDate: DateTime.now(), 
                          firstDate: DateTime.now(), 
                          lastDate: DateTime(2100)
                          );  
                          print(_data);
                          
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Global.principal)),
                    child: Text('Data'),
                  ),
              ),
          Container( //botao
                padding: EdgeInsets.all(5),
                height: 70,
                width: 100,

                child: ElevatedButton(
                    onPressed: () async{
                        if(_data == null){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Selecione a data primeiro'),
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.green,
                          ));
                      }
                      else{
                     var _hora;
                    _hora = await showTimePicker(
                          context: context, 
                         // initialEntryMode: DatePickerEntryMode.input,
                 builder: (context, child) {
                   
                   return Theme(
                          data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: Global.principal, // header background color
                          onPrimary: Colors.white, // header text color
                          onSurface: Colors.black, // body text color
                        ),
                       
                      ),  
                      child: child!,
                    );
                  },
                 initialTime: TimeOfDay.now(),
                          ); 
                          print(_hora.format(context));
                          if(_data != null){
                           DateTime datosa = DateTime.parse(_data.toString());
                          String data_t;
                          String dia;
                          String mes;
                          if(datosa.month.toInt() < 10){
                              mes = '0'+datosa.month.toString();
                          }
                          else{
                            mes  = datosa.month.toString();
                          }

                          if(datosa.day.toInt() < 10){
                              dia = '0'+datosa.day.toString();
                          }
                          else{
                            dia  = datosa.day.toString();
                          }
                          
                            data_t = datosa.year.toString()+'-'+
                                mes+'-'+
                               dia+' '+
                                _hora.format(context).toString()+':00';
                                print(data_t.toString()+' DATA T');

                                try{
                                _data = DateTime.parse(data_t.toString());
                                setState(() {
                                  Global.data_t = _data.toString();
                                });
                                  
                                }
                                catch(e){
                                  print('Erro: '+e.toString());
                                }
                                print(_data);
                             
                          }
                             
                          Global.data_final = _data.toString();
                          print(Global.data_final);
                          }
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Global.principal)),
                    child: Text('Hora'),
                  ),
              ),
              ],),

               Text('Data e hora do evento: '+ Global.data_t),

              if (imagem_arquivo == null) Container(
                child: Container(
                    width: 300,
                    height: 300,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(30)
                        ),
                      child:  Column(children: [
                          Image.network(imagem_link,width: 300,height: 300 ),
                          //Text(imagem_arquivo)
                      ],),                  

                  )
                 ),
                if (imagem_arquivo!= null) Container(
                child: Container(
                    width: 300,
                    height: 300,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(30)
                        ),
                      child: Column(children: [
                          Image.file(imagem_arquivo,width: 300,height: 300 ),
                          //Text(imagem_arquivo)
                      ],)  //AssetImage(imagem_arquivo.toString(),package: 'lib')      

                  )
                 ),  
              
              

              Container( //botao
                padding: EdgeInsets.all(5),
                height: 70,
                width: 200,
               
                child: ElevatedButton(
                    onPressed: () {
                        Pegar_imagem_galeria();
                     
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Global.principal)),
                    child: Text('Selecionar imagem'),
                  ),
              ),          
          
             Container( //botao
                padding: EdgeInsets.all(5),
                height: 80,
                width: 400,
               
                child: CheckboxListTile(
                  title: Text("Visivel"),
                  subtitle: Text("Fica visivel no feed dos membros"),
                      value: checkedValue,
                      onChanged: (newValue) {
                          setState(() {
                          checkedValue = newValue;
                          print(checkedValue);
                        });
                        },
                        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                      )
              ),   
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text('Estado das inscri??oes: '),
         Container(child: DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 20,
            style:  TextStyle(color: Global.principal),
            underline: Container(
              height: 5,
              color: Global.principal,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: <String>['Abertas', 'Fechadas', 'Em Breve', 'Esgotadas']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
     ),
      ],),
        
              Container(
                width: 200,
                padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: TextField(
                  controller: Text_presencas_totais,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Presen??as Finais',
                  ),
                ),
              ),
              Container( //botao
                padding: EdgeInsets.all(5),
                height: 70,
                width: 200,
               
                child: ElevatedButton(
                    onPressed: () {
                      if (Global.imagem_provisoria ==  null){
                           CRUDFirestore().Editar_evento(widget.id,TextoEmail.text,widget.imagem, TextoCSenha.text, Global.data_final,checkedValue,dropdownValue.toString(),Text_presencas_totais.text, context);
                     
                      }
                      else{
                         CRUDFirestore().Editar_evento(widget.id,TextoEmail.text, Global.imagem_provisoria, TextoCSenha.text, Global.data_final,checkedValue,dropdownValue.toString(),Text_presencas_totais.text, context);
                     
                      
                      }
                      //(nome,link,vagas,data,context)
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
                    child: Text('Salvar'),
                  ),
              ),
             
             
              
          ],)),
           
        ], 
      ),
     // bottomSheet:  Text(' @Powered by IEQ Barrinha', textAlign: TextAlign.center,)       
    ));
  }
 
}
 
