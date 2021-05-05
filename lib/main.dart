import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'notification.dart';
import 'package:audioplayers/audioplayers.dart';
main() async {
  // ignore: close_sinks

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Socket with ardino'),
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
  @override
  // ignore: override_on_non_overriding_member
  var serverResponse;
  var x="null";

  g() async {
    final socket = await Socket.connect("192.168.1.20", 2222);
    print('Connected to: ${socket.remoteAddress.address}:${socket.remotePort}');
    socket.listen(
      // handle data from the server
      (Uint8List data) {
        final serverResponse = String.fromCharCodes(data);
        print('Server: $serverResponse');
        setState(() {
          x = serverResponse; //this is the  main line which helps in updating the Text widget...
          print(x);
          if(x.contains('high')){
             play();
          }
           
        });
      },

      // handle errors
      onError: (error) {
        print(error);
        socket.destroy();
      },

      // handle server ending connection
      onDone: () {
        print('Server left.');
        socket.destroy();
      },
    );
  }

  void initstate() {
    super.initState();
    //g();
    print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"); //why not printing??????
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // ignore: deprecated_member_use
        child: Column(
          children: [
            // ignore: deprecated_member_use
            RaisedButton(
              onPressed: () async {
                 //play();
                await g();
               /* if (x.contains('high')) {
                  play();
                }*/
               // print("x is $x");  //working..........
                /*  setState(()  {
                  
                  serverResponse = serverResponse;
                  print("bahar hai->$x");
                
                });*/
              },
              child: Text("click krr be"),
            ),
            Text("$x"),
            //play(),
            //if (x.contains('high')) 
            //play(),
            //it will look for x has "high" or not and will return true or false
            //play(),
            //Text("going to play song..........................."),

             
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
   AudioPlayer _audioPlayer = AudioPlayer();
   play()async{
     await _audioPlayer.play("https://datahacked.s3.ap-south-1.amazonaws.com/alert.aac");
   }
    
}
