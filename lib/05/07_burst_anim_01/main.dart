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
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          alignment: Alignment.center,
          child: IconTheme(
            data: IconTheme.of(context).copyWith(color: Colors.white, size: 18),
            child: BurstMenu(
                center: _buildMenu(),
                burstMenuItemClick: _burstMenuItemClick,
                menus: _buildMenuItems()),
          ),
        ),
      ),
    );
  }

  Widget _buildMenu() => Container(
        width: 36,
        height: 36,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage('assets/images/icon_head.jpg')),
          ),
        ),
      );

  // 构建 菜单 item
  List<Widget> _buildMenuItems() => [
        Colors.red,
        Colors.yellow,
        Colors.blue,
        Colors.green,
        Colors.purple,
      ]
          .map((Color color) => Container(
                width: 15.0 * 2,
                height: 15.0 * 2,
                decoration: BoxDecoration(
                    color: color,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(15.0))),
              ))
          .toList();

  bool _burstMenuItemClick(int index) {
    print("index:$index");
    if(index ==0){
      return false;
    }
    return true;
  }
}

