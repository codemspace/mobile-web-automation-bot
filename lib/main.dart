import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'webview_screen.dart';
import 'login_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LoginState(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF WebView App'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WebViewScreen()),
            );
          },
          child: Text('Start'),
        ),
      ),
    );
  }
}
