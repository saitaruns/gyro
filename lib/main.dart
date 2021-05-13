import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Transform Card'),
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: StreamBuilder(
            stream: accelerometerEvents,
            initialData: AccelerometerEvent(0, 0, 0),
            builder: (c, snapshot) {
              var h = MediaQuery.of(context).size.height;
              var w = MediaQuery.of(context).size.width;
              return Transform(
                origin: Offset(w / 2, h / 2),
                transform: Matrix4.identity()
                  ..rotateX(0.05 * snapshot.data.y)
                  ..rotateY(0.05 * snapshot.data.x)
                // ..rotateZ(0.005 * snapshot.data.z % 9.5)
                ,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      // gradient: LinearGradient(
                      //   colors: [
                      //     Colors.white,
                      //     Colors.red,
                      //   ],
                      //   begin:
                      //       Alignment(1 * snapshot.data.x, 1 * snapshot.data.y),
                      //   end: Alignment(
                      //       -1 * snapshot.data.x, -1 * snapshot.data.y),
                      // ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.red,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(
                            -1 * snapshot.data.x,
                            1 * snapshot.data.y,
                          ),
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                    ),
                    height: 200.0,
                    width: 200.0,
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Text(
                        "Text",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}
