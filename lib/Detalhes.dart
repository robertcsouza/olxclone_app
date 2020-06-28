import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class DetalhesAnucio extends StatefulWidget {
    final Map anuncio;

  const DetalhesAnucio({Key key, this.anuncio}) : super(key: key);
  @override
  _DetalhesAnucioState createState() => _DetalhesAnucioState();

}


class _DetalhesAnucioState extends State<DetalhesAnucio> {
  Color primary = Color(0xFF6d0ad6);
  Color button = Color(0xFFf18000);
  Color bgColor = Color(0xFFf2f2f2);
  Color fonteColor = Color(0xFF8e8e8e);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text('Anúcio'),
        actions: <Widget>[

          IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: Colors.white,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.white,
            ),
          )
        ],

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },

        label: Padding(
            padding: const EdgeInsets.only(top:8.0,bottom: 8.0, left: 32, right: 32),
          child: Text('Chat',style: TextStyle(fontSize: 16),),
        ),
        icon: Icon(Icons.chat_bubble_outline),
        backgroundColor: button,
      ),
      body: Container(
        color: bgColor,
        child: SingleChildScrollView(
          child: Column(

            children: <Widget>[
              Container(
                height: 300,
                child: Image.network(widget.anuncio['thumbnail_url']),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left:32.0,top:16.0),
                    child: Text('R\$ ${widget.anuncio['preco']}',style: TextStyle(
                      fontSize: 32,
                      color: fonteColor
                    ),),
                  ),
                ],
              ),
              Row(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left:32.0,top:16.0),
                  child: Text(widget.anuncio['titulo'],style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                  ),
                  ),
                ),

              ],),
              Column(children: <Widget>[
                Row(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left:32.0,top:16.0),
                    child: Text('Publicado em  ${widget.anuncio['data']}',style: TextStyle(
                        fontSize: 12,
                        color: fonteColor
                    ),
                    ),
                  ),
                ],),
                SizedBox(
                height: 50,
                ),
                SizedBox(
                  height: 1,
                  child: Container(
                    color: fonteColor,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 30, left: 32),
                      child: Text('Descrição',style: TextStyle(fontSize: 20),),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 30, left: 32),
                      child: Text(widget.anuncio['descricao'],style: TextStyle(fontSize: 16,color: fonteColor),),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 30, left: 32),
                      child: Text('Detalhes',style: TextStyle(fontSize: 20),),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 30, left: 32),
                      child: Text('Em Bom estado de Conservação',style: TextStyle(fontSize: 16,color: fonteColor),),
                    )
                  ],
                ),
                SizedBox(height: 50,)
              ],)
            ],
          ),
        ),
      ),
    );
  }
}
