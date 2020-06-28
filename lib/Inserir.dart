import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart'as http;
import 'package:intl/intl.dart';
import 'package:olxclone_app/main.dart';
class InserirAnucio extends StatefulWidget {
  @override
  _InserirAnucioState createState() => _InserirAnucioState();
}

class _InserirAnucioState extends State<InserirAnucio> {

  Color primary = Color(0xFF6d0ad6);
  Color button = Color(0xFFf18000);
  Color bgColor = Color(0xFFf2f2f2);
  Color fonteColor = Color(0xFF8e8e8e);
  String _image = 'images/add_image.png';
  String _imagePath = '';
  String url = "http://192.168.1.5:3333/anunciar";
  TextEditingController _titulo = TextEditingController();
  TextEditingController _descricao = TextEditingController();
  TextEditingController _preco = TextEditingController();
  TextEditingController _cidade = TextEditingController();
  TextEditingController _bairro = TextEditingController();

  ImagePicker _imagePicker;
   
  Future _getImage() async{

      var image = await _imagePicker.getImage(source: ImageSource.gallery);

      setState(() {
        _image = image.path;
        _imagePath = image.path;
      });
  }

  Future<String> uploadImage() async {

    Map<String, String> headers = {
      "Accept": "application/json"
    };

    String _imageName = _imagePath.split('/').last;
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('thumbnail', _imagePath));
    request.fields['titulo'] = _titulo.text;
    request.fields['preco'] = _preco.text;
    request.fields['data'] = _getData();
    request.fields['bairro'] = _bairro.text;
    request.fields['descricao'] = _descricao.text;
    request.fields['cidade'] = _cidade.text;
    request.headers.addAll(headers);
    var res = await request.send();
    return res.reasonPhrase;
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imagePicker = ImagePicker();
  }

  _getData(){
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyy hh:mm:ss');
    String formatted = formatter.format(now);
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: Text('Inserir Anúcio'),
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

      body: Container(
        color: bgColor,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: _getImage,
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(_image)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Título do anúcio *',style: TextStyle(fontSize: 20,color: fonteColor),),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _titulo,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: fonteColor, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: fonteColor, width: 1),
                        ),
                        hintText: 'Titulo Anúcio',
                        hintStyle: TextStyle(color: fonteColor)

                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Preço *',style: TextStyle(fontSize: 20,color: fonteColor),),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _preco,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: fonteColor, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: fonteColor, width: 1),
                        ),
                        hintText: 'Preço',
                        hintStyle: TextStyle(color: fonteColor)

                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Cidade *',style: TextStyle(fontSize: 20,color: fonteColor),),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _cidade,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: fonteColor, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: fonteColor, width: 1),
                        ),
                        hintText: 'Cidade',
                        hintStyle: TextStyle(color: fonteColor)

                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Bairro *',style: TextStyle(fontSize: 20,color: fonteColor),),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _bairro,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: fonteColor, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: fonteColor, width: 1),
                        ),
                        hintText: 'Bairro',
                        hintStyle: TextStyle(color: fonteColor)

                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Descrição *',style: TextStyle(fontSize: 20,color: Colors.black54),),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _descricao,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: fonteColor, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: fonteColor, width: 1),
                        ),
                        hintText: 'Descrição',
                        hintStyle: TextStyle(color: fonteColor)

                    ),
                    maxLines: 8,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RaisedButton(
                    
                    color: button,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30))
                    ),
                    child: Container(
                      width: 400,
                      height:  50,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                        Text('Anuciar',style: TextStyle(fontSize: 20,color: Colors.white),),

                      ],),
                    ),
                    onPressed: () async {
                        await uploadImage();
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>MyApp()));






                    },
                  ),
                )
              ],

          ),
        ),
      ),
    );
  }
}
