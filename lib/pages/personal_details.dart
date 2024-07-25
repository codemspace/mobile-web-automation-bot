import 'package:flutter/material.dart';
import '../base_page.dart';
import 'personal_details/edit_image.dart';
import 'personal_details/edit_name.dart';
import 'personal_details/edit_field.dart';
import 'package:email_validator/email_validator.dart';
import '../user/user_data.dart';

class PersonalDetailsPage extends StatefulWidget {
  @override
  _PersonalDetailsPageState createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  final user = UserData.myUser;

  void _updateUserName(String newName) {
    setState(() {
      user.name = newName;
    });
  }

  void _updateUserProfile(String field, String newValue) {
    setState(() {
      switch (field) {
        case 'nickname':
          user.nickname = newValue;
          break;
        case 'email':
          user.email = newValue;
          break;
        case 'phone':
          user.phone = newValue;
          break;
        case 'dateOfBirth':
          user.dateOfBirth = newValue;
          break;
        case 'nationality':
          user.nationality = newValue;
          break;
        case 'gender':
          user.gender = newValue;
          break;
        case 'address':
          user.address = newValue;
          break;
        case 'passport':
          user.passport = newValue;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Personal details',
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          buildProfileImage(),
          SizedBox(height: 16),
          Text(
            'Personal details',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Update your info and find out how it\'s used.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 16),
          Divider(),
          buildUserInfoDisplay(user.name, 'Name', EditNameFormPage(updateNameCallback: _updateUserName)),
          Divider(),
          buildUserInfoDisplay(user.nickname, 'Display name', EditFieldFormPage(
            fieldLabel: 'Display name',
            currentValue: UserData.myUser.nickname,
            onUpdate: (newValue) => _updateUserProfile('nickname', newValue),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your display name.';
              }
              return null;
            },
          )),
          Divider(),
          buildUserInfoDisplay(user.email, 'Email address', EditFieldFormPage(
            fieldLabel: 'Email address',
            currentValue: UserData.myUser.email,
            onUpdate: (newValue) => _updateUserProfile('email', newValue),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email.';
              } else if (!EmailValidator.validate(value)) {
                return 'Please enter a valid email.';
              }
              return null;
            },
          ), additionalInfo: 'This email address isn\'t verified yet, so you can\'t use all your account\'s features. Resend verification email?'),
          Divider(),
          buildUserInfoDisplay(user.phone, 'Phone number', EditFieldFormPage(
            fieldLabel: 'Phone number',
            currentValue: user.phone,
            onUpdate: (newValue) => _updateUserProfile('phone', newValue),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number.';
              }
              return null;
            },
          ), additionalInfo: 'To edit your phone number, add and/or verify your email address'),
          Divider(),
          buildUserInfoDisplay(user.dateOfBirth, 'Date of birth', EditFieldFormPage(
            fieldLabel: 'Date of birth',
            currentValue: user.dateOfBirth,
            onUpdate: (newValue) {
              user.dateOfBirth = newValue;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your date of birth.';
              }
              return null;
            },
          )),
          Divider(),
          buildUserInfoDisplay(user.nationality, 'Nationality', EditFieldFormPage(
            fieldLabel: 'Nationality',
            currentValue: user.nationality,
            onUpdate: (newValue) {
              user.nationality = newValue;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your nationality.';
              }
              return null;
            },
          )),
          Divider(),
          buildUserInfoDisplay(user.gender, 'Gender', EditFieldFormPage(
            fieldLabel: 'Gender',
            currentValue: user.gender,
            onUpdate: (newValue) {
              user.gender = newValue;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your gender.';
              }
              return null;
            },
          )),
          Divider(),
          buildUserInfoDisplay(user.address, 'Address', EditFieldFormPage(
            fieldLabel: 'Address',
            currentValue: user.address,
            onUpdate: (newValue) {
              user.address = newValue;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your address.';
              }
              return null;
            },
          )),
          Divider(),
          buildUserInfoDisplay(user.passport, 'Passport details', EditFieldFormPage(
            fieldLabel: 'Passport details',
            currentValue: user.passport,
            onUpdate: (newValue) {
              user.passport = newValue;
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your passport details.';
              }
              return null;
            },
          )),
        ],
      ),
    );
  }

  Widget buildProfileImage() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[200],
            backgroundImage: AssetImage('assets/images/blank_user.png'), // Placeholder image
          ),
          Positioned(
            bottom: 55,
            right: -10,
            child: IconButton(
              icon: Icon(Icons.camera_alt, color: Colors.grey),
              onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditImagePage()),
                  );
                },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage, {String? additionalInfo}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      getValue,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                    if (additionalInfo != null) ...[
                      SizedBox(height: 4),
                      Text(
                        additionalInfo,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => editPage),
                  );
                },
                child: Text(
                  'Edit',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
