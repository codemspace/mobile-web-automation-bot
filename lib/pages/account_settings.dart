import 'package:flutter/material.dart';
import '../base_page.dart';
import 'profile_page.dart';
import 'security_settings.dart';
import 'privacy_settings.dart';
import 'other_travelers.dart';
import 'payment_details_overview.dart';

class AccountSetting extends StatefulWidget {
  @override
  _AccountSettingState createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Account settings',
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          buildCard(
            context,
            icon: Icons.person,
            title: 'Personal details',
            description: 'Update your info and find out how it\'s used.',
            linkText: 'Manage personal details',
            destination: PersonalDetailsPage(),
          ),
          buildCard(
            context,
            icon: Icons.lock,
            title: 'Security',
            description: 'Change your security settings, set up secure authentication, or delete your account.',
            linkText: 'Manage account security',
            destination: SecuritySettingsPage(), // Change to appropriate page when available
          ),
          buildCard(
            context,
            icon: Icons.privacy_tip,
            title: 'Privacy',
            description: 'Exercise your privacy rights and control how your data is used.',
            linkText: 'Manage privacy',
            destination: PrivacySettingsPage(), // Change to appropriate page when available
          ),
          buildCard(
            context,
            icon: Icons.payment,
            title: 'Payment details',
            description: 'Securely add or remove payment methods to make it easier when you book.',
            linkText: 'Manage payment details',
            destination: PaymentDetailsOverviewPage(),
          ),
          buildCard(
            context,
            icon: Icons.group,
            title: 'Other travelers',
            description: 'Add or edit info about the people you’re traveling with.',
            linkText: 'Manage travelers',
            destination: OtherTravelersPage(), // Change to appropriate page when available
          ),
        ],
      ),
    );
  }

  Widget buildCard(BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required String linkText,
    required Widget destination,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      linkText,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}