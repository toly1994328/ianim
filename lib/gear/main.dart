


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ianim/gear/gear_painter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // 确定初始化
  SystemChrome.setPreferredOrientations( // 使设备横屏显示
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  SystemChrome.setEnabledSystemUIOverlays([]); // 全屏显示
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
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
      home: GearWidget(),
    );
  }
}

class GearWidget extends StatefulWidget {
  @override
  _GearWidgetState createState() => _GearWidgetState();
}

class _GearWidgetState extends State<GearWidget> with SingleTickerProviderStateMixin{

  AnimationController _ctrl;
  final Duration animDuration = const Duration(milliseconds:5000);


  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: animDuration);
  }


  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _doAnim,
        child: CustomPaint(
          size: MediaQuery.of(context).size,
          painter: GearPainter(listenable: _ctrl),
        ),
      ),
    );
  }

  void _doAnim() {
    _ctrl.forward(from: 0);
  }
}
