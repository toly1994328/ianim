import 'package:flutter/material.dart';

void main() {
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
        home: GreenPage());
  }
}

class GreenPage extends StatelessWidget {
  const GreenPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text('GreenPage'),
        actions: [
          IconButton(
            onPressed: () => _toRed(context),
            icon: Icon(Icons.navigate_next),
          )
        ],
      ),
    );
  }

  void _toRed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => RedPage()),
    );
  }
}

class RedPage extends StatelessWidget {
  const RedPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: const Text('RedPage'),
      ),
    );
  }
}
