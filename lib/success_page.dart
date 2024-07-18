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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('First Name: ${userInfo['firstName']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Last Name: ${userInfo['lastName']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Country: ${userInfo['country']}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Timezone: ${userInfo['timezone']}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
