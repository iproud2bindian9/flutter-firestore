import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baby Names',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('<Application Title>')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('<firebase-instance>').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.name),
          trailing: Text(record.votes.toString()),
          onTap: () => record.reference.updateData({'votes': FieldValue.increment(1)}),       ),
      ),
    );
  }
}

class Record {
  final String name;
  final int votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        name = map['name'],
        votes = map['votes'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$votes>";
}
//import 'dart:math';
//
//import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
//import 'package:audioplayers/audio_cache.dart';
//import 'package:audioplayers/audioplayers.dart';
//
//
//void main() => runApp(AuthApp());
//
//class AuthApp extends StatefulWidget {
//  @override
//  _AuthAppState createState() => _AuthAppState();
//}
//
//
//class _AuthAppState extends State<AuthApp> {
//
//  int colorRange = 100;
//
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.deepOrange[colorRange],
//         appBar: AppBar(
//           title: Text("AuthApp"),
//           backgroundColor: Colors.blue.shade500,
//         ),
//         floatingActionButton: FloatingActionButton(
//           tooltip: "Adjust Intensity",
//           child: Icon(
//             Icons.add,
//             color: Colors.blue[900],
//           ),
//           backgroundColor: Colors.green,
//           onPressed: (){
//             setState(() {
//               colorRange+=100;
//               if(colorRange>900) {
//                 colorRange=100;
//               }
//             });
//           },
//         ),
//         body: SafeArea(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               CircleAvatar(
//                 radius: 50.0,
//                 backgroundImage: AssetImage("images/profilepic.jpg"),
//               ),
//               SizedBox(
//                 width: 300.0,
//                 height: 30.0,
//               ),
//               Text(
//                 "Sawal Tandon",
//                     style: TextStyle(
//                       fontFamily: "Trade Winds Regular",
//                       fontSize: 25.0,
//                       fontWeight: FontWeight.bold,
//                     )
//               ),
//               SizedBox(
//                 width: 300.0,
//                 height: 30.0,
//               ),
//               Card(
//                 margin: EdgeInsets.all(10.0),
//                 color: Colors.blue,
//                 child: ListTile(
//                   leading: Icon(Icons.phone),
//                   subtitle: Text("Mobile",
//                     style: TextStyle(
//                       fontSize: 25.0,
//                       fontFamily: "Odibee Sans Regular",
//                     ),
//                   ),
//                   title: Text("+919803352659",
//                    style: TextStyle(
//                      fontSize: 25.0,
//                      fontFamily: "Odibee Sans Regular",
//                    ),
//                   ),
//                 ),
//               ),
//               Card(
//                 margin: EdgeInsets.all(10.0),
//                 color: Colors.blue,
//                 child: ListTile(
//                   leading: Icon(Icons.email),
//                   subtitle: Text("Official"),
//                   title: Text("sawal.14770@lpu.co.in"),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//    );
//  }
//}


//class BNavApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return MaterialApp(
//      home: BNavWidget(),
//    );
//  }
//}
//
//class BNavWidget extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return BNavWidgetState();
//  }
//}
//
//class BNavWidgetState extends State<BNavWidget> {
//
//  int _currentIndex=1;
//  bool _isChecked = false;
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Scaffold(
//      body: Container(
//        child: Checkbox(
//          value: _isChecked,
//          onChanged: (newValue) {
//            setState(() {
//              _isChecked = newValue;
//            });
//          },
//          activeColor: Colors.blue,
//        ),
//      ),
//      appBar: AppBar(
//        title: Text("Bottom Navigation Widget"),
//        backgroundColor: Colors.blue,
//      ),
//      bottomNavigationBar: BottomNavigationBar(
//        onTap: (index) {
//          setState(() {
//            _currentIndex = index;
//          });
//        },
//        backgroundColor: Colors.white,
//        currentIndex: _currentIndex,
//        items: [
//          BottomNavigationBarItem(
//            icon: Icon(Icons.home),
//            title: Text("Home")
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.hotel),
//            title: Text("Hotel")
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.add_location),
//            title: Text("Location")
//          )
//        ],
//      ),
//    );
//
//  }
//}

