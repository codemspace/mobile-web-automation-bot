import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final String title;
  final Widget child;

  BasePage({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF003580), 
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                'Booking.com',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () => _showAccountModal(context),
                  child: Icon(Icons.account_circle, color: Colors.white),
                ),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () => _showMenuModal(context),
                  child: Icon(Icons.menu, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
      body: child,
    );
  }

  void _showAccountModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: [
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Manage account'),
              onTap: () {}, 
            ),
            ListTile(
              leading: Icon(Icons.card_travel),
              title: Text('Trips'),
              onTap: () {}, 
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Genius loyalty program'),
              onTap: () {}, 
            ),
            ListTile(
              leading: Icon(Icons.wallet_giftcard),
              title: Text('Rewards & Wallet'),
              onTap: () {}, 
            ),
            ListTile(
              leading: Icon(Icons.comment),
              title: Text('Reviews'),
              onTap: () {}, 
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Saved'),
              onTap: () {}, 
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sign out'),
              onTap: () {}, 
            ),
          ],
        );
      }
    );
  }

  void _showMenuModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: ListTile.divideTiles(
            context: context,
            tiles: [
              ListTile(
                leading: Icon(Icons.monetization_on),
                title: Text('U.S. dollar'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.language),
                title: Text('American English'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.help_outline),
                title: Text('Help and support'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.gavel),
                title: Text('Dispute resolution'),
                onTap: () {},
              ),
            ],
          ).toList(),
        );
      }
    );
  }
}
