import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  WebViewController? _webViewController;
  bool _isLoginSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple WebView App')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            int failedAttempts = prefs.getInt('failedAttempts') ?? 0;

            if (failedAttempts >= 3) {
              _showLockoutMessage();
            } else {
              _openWebView();
            }
          },
          child: Text('Start'),
        ),
      ),
    );
  }

  void _openWebView() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(title: Text('Login Page')),
        body: WebViewWidget(
          controller: _webViewController = WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..loadRequest(Uri.parse('https://www.ilovepdf.com/'))
            ..setNavigationDelegate(
              NavigationDelegate(
                onPageFinished: (url) {
                  if (url.contains('success')) {
                    _onLoginSuccess();
                  } else if (url.contains('failed')) {
                    _onLoginFailed();
                  }
                },
              ),
            ),
        ),
      ),
    ));
  }

  void _onLoginSuccess() async {
    await _secureStorage.write(key: 'login', value: 'encrypted_login_info');
    Navigator.pop(context);
    setState(() {
      _isLoginSuccess = true;
    });
    _showCompleteMessage();
  }

  void _onLoginFailed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int failedAttempts = prefs.getInt('failedAttempts') ?? 0;
    failedAttempts += 1;
    await prefs.setInt('failedAttempts', failedAttempts);

    if (failedAttempts >= 3) {
      _showLockoutMessage();
    } else {
      _showRetryMessage();
    }
  }

  void _showCompleteMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Complete')),
    );
  }

  void _showRetryMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Login failed, please try again.')),
    );
  }

  void _showLockoutMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Too many failed attempts. Please try again later.')),
    );
  }
}
