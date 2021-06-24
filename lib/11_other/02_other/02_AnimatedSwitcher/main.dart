import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

class _AnimDemoState extends State<AnimDemo> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          _buildBtn(Icons.remove,Colors.red,_doMinus),
          SizedBox(width:80,child: _buildAnimatedSwitcher(context)),
          _buildBtn(Icons.add,Colors.blue,_doAdd)
        ],
      ),
    );
  }

  Widget _buildAnimatedSwitcher(BuildContext context) =>
      AnimatedSwitcher(
        duration: const Duration(milliseconds: 2000),
        transitionBuilder: (Widget child, Animation<double> animation) =>
            ScaleTransition(
                child: RotationTransition(turns: animation, child: child),
                scale: animation),
        child: Text(
          '$_count',
          key: ValueKey<int>(_count),
          style: Theme.of(context).textTheme.display3,
        ),
      );


  Widget _buildBtn(IconData icon,Color color,VoidCallback onPressed)=>MaterialButton(
      padding: EdgeInsets.zero,
      textColor: const Color(0xffFfffff),
      elevation: 3,
      color: color,
      highlightColor: const Color(0xffF88B0A),
      splashColor: Colors.red,
      child: Icon(
        icon,
        color: Colors.white,
      ),
      shape: const CircleBorder(
        side: BorderSide(width: 2.0, color: Color(0xFFFFDFDFDF)),
      ),
      onPressed: onPressed );


  void _doMinus() {
    setState(() => _count -= 1);
  }

  void _doAdd() {
    setState(() => _count += 1);
  }
}

