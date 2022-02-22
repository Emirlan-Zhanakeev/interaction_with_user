import 'package:flutter/material.dart';
import 'package:registration_remake/model/user.dart';

// ignore_for_file: prefer_const_constructors
// ignore: avoid_print/**/
// ignore_for_file: avoid_print

class UserInfoPage extends StatelessWidget {

  User userInfo;
  UserInfoPage({required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User info'),
        centerTitle: true,
      ),
      body: Card(
        margin: EdgeInsets.all(16.0),
        child: Column(
          children:  [
            ListTile(
              title: Text(
                '${userInfo.firstName}',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text('${userInfo.lastName}'),
              leading: Icon(
                Icons.person,
                color: Colors.black,
              ),
              trailing: Text('${userInfo.account}'),
            ),
            ListTile(
              title: Text(
                '${userInfo.email}',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: Icon(
                Icons.mail,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15),
            ListTile(
              title: Text(
                '+996 ${userInfo.phone}',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: Icon(
                Icons.phone,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
