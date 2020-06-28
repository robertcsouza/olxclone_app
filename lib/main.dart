import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olxclone_app/Detalhes.dart';
import 'package:olxclone_app/Inserir.dart';
import 'package:http/http.dart'as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color bgColor = Color(0xFFf2f2f2);
    return MaterialApp(
      title: 'OLX',
      theme: ThemeData(
        scaffoldBackgroundColor:bgColor ,
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(title: 'OLX')
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
      Color primary = Color(0xFF6d0ad6);
      Color button = Color(0xFFf18000);
      Color bgColor = Color(0xFFf2f2f2);
    @override
  void initState() {
    // TODO: implement initState
    super.initState();


    }

      Future<List> _recuperarAnuncios() async{
        String url = "http://192.168.1.5:3333/anuncios/";
        http.Response response = await http.get(url,headers: {});
        var anuncios =  json.decode(response.body);

        return anuncios['anuncios'];


      }

      Future _recuperarUsuario() async{
        String url = "http://192.168.1.5:3333/usuario/";
        http.Response response = await http.get(url,headers: {});
        var anuncios =  json.decode(response.body);

        return anuncios['anuncios'];


      }


// parte de interface
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
          child: buttomBar()
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: Colors.white,
            ),
          )
        ],

      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 100,
              child: DrawerHeader(
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                        backgroundImage:NetworkImage('https://www.oneworldplayproject.com/wp-content/uploads/2016/03/avatar-1024x1024.jpg'),
                    ), Padding(
                      padding: EdgeInsets.only(left: 32),
                      child: Column(children: <Widget>[
                        Text('Olx dos santos',style: TextStyle(color: Colors.white),),
                        Text('olx@gmail.com',style: TextStyle(color: Colors.white),),
                      ],)
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: primary,
                ),
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text('Anúcios'),
              onTap: () {
              },
              leading: Icon(Icons.photo),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Inserir Anúcio'),
              onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context)=>InserirAnucio()));
                },
            ),
            ListTile(
              leading: Icon(Icons.chat_bubble),
              title: Text('Chat'),
              onTap: () {
              },
            ),
            SizedBox(height: 30,),
            SizedBox(
              height: 1.5,
              child: Container(
                color: Colors.grey,
              ),
            ),
            ListTile(
              title: Text('Ajuda e Contato'),
              onTap: (){

              },
            ),

            ListTile(
              title: Text('Dúvidas Frequentes'),
            ),
            ListTile(
              title: Text('Dicas de Segurança'),
            ),
            ListTile(
              title: Text('Termos de uso'),
            ),
          ],
        ),
      ),
      body:
        FutureBuilder<List>(
        future: _recuperarAnuncios(),
        builder: (context,snapshot){
          String resultado;
          switch(snapshot.connectionState){

            case ConnectionState.none:
            case ConnectionState.waiting:
              print("conexao waiting");
              resultado = "Carregando...";
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              print("conexao done");
              if(snapshot.hasError){
                resultado = snapshot.error.toString();
                print('deu erro');
              }else{

                return ListView.builder(

                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index){

                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>DetalhesAnucio(anuncio: snapshot.data[index],)));

                        },
                        child: Card(
                           margin: EdgeInsets.only(left: 8, right: 8, top: 8),
                          child: SizedBox(
                            width: 200 ,
                            child: Row(

                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    child: Image.network(snapshot.data[index]['thumbnail_url']),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical:10.0),
                                      child: Text(snapshot.data[index]['titulo'],style: TextStyle(fontSize: 20,color: Color(0xFF6e6e6e)),),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical:10.0),
                                      child: Text('R\$ ${snapshot.data[index]['preco']}',style: TextStyle(fontSize: 22),),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical:10.0),
                                      child: Text('${snapshot.data[index]['data']}, ${snapshot.data[index]['bairro']}',style:TextStyle(fontSize: 12,color: Color(0xFF6e6e6e)) ,),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );

                    }
                );
              }
              break;


          }

          return Center(
            child: Text(resultado),
          );
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>InserirAnucio()));
        },

        label: Text('Anuciar Agora'),
        icon: Icon(Icons.photo_camera),
        backgroundColor: button,
      ),

    );
  }

  Column buttomBar(){
      return  Column(
        children: <Widget>[
          Container(
            color: bgColor,
            child: Padding(
              padding: const EdgeInsets.only(top:0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  Expanded(

                    child: SizedBox(
                      height: 50,
                      child: RaisedButton(
                        onPressed: (){},
                        color: Colors.white,
                        textColor: primary,
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Text('Local',style: TextStyle(fontSize: 16),),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child:SizedBox(
                      height: 50,
                      child: RaisedButton(
                        onPressed: (){},
                        color: Colors.white,
                        textColor: primary,
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Text('Categoria',style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: RaisedButton(
                        onPressed: (){},
                        color: Colors.white,
                        textColor: primary,
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Text('Filtro',style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ),
                  )
                ],),
            ),
          ),

          //colocar o future builder
          //fim do future builder
        ],
      );
  }

}
