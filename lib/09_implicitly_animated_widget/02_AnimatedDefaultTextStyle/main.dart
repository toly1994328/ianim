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
  final TextStyle startStyle = const TextStyle(
      color: Colors.white,
      fontSize: 50,
      shadows: [
        Shadow(offset: Offset(1, 1), color: Colors.black, blurRadius: 3)
      ]);
  final TextStyle endStyle = const TextStyle(
      color: Colors.white,
      fontSize: 20,
      shadows: [
        Shadow(offset: Offset(1, 1), color: Colors.purple, blurRadius: 3)
      ]);

  TextStyle _style;

  @override
  void initState() {
    super.initState();
    _style = startStyle;
  }

  bool get selected => _style == endStyle;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        Switch(
          value: selected,
          onChanged: onChanged,
        ),
        Container(
            width: 300,
            height: 100,
            alignment: Alignment.center,
            color: Colors.grey.withAlpha(22),
            child: buildAnim())
      ],
    );
  }

  Widget buildAnim() => AnimatedDefaultTextStyle(
        textAlign: TextAlign.start,
        softWrap: true,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        style: _style,
        onEnd: onEnd,
        child: Text(
          '张风捷特烈',
        ),
      );

  void onChanged(bool value) {
    setState(() {
      _style = value ? endStyle : startStyle;
    });
  }

  void onEnd() {
    print('End');
  }
}
