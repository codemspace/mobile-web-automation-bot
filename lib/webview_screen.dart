import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'login_state.dart';
// import 'success_page.dart';
import 'pages/personal_details.dart';
import 'package:provider/provider.dart';
import '../user/user_data.dart';

class WebViewScreen extends StatefulWidget {
  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _controller;
  final String homeUrl = 'https://www.booking.com';  
  final String loginEmailUrl = 'https://account.booking.com/sign-in?op_token=';
  final String loginPasswordUrl = 'https://account.booking.com/sign-in/password?op_token=';
  final String loginSuccessUrl = 'https://www.booking.com/?auth_success=1';
  // final String loginSuccessUrl = 'https://www.booking.com/?auth_success=1&account_created=1';
  final String userSettingUrl = 'https://account.booking.com/mysettings';
  final String userSettingPersonalUrl = 'https://account.booking.com/mysettings/personal?aid=';
  final String landingUrl = 'https://www.booking.com/index.html?aid=';
  final String logoutUrl = 'https://www.booking.com/?logged_out=1';

  final String email = '...'; // replace with your email
  final String password = '...'; // replace with your password


  @override
  Widget build(BuildContext context) {
    final loginState = Provider.of<LoginState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Website'),
      ),
      body: WebViewWidget(
        controller: _controller = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageFinished: (url) async {
                final currentContext = context;
                print('Navigated to: $url'); 
                
                if (refineUrl(url) == homeUrl) {
                  await _controller.runJavaScript('''
                    document.querySelector('a[data-testid="header-small-sign-in-button"]').click();
                  ''');
                  print('Sign in'); 
                } else if (containsPrefix(url, loginEmailUrl)) {
                  print('Input Email');
                  await _controller.runJavaScript('''
                    document.getElementById('username').value = '$email';
                    // document.querySelector('button[type="submit"]').click();
                  ''');
                } else if (containsPrefix(url, loginPasswordUrl)) {
                  print('Input Password');
                  await _controller.runJavaScript('''
                    document.getElementById('password').value = '$password';
                    document.querySelector('button[type="submit"]').click();
                  ''');
                } else if (refineUrl(url) == loginSuccessUrl) {
                  await _controller.loadRequest(Uri.parse(userSettingUrl));
                  print('Load to user setting'); 
                } else if (containsPrefix(url, userSettingPersonalUrl)) {
                  final userInfoJson = await _controller.runJavaScriptReturningResult('''
                    (function() {
                      var userInfo = {};
                      userInfo.name = document.querySelector('[data-test-id="mysettings-row-name"] .comp-container__element').innerText;
                      userInfo.nickname = document.querySelector('[data-test-id="mysettings-row-nickname"] .comp-container__element').innerText;
                      userInfo.email = document.querySelector('[data-test-id="mysettings-row-email"] .comp-container__element').innerText;
                      userInfo.phone = document.querySelector('[data-test-id="mysettings-row-phone"] .comp-container__element').innerText;
                      userInfo.dateOfBirth = document.querySelector('[data-test-id="mysettings-row-dateOfBirth"] .comp-container__element').innerText;
                      userInfo.nationality = document.querySelector('[data-test-id="mysettings-row-nationality"] .comp-container__element').innerText;
                      userInfo.gender = document.querySelector('[data-test-id="mysettings-row-gender"] .comp-container__element').innerText;
                      userInfo.address = document.querySelector('[data-test-id="mysettings-row-address"] .comp-container__element').innerText;
                      userInfo.passport = document.querySelector('[data-test-id="mysettings-row-travelDocument"] .comp-container__element').innerText;
                      return JSON.stringify(userInfo);
                    })();
                  ''');
                  final userInfoStr = jsonDecode(userInfoJson as String);
                  Map<String, dynamic> userInfoMap = jsonDecode(userInfoStr);

                  var user = UserData.myUser;

                  user.name = userInfoMap['name'];
                  user.email = userInfoMap['email'];
                  user.phone = userInfoMap['phone'];

                  final encryptedInfo = encryptLoginInfo(userInfoJson as String);
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('user_info', encryptedInfo);

                  if (mounted) {
                    Navigator.push(
                      currentContext,
                      MaterialPageRoute(
                        // builder: (context) => SuccessPage(userInfo: userInfoMap),
                        builder: (context) => PersonalDetailsPage(),
                      ),
                    );
                    ScaffoldMessenger.of(currentContext).showSnackBar(SnackBar(content: Text('Complete: ${userInfoStr.toString()}')));
                    print('Navigated to SuccessPage');
                  }

                  // Navigator.pop(context);
                } else if (refineUrl(url) == refineUrl(logoutUrl)) {
                  print('Logged out!');
                } else if (containsPrefix(url, userSettingUrl)) {
                  // await _controller.loadRequest(Uri.parse(userSettingPersonalUrl));
                  await _controller.runJavaScript('''
                    document.querySelector('a[data-test-id="mysettings-nav-link-personal_details"]').click();
                  ''');
                  print('Navigated to user settings page');
                } else {
                  // loginState.incrementAttempts();
                  // if (loginState.loginAttempts >= 3) {
                  //   Navigator.pop(context);
                  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Locked out after 3 attempts')));
                  // }
                  print('Nothing');
                  // await _controller.runJavaScript('''
                  //   document.querySelectorAll('button[type="button"]').forEach(button => {
                  //     if (button.innerText.includes('Sign out')) {
                  //       button.click();
                  //     }
                  //   });
                  // ''');
                  // print('Sign out button clicked');
                }
              },
            ),
          )
          ..loadRequest(Uri.parse(homeUrl)),
      ),
    );
  }

  void _signOut() async {
    await _controller.runJavaScript('''
      document.querySelector('button[form="header-mfe-sign-out"]').click();
    ''');
    print('Sign out button clicked'); 
  }

  String encryptLoginInfo(String loginInfo) {
    final key = encrypt.Key.fromUtf8('my 32 length key................');
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt(loginInfo, iv: iv);
    return encrypted.base64;
  }

  String refineUrl(String url) {
    if (url.endsWith('/')) {
      return url.substring(0, url.length - 1);
    }
    return url;
  }

  bool containsPrefix(String url, String prefix) {
    return url.startsWith(prefix);
  }
}