//class NavApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return MaterialApp(
//      home: NavWidget()
//    );
//  }
//}
//
//
//class NavWidget extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Scaffold(
//        appBar: AppBar(
//          title: Text("NavigationApp"),
//          backgroundColor: Colors.blue,
//        ),
//        drawer: Drawer(
//          child: ListView(
//            children: <Widget>[
//              DrawerHeader(
//                decoration: BoxDecoration(
//                  color: Colors.red,
//                ),
//                child: Container(
//                    ),
//                ),
//              ListTile(
//                title: Text("Home"),
//                onTap: () {
//                  Navigator.pop(context);
//                },
//              ),
//              ListTile(
//                title: Text("Profile"),
//                onTap: () {
//                  Navigator.pop(context);
//                },
//              )
//            ],
//          ),
//        ),
//        body: Container(
//          child: Text("It is a navigation activity"),
//        ),
//      );
//  }
//}


//class ValueApp extends StatelessWidget {
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return MyWidget();
//  }
//
//}
//
//class MyWidget extends StatefulWidget {
//
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return MyWidgetState();
//  }
//
//}
//
//class MyWidgetState extends State<MyWidget> {
//
//  int counter = 0;
//
//  AudioCache cache = AudioCache(); // you have this
//  AudioPlayer player; // create this
//
//  void _playFile() async{
//    player = await cache.play('Tune.mp3'); // assign player here
//  }
//
//  void _stopFile() {
//    player?.stop(); // stop the file like this
//  }
//
//  incrementCounter(){
//    setState(() {
//      counter++;
//    });
//
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return MaterialApp(
//      home: new Scaffold(
//        appBar: AppBar(
//          title: Text("Value Sharing App"),
//          backgroundColor: Colors.blue,
//        ),
//        body: Center(child: Container(
//          child: Column(
//            children: <Widget>[
//              Flexible(
//                flex: 2,
//                child: Text("$counter",
//                  style: TextStyle(fontSize: 25.0, fontStyle: FontStyle.italic, fontFamily: "Times New Roman"),
//                ),
//              ),
//              Flexible(
//                flex: 1,
//                child: CustomButton(this, "Vote up",
//                ),
//              ),
//              Flexible(
//                flex: 1,
//                child: FlatButton(
//                  child: Text("Play Music"),
//                  onPressed: () {
//                    _playFile();
//                  },
//                ),
//              ),
//              Flexible(
//                flex: 1,
//                child: FlatButton(
//                  child: Text("Stop Music"),
//                  onPressed: () {
//                    _stopFile();
//                  },
//                ),
//              )
//            ],
//          ),
//        ),
//      )
//      )
//    );
//  }
//}
//
//class CustomButton extends StatefulWidget {
//
//  String text="";
//  MyWidgetState ob;
//
//  CustomButton(this.ob, this.text);
//
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return new CustomButtonState(ob, text);
//  }
//}
//
//class CustomButtonState extends State<CustomButton> {
//  String text;
//  MyWidgetState ob;
//  CustomButtonState(this.ob,this.text);
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Container(
//      child: FlatButton(
//        child: Text('$text'),
//        onPressed: () {
//          setState(() {
//            ob.incrementCounter();
//          });
//        },
//      ),
//    );
//  }
//}

//class DiceApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return MaterialApp(
//        home: new Scaffold(
//            backgroundColor: Colors.blue,
//            appBar: AppBar(
//              title: Text("My First Widget App"),
//              backgroundColor: Colors.blue,
//              toolbarOpacity: 0.5,
//            ),
//            body: Container(
//                alignment: Alignment.topLeft,
//                height: double.infinity,
//                width: double.infinity,
//                child: MyApp()
//    )
//    )
//    );
//  }
//}
//
//class MyApp extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return MyAppState();
//  }
//}
//
//class MyAppState extends State<MyApp> {
//  int imageNumber = 1;
//
//  var rn = new Random();
//
//  generateRandomNumber(int maxVal) {
//    int i = rn.nextInt(maxVal);
//    while (i == 0) {
//      i = rn.nextInt(maxVal);
//    }
//    setState(() {
//      imageNumber = i;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return RaisedButton(
//            onPressed: () {
//              generateRandomNumber(6);
//              print(imageNumber);
//            },
//            color: Colors.blue,
//            child: Image.asset("images/dice$imageNumber.png"));
//  }
//}

//
//String result = "0";
//
//class CalculatorPage extends StatefulWidget {
//  @override
//  _CalculatorPageState createState() => _CalculatorPageState();
//}
////
//class _CalculatorPageState extends State<CalculatorPage> {
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: AppBar(title: new Text("Falculator")),
//        body: Container(
//          height: double.infinity,
//          width: double.infinity,
//          color: Colors.black,
//            child: new Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Flexible(
//                  flex: 3,
//                  child: Container(
//                    alignment: Alignment.centerRight,
//                    height: double.infinity,
//                    width: double.infinity,
//                    child: Text(result,
//                      textAlign: TextAlign.end,
//                      style: TextStyle(color: Colors.white, fontSize: 54.0),
//                    ),
//                  ),
//                ),
//                Flexible(
//                  flex: 5,
//                  child: Container(
//                    color: Colors.black54,
//                    height: double.infinity,
//                    width: double.infinity,
//                    child: new Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        Flexible(
//                          flex: 1,
//                          child: new Container(
//                            height: double.infinity,
//                            width: double.infinity,
//                            child: new Row(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: <Widget>[
//                                Flexible(flex: 1, child: CustomButton("C")),
//                                Flexible(flex: 1, child: CustomButton("+/-")),
//                                Flexible(flex: 1, child: CustomButton("%")),
//                                Flexible(flex: 1, child: CustomButton("\u00F7")),
//                              ],
//                            )
//                          )
//                        ),
//                        Flexible(
//                          flex: 1,
//                          child: new Container(
//                            height: double.infinity,
//                            width: double.infinity,
//                            child: new Row(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: <Widget>[
//                                Flexible(flex: 1, child: CustomButton("7")),
//                                Flexible(flex: 1, child: CustomButton("8")),
//                                Flexible(flex: 1, child: CustomButton("9")),
//                                Flexible(flex: 1, child: CustomButton("X")),
//                              ],
//                            )
//                          )
//                        ),
//                        Flexible(
//                          flex: 1,
//                          child: new Container(
//                            height: double.infinity,
//                            width: double.infinity,
//                            child: new Row(
//                              crossAxisAlignment: CrossAxisAlignment.start,
//                              children: <Widget>[
//                                Flexible(flex: 1, child: CustomButton("4")),
//                                Flexible(flex: 1, child: CustomButton("5")),
//                                Flexible(flex: 1, child: CustomButton("6")),
//                                Flexible(flex: 1, child: CustomButton("-")),
//                              ],
//                            )
//                          )
//                        ),
//                        Flexible(
//                            flex: 1,
//                            child: new Container(
//                                height: double.infinity,
//                                width: double.infinity,
//                                child: new Row(
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  children: <Widget>[
//                                    Flexible(flex: 1, child: CustomButton("1")),
//                                    Flexible(flex: 1, child: CustomButton("2")),
//                                    Flexible(flex: 1, child: CustomButton("3")),
//                                    Flexible(flex: 1, child: CustomButton("+")),
//                                  ],
//                                )
//                            )
//                        ),
//                    Flexible(
//                      flex: 1,
//                      child: new Container(
//                          height: double.infinity,
//                          width: double.infinity,
//                          child: new Row(
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: <Widget>[
//                              Flexible(flex: 2, child: CustomButton("0")),
//                              Flexible(flex: 1, child: CustomButton(".")),
//                              Flexible(flex: 1, child: CustomButton("=")),
//                            ],
//                          )
//                        )
//                      )
//                      ],
//                    ),
//                  ),
//                ),
//              ],
//            ),
//        )
//    );
//  }
//}
//
//class CustomButton extends StatelessWidget {
//  String text;
//  CustomButton(this.text);
//
//  @override
//  Widget build(BuildContext context) {
//    return new Container(
//      margin: new EdgeInsets.all(6.0),
//      height: double.infinity,
//      width: double.infinity,
//      alignment: Alignment.center,
//      decoration: new BoxDecoration(
//        borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
//        color: Colors.white54),
//        child: Text(
//            text,
//            style: new TextStyle(
//                color: Colors.white,
//                fontSize: 25.0),
//          ),
//      );
//  }
//}

//class CustomButton extends StatefulWidget {
//  String text;
//  CustomButton(this.text);
//  @override
//  State<StatefulWidget> createState() {
//    // TODO: implement createState
//    return _CustomButtonState(text);
//  }
//}
//
//class _CustomButtonState extends State<CustomButton> {
//  String text;
//  _CustomButtonState(this.text);
//
//  @override
//  Widget build(BuildContext context) {
//    return new Container(
//      margin: new EdgeInsets.all(6.0),
//      height: double.infinity,
//      width: double.infinity,
//      alignment: Alignment.center,
////      decoration: new BoxDecoration(
////        borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
////        color: Colors.white54),
//      child: RaisedButton(child: Text(
//        text,
//        style: new TextStyle(
//            color: Colors.white,
//            fontSize: 25.0),
//        ),
//        onPressed: (){result+=text;},
//        color: Colors.black,
//      ),
//    );
//  }
//}

//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  // This widget is the home page of your application. It is stateful, meaning
//  // that it has a State object (defined below) that contains fields that affect
//  // how it looks.
//
//  // This class is the configuration for the state. It holds the values (in this
//  // case the title) provided by the parent (in this case the App widget) and
//  // used by the build method of the State. Fields in a Widget subclass are
//  // always marked "final".
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;
//
//  void _incrementCounter() {
//    setState(() {
//      // This call to setState tells the Flutter framework that something has
//      // changed in this State, which causes it to rerun the build method below
//      // so that the display can reflect the updated values. If we changed
//      // _counter without calling setState(), then the build method would not be
//      // called again, and so nothing would appear to happen.
//      _counter++;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // This method is rerun every time setState is called, for instance as done
//    // by the _incrementCounter method above.
//    //
//    // The Flutter framework has been optimized to make rerunning build methods
//    // fast, so that you can just rebuild anything that needs updating rather
//    // than having to individually change instances of widgets.
//    return Scaffold(
//      appBar: AppBar(
//        // Here we take the value from the MyHomePage object that was created by
//        // the App.build method, and use it to set our appbar title.
//        title: Text(widget.title),
//      ),
//      body: Center(
//        // Center is a layout widget. It takes a single child and positions it
//        // in the middle of the parent.
//        child: Column(
//          // Column is also a layout widget. It takes a list of children and
//          // arranges them vertically. By default, it sizes itself to fit its
//          // children horizontally, and tries to be as tall as its parent.
//          //
//          // Invoke "debug painting" (press "p" in the console, choose the
//          // "Toggle Debug Paint" action from the Flutter Inspector in Android
//          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//          // to see the wireframe for each widget.
//          //
//          // Column has various properties to control how it sizes itself and
//          // how it positions its children. Here we use mainAxisAlignment to
//          // center the children vertically; the main axis here is the vertical
//          // axis because Columns are vertical (the cross axis would be
//          // horizontal).
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'You have pushed the button this many times:',
//            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.display1,
//            ),
//          ],
//        ),
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
//    );
//  }
//}
