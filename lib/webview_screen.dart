import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'login_state.dart';
// import 'success_page.dart';
// import 'pages/personal_details.dart';
import 'package:provider/provider.dart';
import '../user/user_data.dart';
import 'pages/account_settings.dart';

class WebViewScreen extends StatefulWidget {
  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _controller;
  // final String homeUrl = 'https://www.ally.com/';  
  // final String loginEmailUrl = 'https://account.booking.com/sign-in?op_token=';
  // final String loginPasswordUrl = 'https://account.booking.com/sign-in/password?op_token=';
  // final String loginSuccessUrl = 'https://secure.ally.com/dashboard?sfts=true';
  // final String userSettingUrl = 'https://account.booking.com/mysettings';
  // final String userSettingPersonalUrl = 'https://account.booking.com/mysettings/personal?aid=';
  // final String landingUrl = 'https://www.booking.com/index.html?aid=';
  // final String logoutUrl = 'https://www.booking.com/?logged_out=1';
  
  final String homeUrl = 'https://www.ally.com';  
  final String loginVerifyCode = 'https://secure.ally.com/security/verify-code?focus=heading';
  final String loginSuccessUrl = 'https://secure.ally.com/dashboard?sfts=true';
  final String dashboardUrl = 'https://secure.ally.com/dashboard';
  final String redirectUrl = 'https://secure.ally.com/?redirect=/';

  final String settingPersonalUrl = 'https://secure.ally.com/profile';
  final String logoutUrl = 'https://www.ally.com/logged-off';

  final String email = '...'; // replace with your email
  final String password = '...'; // replace with your password


  @override
  Widget build(BuildContext context) {
    final loginState = Provider.of<LoginState>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor.fromHex('#650360'),
        title: Text(
          'Website',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
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
                    document.querySelector('button[id="login"]').click();
                  ''');
                  print('Sign in'); 
                } else if (containsPrefix(url, redirectUrl)) {
                  print('Check For Redirect');
                // } else if (refineUrl(url) == loginSuccessUrl) {
                //   await _controller.loadRequest(Uri.parse(settingPersonalUrl));
                //   print('Load to user setting'); 
                } else if (containsPrefix(url, dashboardUrl)) {
                  await _controller.loadRequest(Uri.parse(settingPersonalUrl));
                  print('Load to user setting'); 
                } else if (refineUrl(url) == settingPersonalUrl) {
                  final userInfoJson = await _controller.runJavaScriptReturningResult('''
                    (function() {
                      var userInfo = {};

                      // Extracting name
                      userInfo.name = document.querySelector('[data-dd-action-name="Users Full Name"]').innerText;

                      // Extracting email
                      // userInfo.email = document.querySelector('[data-testid="primary-email-item"]').innerText;
                      userInfo.email = document.querySelector('[data-testid="primary-email-item"] [data-testid="private-wrapper"]').innerText;


                      userInfo.phone = document.querySelector('[data-testid="card-phone"] [data-testid="private-wrapper"]').innerText;

                      var primaryAddressParts = document.querySelectorAll('[data-testid="card-address"] .fhBGkE:first-child [data-testid="private-wrapper"]');
                      userInfo.primaryAddress = Array.from(primaryAddressParts).map(part => {
                        if (part.firstChild.children.length === 0) 
                          return part.innerText;
                        else {
                          return part.firstChild.firstChild.innerText;
                        }
                      }).join(", ");

                      var mailingAddressParts = document.querySelectorAll('[data-testid="card-address"] .fhBGkE:nth-child(2) [data-testid="private-wrapper"]');
                      userInfo.mailingAddress = Array.from(primaryAddressParts).map(part => {
                        if (part.firstChild.children.length === 0) 
                          return part.innerText;
                        else {
                          return part.firstChild.firstChild.innerText;
                        }
                      }).join(", ");

                      // Returning as a JSON string
                      return JSON.stringify(userInfo);
                    })();
                  ''');
                  final userInfoStr = jsonDecode(userInfoJson as String);
                  Map<String, dynamic> userInfoMap = jsonDecode(userInfoStr);

                  var user = UserData.myUser;

                  user.name = userInfoMap['name'];
                  user.email = userInfoMap['email'];
                  user.phone = userInfoMap['phone'];
                  user.primaryAddress = userInfoMap['primaryAddress'];
                  user.mailingAddress = userInfoMap['mailingAddress'];

                  final encryptedInfo = encryptLoginInfo(userInfoJson as String);
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('user_info', encryptedInfo);

                  if (mounted) {
                    Navigator.push(
                      currentContext,
                      MaterialPageRoute(
                        // builder: (context) => SuccessPage(userInfo: userInfoMap),
                        builder: (context) =>  AccountSetting(),
                      ),
                    );
                    ScaffoldMessenger.of(currentContext).showSnackBar(SnackBar(content: Text('Complete: ${userInfoStr.toString()}')));
                    print('Navigated to SuccessPage');
                  }

                  // Navigator.pop(context);
                } else if (refineUrl(url) == refineUrl(logoutUrl)) {
                  print('Logged out!');
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

  // void _signOut() async {
  //   await _controller.runJavaScript('''
  //     document.querySelector('button[form="header-mfe-sign-out"]').click();
  //   ''');
  //   print('Sign out button clicked'); 
  // }

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

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
