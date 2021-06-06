import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'shine_wrapper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // 确定初始化
  SystemChrome.setPreferredOrientations( // 使设备横屏显示
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  SystemChrome.setEnabledSystemUIOverlays([]); // 全屏显示
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          // backgroundColor: Colors.black,
            body: Center(
              child: Wrap(
                spacing: 50,
                children:[
                  CircleShineImage(
                    image: AssetImage('assets/images/wy_300x200.jpg'),
                    color: Colors.red,
                    maxBlurRadius: 6,
                    duration: Duration(seconds: 1),
                    curve: Curves.easeIn,
                  ),
                  CircleShineImage(
                    image: AssetImage('assets/images/icon_head.png'),
                    color: Colors.purple,
                    maxBlurRadius: 8,
                    curve: Curves.ease,
                  ),
                  CircleShineImage(
                    image: AssetImage('assets/images/icon_8.jpg'),
                    color: Colors.blue,
                    maxBlurRadius: 4,
                    curve: Curves.decelerate,
                  )
                ] ,
              ),
            ))
    );
  }
}
