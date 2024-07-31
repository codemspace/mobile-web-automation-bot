import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_state.dart';
import 'pages/account_settings.dart';
import 'webview_screen.dart';
import '../user/user_data.dart';
// import 'base_page.dart'; 
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   Stripe.publishableKey = 'pk_test_51L8PzGKEp9uhBKrrUaQGs8uNSewO9Lm85zYGJSJZ2I5nlYSnBtGRBa7Abky4uTxR4LYx2TMjkwJ48HJ6CZKVwLFo003wdImXQs';

  await dotenv.load(fileName: "assets/.env");

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
  Map<String, dynamic> userInfoMap = {
    "name": "Artem Pop",
    "nickname": "Choose a display name",
    "email": "promsdev@outlook.com",
    "phone": "+380 97 110 4670",
    "dateOfBirth": "Enter your date of birth",
    "nationality": "Select the county/region you're from",
    "gender": "Select your gender",
    "primaryAddress": "Add your address",
    "mailingAddress": "Add your address",
    "passport": "Not provided"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor.fromHex('#650360'),
        title: Text(
          'Ally.com',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            var user = UserData.myUser;

            user.name = userInfoMap['name'] == "Let us know what to call you" ? "" : userInfoMap['name'];
            user.nickname = userInfoMap['nickname'] == "Choose a display name" ? "" : userInfoMap['nickname'];
            user.email = userInfoMap['email'];
            user.phone = userInfoMap['phone'];
            user.dateOfBirth = userInfoMap['dateOfBirth'] == "Enter your date of birth" ? "" : userInfoMap['dateOfBirth'];
            user.nationality = userInfoMap['nationality'] == "Select the country/region you're from" ? "" : userInfoMap['nationality'];
            user.gender = userInfoMap['gender'] == "Select your gender" ? "" : userInfoMap['gender'];
            user.primaryAddress = userInfoMap['primaryAddress'] == "Add your address" ? "" : userInfoMap['primaryAddress'];
            user.mailingAddress = userInfoMap['mailingAddress'] == "Add your address" ? "" : userInfoMap['mailingAddress'];
            user.passport = userInfoMap['passport'] == "Not provided" ? "" : userInfoMap['passport'];

            Navigator.push(
              context,
              // MaterialPageRoute(builder: (context) => AccountSetting()),
              MaterialPageRoute(builder: (context) => WebViewScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            // padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            // elevation: 10,
            backgroundColor: HexColor.fromHex('#650360'), 
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [HexColor.fromHex('#650360'), HexColor.fromHex('#550355')],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: Text(
              'Start',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
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