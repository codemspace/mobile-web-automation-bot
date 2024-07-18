import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'login_state.dart';
import 'success_page.dart';
import 'package:provider/provider.dart';

class WebViewScreen extends StatefulWidget {
  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _controller;
  final String loginUrl = 'https://www.ilovepdf.com/login';
  final String homeUrl = 'https://www.ilovepdf.com/';
  final String userUrl = 'https://www.ilovepdf.com/user';
  final String email = 'promsdev@outlook.com'; // replace with your email
  final String password = 'KKKkkk123!@#'; // replace with your password

  @override
  Widget build(BuildContext context) {
    final loginState = Provider.of<LoginState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('WebView'),
      ),
      body: WebViewWidget(
        controller: _controller = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageFinished: (url) async {
                final currentContext = context;
                print('Navigated to: $url'); // Debug log

                if (url == loginUrl) {
                  // Inject JavaScript to fill in the login form and submit it
                  await _controller.runJavaScript('''
                    // document.getElementById('loginEmail').value = '$email';
                    // document.getElementById('inputPasswordAuth').value = '$password';
                    // document.getElementById('loginBtn').click();
                  ''');
                } else if (url == homeUrl) {
                  // Navigate to user profile page after successful login
                  await _controller.loadRequest(Uri.parse(userUrl));
                } else if (url == userUrl) {
                  // Inject JavaScript to scrape user information
                  final userInfoJson = await _controller.runJavaScriptReturningResult('''
                    (function() {
                      var firstName, lastName, country, timezone, email;
                      var userInfoDiv = document.getElementById('account-preview');
                      if (userInfoDiv) {
                        var userInfo = userInfoDiv.querySelectorAll('.user-info')[0];
                        if (userInfo) {
                          firstName = userInfo.querySelector('p:nth-of-type(1)').innerText.split(':')[1]. replace("\\n", "");
                          lastName = userInfo.querySelector('p:nth-of-type(2)').innerText.split(':')[1]. replace("\\n", "");
                          country = userInfo.querySelector('p:nth-of-type(3)').innerText.split(':')[1]. replace("\\n", "").trim();
                          timezone = userInfo.querySelector('p:nth-of-type(4)').innerText.split(':')[1]. replace("\\n", "");
                        } else {
                          return JSON.stringify({error: 'user-info not found'});
                        }
                      } else {
                        return JSON.stringify({error: 'account-preview not found'});
                      }

                      var emailInfoDiv = document.getElementById('email-preview');
                      if (emailInfoDiv) {
                        var emailInfo = emailInfoDiv.querySelectorAll('.user-info')[0];
                        if (emailInfo) {
                          email = emailInfo.querySelector('p:nth-of-type(1)').innerText.split(':')[1]. replace("\\n", "");
                        } else {
                          return JSON.stringify({error: 'email-info not found'});
                        }
                      } else {
                        return JSON.stringify({error: 'email-preview not found'});
                      }

                      return JSON.stringify({firstName, lastName, email, country, timezone});
                    })();
                  ''');

                  final userInfoStr = jsonDecode(userInfoJson as String);

                  Map<String, dynamic> userInfoMap = jsonDecode(userInfoStr);




                  final encryptedInfo = encryptLoginInfo(userInfoJson as String);
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('user_info', encryptedInfo);

                  
                  if (mounted) {
                    Navigator.push(
                      currentContext,
                      MaterialPageRoute(
                        builder: (context) => SuccessPage(userInfo: userInfoMap),
                      ),
                    );
                    ScaffoldMessenger.of(currentContext).showSnackBar(SnackBar(content: Text('Complete: ${userInfoStr.toString()}')));
                    print('Navigated to SuccessPage'); // Debug log
                  }

                  // Navigator.pop(context);
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
