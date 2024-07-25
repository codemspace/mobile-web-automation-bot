import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_state.dart';
import 'pages/account_settings.dart';
import '../user/user_data.dart';
import 'base_page.dart';  // Ensure you import the BasePage

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
  Map<String, dynamic> userInfoMap = {
    "name": "Artem Pop",
    "nickname": "Choose a display name",
    "email": "promsdev@outlook.com",
    "phone": "+380 97 110 4670",
    "dateOfBirth": "Enter your date of birth",
    "nationality": "Select the county/region you're from",
    "gender": "Select your gender",
    "address": "Add your address",
    "passport": "Not provided"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF003580), // Blue color
        title: Text(
          'Booking.com',
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
            user.address = userInfoMap['address'] == "Add your address" ? "" : userInfoMap['address'];
            user.passport = userInfoMap['passport'] == "Not provided" ? "" : userInfoMap['passport'];

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AccountSetting()),
            );
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            elevation: 10,
            primary: Color(0xFF003580), // Button color
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF003580), Color(0xFF005BB5)],
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
