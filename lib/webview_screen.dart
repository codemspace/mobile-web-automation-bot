import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'login_state.dart';
import 'package:provider/provider.dart';

class WebViewScreen extends StatefulWidget {
  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _controller;
  final String loginUrl = 'https://www.ilovepdf.com/login';
  final String userUrl = 'https://www.ilovepdf.com/user';
  final String email = 'promsdev@outlook.com'; // replace with your email
  final String password = 'KKKkkk123!@#'; // replace with your password

  @override
  Widget build(BuildContext context) {
    final loginState = Provider.of<LoginState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('WebView Login'),
      ),
      body: WebViewWidget(
        controller: _controller = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageFinished: (url) async {
                if (url == loginUrl) {
                  // Inject JavaScript to fill in the login form and submit it
                  await _controller.runJavaScript('''
                    document.getElementById('loginEmail').value = '$email';
                    document.getElementById('inputPasswordAuth').value = '$password';
                    document.getElementById('loginBtn').click();
                  ''');
                } else if (url == userUrl) {
                  // Inject JavaScript to scrape user information
                  final userInfoJson = await _controller.runJavaScriptReturningResult('''
                    (function() {
                      var userInfoDiv = document.querySelector('.user-info');
                      var firstName = userInfoDiv.querySelector('p:nth-of-type(1)').innerText.split(': ')[1];
                      var lastName = userInfoDiv.querySelector('p:nth-of-type(2)').innerText.split(': ')[1];
                      var country = userInfoDiv.querySelector('p:nth-of-type(3)').innerText.split(': ')[1].trim();
                      var timezone = userInfoDiv.querySelector('p:nth-of-type(4)').innerText.split(': ')[1];
                      return JSON.stringify({firstName, lastName, country, timezone});
                    })();
                  ''');
                  
                  final userInfo = jsonDecode(userInfoJson as String);
                  final encryptedInfo = encryptLoginInfo(userInfoJson as String);
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('user_info', encryptedInfo);

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Complete: $userInfo')));
                } else {
                  loginState.incrementAttempts();
                  if (loginState.loginAttempts >= 3) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Locked out after 3 attempts')));
                  }
                }
              },
            ),
          )
          ..loadRequest(Uri.parse(loginUrl)),
      ),
    );
  }

  String encryptLoginInfo(String loginInfo) {
    final key = encrypt.Key.fromUtf8('my 32 length key................');
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt(loginInfo, iv: iv);
    return encrypted.base64;
  }
}