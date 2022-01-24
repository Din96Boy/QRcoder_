//clereignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>with SingleTickerProviderStateMixin{
   
  String imageUrl = "Image";
  String word = "Word";
  bool color = false;
  Color pickerColor = const Color(0xff443a49);
  late AnimationController _animationController;

   createQrCode(text,color)async{
    var uri =(Uri.parse("https://pierre2106j-qrcode.p.rapidapi.com/api"));
    var response =await http.get(uri.replace(queryParameters: <String, String>{

      "type": "text | url | tel | sms | email",
      "text": text,
      "ecl": "L | M| Q | H",
      "pixel": "9",
      "forecolor": color,
      "backcolor": "00237c"
    }
    ),

    headers:{
      "x-rapidapi-host": "pierre2106j-qrcode.p.rapidapi.com",
	    "x-rapidapi-key": "dc656fc519mshdfbc47dc694bfb7p1c3971jsnc628b0e95309",
    	"useQueryString": "true"

    }
    
  );
    setState(() {
      imageUrl = response.body;
    });
  }
  

    @override
    void initState(){
      _animationController = AnimationController(vsync:this,duration: Duration(milliseconds: 450));
      super.initState(); 
      }

      
        void _handleOnPressed(){
          setState(() {
          
          color =!color;
          color ? _animationController.forward():
          _animationController.reverse();
          });
        }

        void changeColor(Color color){
          setState(() {
            pickerColor = color;
          });
        }



 
 

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("QR Code Generator"),
        leading: const Icon(Icons.android,color: Colors.greenAccent,),
        backgroundColor: const Color.fromRGBO(0, 36, 124, 1),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.image,color: Colors.white,),
            onPressed: (){

            },
          )


        ],
      ),

     backgroundColor: const Color.fromRGBO(0, 36, 124, 1),
      body: ListView(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(
                  height:20,
                ),
                Stack(
                  children: [
                    Center(
                      child:Container(
                        height: 400,
                        width: 400,
                        child: Image.asset('assets/frame.png'),
                      ),
                    ),

                    
                    imageUrl != null ? Center(
                      child: Container(
                        padding:EdgeInsets.only(top: 10),
                        height: 190,
                        width: 190,
                       child: FadeInImage.assetNetwork(placeholder: "assets/loading-blue.gif", image: imageUrl),

                      ),
                    ):Container()
                  ],
                ),
                const SizedBox(
                  height:20,
                ),

                Container(
                  height: 40,
                  width: 300,
                  decoration: const BoxDecoration(
                    borderRadius:  BorderRadius.all(Radius.circular(100)),
                    color: Colors.white70
                   ),

                   child: Center(
                     child: ListTile(
                       title: Container(
                         padding: const EdgeInsets.only(bottom: 10),
                         child: TextFormField(
                           cursorColor: Colors.black,
                           onChanged: (value){
                             setState(() {
                               word = value;

                             });
                           },
                           decoration:InputDecoration(
                             icon: Container(
                               padding: const EdgeInsets.only(left: 10),
                               child: const Icon(Icons.vpn_key,color:Colors.black87),
                             ),
                             hintText: "Enter Your ID",
                             border: InputBorder.none,
                             focusedBorder: InputBorder.none,
                             enabledBorder: InputBorder.none,
                             errorBorder: InputBorder.none,
                             disabledBorder: InputBorder.none,
                             contentPadding: const EdgeInsets.only(left: 15,bottom: 11,right: 15),

                           ),
                         ),
                       ),
                     ),
                   ),
                ),

                SizedBox(
                  height: 15,
                ),

                AnimatedContainer(
                  padding: EdgeInsets.all(10),
                  duration: Duration(milliseconds: 300),
                  width: 300,
                  height: color == false ? 70:280,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 51, 145,1),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),

                  child:SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 100),
                            child: Row(
                              children: [
                                Text("COLOR" ,style: TextStyle(
                                  color:Colors.white,
                                  fontSize: 16 
                                  ), ),
                                  SizedBox(
                                    width: 15,
                                  ),

                                   
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      borderRadius:BorderRadius.all(Radius.circular(10)),
                                      color: pickerColor,
                                    ),
                                  
                                  )


                              ],
                            ),
                          ),

                          IconButton(
                            splashColor:Colors.transparent,
                            icon: AnimatedIcon(
                              icon:AnimatedIcons.menu_arrow,

                              color: Colors.white,
                              progress:_animationController,
                            ),

                            onPressed: (){
                              _handleOnPressed();
                            },
                          )
                        ],
                        

                      ),
                      color == true ? Container(
                          height: 200,
                          child:MaterialPicker(
                            pickerColor:pickerColor,
                            onColorChanged:changeColor,
                            enableLabel:true, 
                          ),

                        ): Container()
                    ],
                  ),
                  ),  
                ),



                SizedBox(
                  height: 20,
                 ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 50),
                      height: 70,
                      width: 150,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: Color.fromRGBO(255, 144,39, 1)
                      ),

                      child: TextButton(
                        
                        child: Text("CREATE QR",style: TextStyle(  
                          color: Colors.white
                        ),),

                       onPressed: (){
                            if(word != null){
                              createQrCode(word,"${pickerColor.red.toRadixString(16)}${pickerColor.green.toRadixString(16)}${pickerColor.blue.toRadixString(16)}" );
                           }
                        },
                      ),
                    ),


                    const SizedBox(
                      width: 15,


                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 50),
                      height: 70,
                      width: 150,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: Color.fromRGBO(0, 180,245, 1)
                      ),

                      child:TextButton(
                        
                        child: const Text("SAVE QR",style: TextStyle(
                          color: Colors.white
                        ),),
                        onPressed:(){

                       },
                      
                      ),
                    )

                  ],
                )
                
                
              ],
              
            ),
          )
        ],
      ),
    );
  }
}
