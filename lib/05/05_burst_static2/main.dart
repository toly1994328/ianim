import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'burst_menu.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // 确定初始化
  SystemChrome.setPreferredOrientations(// 使设备横屏显示
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
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double menuSize = 36;

  @override
  Widget build(BuildContext context) {
    Color wrapColor = Colors.blue.withOpacity(0.6);

    return Scaffold(
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          alignment: Alignment.center,
          child: IconTheme(
            data: IconTheme.of(context).copyWith(color: Colors.white, size: 18),
            child: BurstMenu(
                startAngle: 90.0 + 15,
                swapAngle: 180.0 - 15 * 2,
                menu: Container(
                  width: menuSize,
                  height: menuSize,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(menuSize / 2)),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        image: DecorationImage(
                            image: AssetImage('assets/images/icon_head.jpg')),
                        borderRadius: BorderRadius.circular(menuSize / 2)),
                  ),
                ),
                children: _buildMenuItems(wrapColor)),
          ),
        ),
      ),
    );
  }

  // 构建 菜单 item
  List<Widget> _buildMenuItems(Color wrapColor) => [
        Circled(color: wrapColor, child: Icon(Icons.close)),
        Circled(color: wrapColor, radius: 15, child: Icon(Icons.ac_unit)),
        Circled(color: wrapColor, radius: 15, child: Icon(Icons.palette)),
        Circled(color: wrapColor, child: Icon(Icons.widgets)),
        Circled(color: wrapColor, child: Icon(Icons.settings)),
      ];

}

class Circled extends StatelessWidget {
  final Widget child;
  final Color color;
  final double radius;

  Circled({this.child, this.color = Colors.blue, this.radius = 15});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      child: child,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(radius))),
    );
  }
}
