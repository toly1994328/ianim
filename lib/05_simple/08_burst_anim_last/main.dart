import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'burst_menu.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // 确定初始化
  // SystemChrome.setPreferredOrientations(// 使设备横屏显示
  //     [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
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
      body: Stack(
        children: [
          Positioned(
            right: 20,
            top: 20,
            child: BurstMenu.topRight(
              curve: Curves.bounceOut,
            radius: 60,
            center: _buildMenu(),
            burstMenuItemClick: _burstMenuItemClick,
            menus: _buildMenuItems(),
          ),),

          Positioned(
            left: 20,
            top: 20,
            child: BurstMenu.topLeft(
              curve: Curves.linearToEaseOut,
              radius: 60,
              center: _buildMenu(),
              burstMenuItemClick: _burstMenuItemClick,
              menus: _buildMenuItems(),
            ),),

          Positioned(
            right: 20,
            bottom: 20,
            child: BurstMenu.bottomRight(
              curve: Curves.decelerate,
              radius: 60,
              center: _buildMenu(),
              burstMenuItemClick: _burstMenuItemClick,
              menus: _buildMenuItems(),
            ),),
          Positioned(
            left: 20,
            bottom: 20,
            child: BurstMenu.bottomLeft(
              curve: Curves.easeOutQuart,
              radius: 60,
              center: _buildMenu(),
              burstMenuItemClick: _burstMenuItemClick,
              menus: _buildMenuItems(),
            ),),
          Positioned(
            left: MediaQuery.of(context).size.width/2-120,
            bottom: 80,
            child: BurstMenu(
              radius: 120,
              burstType: BurstType.halfCircle,
              startAngle: -150,
              swapAngle: 90.0+30,
              center: _buildMenu(),
              burstMenuItemClick: _burstMenuItemClick,
              menus: _buildMenuItems(),
            ),),
        ],
      )

      // Center(
      //   child: IconTheme(
      //     data: IconTheme.of(context).copyWith(color: Colors.white, size: 18),
      //     child: Wrap(
      //       children: [
      //         BurstMenu(
      //           radius: 100,
      //           burstType: BurstType.circle,
      //           center: _buildMenu(),
      //           burstMenuItemClick: _burstMenuItemClick,
      //           menus: _buildMenuItems(),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
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


  final List<Color> colors = [
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.green,
  ];

  // 构建 菜单 item
  List<Widget> _buildMenuItems() => colors.asMap().keys
          .map((int index) => Container(
    alignment: Alignment.center,
                width: 15.0 * 2,
                height: 15.0 * 2,
                child: Text('$index',style: TextStyle(color: Colors.white),),
                decoration: BoxDecoration(
                    color: colors[index],
                    borderRadius:
                        const BorderRadius.all(Radius.circular(15.0))),
              ))
          .toList();

  bool _burstMenuItemClick(int index) {
    print("index:$index");
    if (index == 0) {
      return false;
    }
    return true;
  }
}
