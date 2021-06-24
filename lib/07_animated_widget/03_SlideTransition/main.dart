import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            body: Center(
              child: AnimDemo(),
            )));
  }
}

class AnimDemo extends StatefulWidget {
  @override
  _AnimDemoState createState() => _AnimDemoState();
}

class _AnimDemoState extends State<AnimDemo>
    with SingleTickerProviderStateMixin {
  AnimationController _ctrl;
  Animation<Offset> animation;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0.5, 0.5),
    ).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => _ctrl.forward(from: 0),
        child: Container(
          width: 200,
          height: 100,
          color: Colors.grey.withAlpha(22),
          child:_buildContent(),
        ));
  }

  Widget _buildContent() =>
      Stack(
        fit: StackFit.expand,
        children: [
          SlideTransition(
            textDirection: TextDirection.ltr,
            position: animation,
            child: _buildChild(),
          ),
          SlideTransition(
            textDirection: TextDirection.rtl,
            position: animation,
            child: _buildChild(),
          ),
        ],
      );

  Widget _buildChild() =>
      const Icon(
        Icons.accessible_forward_sharp,
        color: Colors.green,
        size: 25,
      );
}
