import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:login_alam_api/auth_utility.dart';
import 'package:login_alam_api/login_details.dart';
import 'package:login_alam_api/login_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  

  @override
  
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool loginInProgress = false;
  @override
  void initState() {
    // TODO: implement initState
    
  }
  void login() async {
    loginInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Response response =
        await post(Uri.parse("https://rm.guideasy.com/api/login"),
            headers: {
              "Content-Type": "application/vnd.api+json",
              "Accept":"application/vnd.api+json",
            },
            body: jsonEncode({
              "email": _emailController.text,
              "password": _passwordController.text,
            }));
    loginInProgress = false;
    if (mounted) {
      setState(() {});
    }
   
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
       //Map<String,dynamic> decodeBody = jsonDecode(response.body);
      LoginModel model = LoginModel.fromJson((jsonDecode(response.body)));
      await AuthUtility.saveUserInfo(model);
      print("From Auth Utility");
      print(AuthUtility.userInfo.payload!.user!.name.toString());
      print(AuthUtility.userInfo.payload!.token..toString());
      
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginDetails()));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _emailController,
          ),
          TextField(
            controller: _passwordController,
          ),
          Visibility(
            visible: loginInProgress==false,
            replacement: Center(child: CircularProgressIndicator(),),
            child: TextButton(
                onPressed: () {
                  login();
                  setState(() {});
                },
                child: Text("Login")),
          )
        ],
      ),
    );
  }
}
