import 'dart:async';
import 'package:flutter/material.dart';
import '../base_page.dart';
import 'personal_details/edit_image.dart';
import 'personal_details/edit_name.dart';
import 'personal_details/edit_phone.dart';
import 'personal_details/edit_field.dart';
import 'package:email_validator/email_validator.dart';
import '../widgets/display_image_widget.dart';
import '../user/user_data.dart';

// This class handles the Page to display the user's info on the "Edit Profile" Screen
class PersonalDetailsPage extends StatefulWidget {
  @override
  _PersonalDetailsPageState createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final user = UserData.myUser;

    return BasePage(
      title: 'Personal Details',
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'Personal Details',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(64, 105, 225, 1),
                ),
              ),
            ),
          ),
          Center(
            child: InkWell(
              onTap: () {
                navigateSecondPage(EditImagePage());
              },
              child: DisplayImage(
                imagePath: user.image,
                onPressed: () {},
              ),
            ),
          ),
          SizedBox(height: 20),
          buildUserInfoDisplay(user.name, 'Name', EditNameFormPage()),
          buildUserInfoDisplay(
            user.nickname,
            'Nickname',
            EditFieldFormPage(
              fieldLabel: 'Nickname',
              currentValue: UserData.myUser.nickname,
              onUpdate: (newValue) {
                UserData.myUser.nickname = newValue;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your nickname.';
                }
                return null;
              },
            ),
          ),
          buildUserInfoDisplay(user.phone, 'Phone', EditPhoneFormPage()),
          buildUserInfoDisplay(
            user.email,
            'Email',
            EditFieldFormPage(
              fieldLabel: 'Email',
              currentValue: UserData.myUser.email,
              onUpdate: (newValue) {
                UserData.myUser.email = newValue;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email.';
                } else if (!EmailValidator.validate(value)) {
                  return 'Please enter a valid email.';
                }
                return null;
              },
            ),
          ),
          buildUserInfoDisplay(
            user.dateOfBirth,
            'Date of Birth',
            EditFieldFormPage(
              fieldLabel: 'Date of Birth',
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
            ),
          ),
          buildUserInfoDisplay(
            user.gender,
            'Gender',
            EditFieldFormPage(
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
            ),
          ),
          buildUserInfoDisplay(
            user.address,
            'Address',
            EditFieldFormPage(
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
            ),
          ),
          buildUserInfoDisplay(
            user.passport,
            'Passport',
            EditFieldFormPage(
              fieldLabel: 'Passport',
              currentValue: user.passport,
              onUpdate: (newValue) {
                user.passport = newValue;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your passport.';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 1,
            ),
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        navigateSecondPage(editPage);
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          getValue,
                          style: TextStyle(fontSize: 16, height: 1.4),
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                    size: 40.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  // Refreshes the Page after updating user info.
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
