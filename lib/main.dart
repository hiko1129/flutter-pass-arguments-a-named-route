import 'dart:core';

import 'package:flutter_web/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        var paths = settings.name.split('?');
        var path = paths[0];
        var queryParameters = Uri.splitQueryString(paths[1]);

        if (path == PassArgumentsScreen.routeName) {
          return MaterialPageRoute(
            settings: RouteSettings(name: settings.name), // これによりURLが変わる
            builder: (context) {
              return PassArgumentsScreen(
                title: queryParameters['title'],
                message: queryParameters['message'],
              );
            },
          );
        }
      },
      title: 'Navigation with Arguments',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("Navigate to screen that extracts arguments"),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/passArguments?title=hogehoge&message=fugafuga', // onGenerateRouteで処理される
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PassArgumentsScreen extends StatelessWidget {
  static const routeName = '/passArguments';

  final String title;
  final String message;

  const PassArgumentsScreen({
    Key key,
    @required this.title,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}
