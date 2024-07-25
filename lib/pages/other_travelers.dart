import 'package:flutter/material.dart';
import '../base_page.dart';
import 'add_traveler.dart';

class OtherTravelersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Other travelers',
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Text(
            'Other travelers',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Add or edit info about the people you’re traveling with.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddTravelerPage()),
                );
              },
              icon: Icon(Icons.add),
              label: Text('Add new traveler'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF003580),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
