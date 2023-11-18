import 'package:flutter/material.dart';
import 'package:login_alam_api/auth_utility.dart';

class LoginDetails extends StatefulWidget {
  const LoginDetails({super.key});

  @override
  State<LoginDetails> createState() => _LoginDetailsState();
}

class _LoginDetailsState extends State<LoginDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AuthUtility.userInfo.payload!.user!.name.toString()),
          Text(AuthUtility.userInfo.payload!.user!.id.toString()),          // Text(AuthUtility.userInfo.data!.lastName.toString()),
          Text(AuthUtility.userInfo.payload!.user!.email.toString()),          // Text(AuthUtility.userInfo.data!.lastName.toString()),
          Text(AuthUtility.userInfo.payload!.user!.createdAt.toString()),          // Text(AuthUtility.userInfo.data!.lastName.toString()),
        

        ],
      ),
    );
  }
}