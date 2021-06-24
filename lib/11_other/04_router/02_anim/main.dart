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
      PageRouteBuilder(
          pageBuilder: (ctx, a1, a2) => RedPage(),
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: _buildTransitions),
    );
  }

  Widget _buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0),
          end: Offset.zero,
        ).animate(animation),
        child: FadeTransition(
          opacity: Tween<double>(
              begin: 0.5,
              end: 1.0)
        .animate(animation),
          child: child,
        ),
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
