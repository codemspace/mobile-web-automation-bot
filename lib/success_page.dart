import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  final Map<String, dynamic> userInfo;

  SuccessPage({required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${userInfo['name'] == "Let us know what to call you" ? "" : userInfo['name']}', style: TextStyle(fontSize: 18)),
              // SizedBox(height: 8),
              // Text('Nickname: ${userInfo['nickname'] == "Choose a display name" ? "" : userInfo['nickname']}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Email: ${userInfo['email']}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Phone: ${userInfo['phone']}', style: TextStyle(fontSize: 18)),
              // SizedBox(height: 8),
              // Text('Date of Birth: ${userInfo['dateOfBirth'] == "Enter your date of birth" ? "" : userInfo['dateOfBirth']}', style: TextStyle(fontSize: 18)),
              // SizedBox(height: 8),
              // Text('Nationality: ${userInfo['nationality'] == "Select the country/region you're from" ? "" : userInfo['nationality']}', style: TextStyle(fontSize: 18)),
              // SizedBox(height: 8),
              // Text('Gender: ${userInfo['gender'] == "Select your gender" ? "" : userInfo['gender']}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Primary Address: ${userInfo['primaryAddress'] == "Add your address" ? "" : userInfo['primaryAddress']}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Mailing Address: ${userInfo['mailingAddress'] == "Add your address" ? "" : userInfo['mailingAddress']}', style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
