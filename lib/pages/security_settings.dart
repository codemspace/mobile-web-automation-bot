import 'package:flutter/material.dart';
import '../base_page.dart';

class SecuritySettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Security',
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Text(
            'Security',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Change your security settings, set up secure authentication, or delete your account.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 32),
          Divider(),
          buildSecurityOption(
            context,
            title: 'Password',
            description: 'Reset your password regularly to keep your account secure',
            actionText: 'Reset',
            onTap: () {
              // Handle Password reset
            },
          ),
          Divider(),
          buildSecurityOption(
            context,
            title: 'Two-factor authentication',
            description: 'Increase your account\'s security by setting up two-factor authentication.',
            actionText: 'Set up',
            onTap: () {
              // Handle Two-factor authentication setup
            },
          ),
          Divider(),
          buildSecurityOption(
            context,
            title: 'Active sessions',
            description: 'Selecting "Sign out" will sign you out from all devices except this one. This can take up to 10 minutes.',
            actionText: 'Sign out',
            onTap: () {
              // Handle sign out from all devices
            },
          ),
          Divider(),
          buildSecurityOption(
            context,
            title: 'Delete account',
            description: 'Permanently delete your Booking.com account',
            actionText: 'Delete account',
            onTap: () {
              // Handle account deletion
            },
          ),
        ],
      ),
    );
  }

  Widget buildSecurityOption(BuildContext context, {
    required String title,
    required String description,
    required String actionText,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          GestureDetector(
            onTap: onTap,
            child: Text(
              actionText,
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
