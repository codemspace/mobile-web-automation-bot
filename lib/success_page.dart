import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  final Map<String, dynamic> userInfo;

  SuccessPage({required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Information'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${userInfo['name']}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Nickname: ${userInfo['nickname']}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Email: ${userInfo['email']}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Phone: ${userInfo['phone']}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Date of Birth: ${userInfo['dateOfBirth']}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Nationality: ${userInfo['nationality']}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Gender: ${userInfo['gender']}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Address: ${userInfo['address']}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Passport: ${userInfo['passport']}', style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
