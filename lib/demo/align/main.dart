import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // 确定初始化
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
          child: AlignDemo(),
        )));
  }
}

class AlignDemo extends StatelessWidget {
  const AlignDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 100,
      child: UnconstrainedBox(
        child: Align(
          heightFactor: 1.5,
          widthFactor: 2,
          alignment: Alignment.centerLeft,
          child: Container(
            height: 60,
            width: 60,
            color: Colors.orangeAccent,
          ),
        ),
      ),
    );
  }
}
