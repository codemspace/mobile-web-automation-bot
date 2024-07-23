import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'webview_screen.dart';
import 'login_state.dart';
import 'pages/profile_page.dart';

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
      // home: MainScreen(),
      home: ProfilePage(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Web Automation'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WebViewScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            // foregroundColor: Colors.pinkAccent,//change background color of button
            // backgroundColor: Colors.yellow,//change text color of button
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 15.0,
            padding: const EdgeInsets.all(20),
          ),
          child: Text('Start',
            style: const TextStyle(
              color: Color(0XFFFFFFFF),
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
