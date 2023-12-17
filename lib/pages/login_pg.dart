// ignore_for_file: use_build_context_synchronously

import 'package:employee_payment/functions.dart';
import 'package:employee_payment/pages/home_pg.dart';
import 'package:employee_payment/pages/sign_up_pg.dart';
import 'package:employee_payment/utils/alerts.dart';
import 'package:employee_payment/utils/button.dart';
import 'package:employee_payment/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPg extends StatefulWidget {
  const LoginPg({Key? key}) : super(key: key);

  @override
  State<LoginPg> createState() => _LoginPgState();
}

class _LoginPgState extends State<LoginPg> {

  //global
  var email = "";
  var password = "";
  var showPassword = false;

  //logics
  void validateInputs() {

    hideKeyboard(context);

    if(email.isEmpty) {

      AppAlerts.showToastAlert(context, 'Email is required!');

    }else if(password.isEmpty) {

      AppAlerts.showToastAlert(context, 'Password is required!');

    } else if(!validMail(email)){

      AppAlerts.showToastAlert(context, 'Email is invalid!');

    } else if(email != "surya@test.in" && password != "123456") {

      AppAlerts.showToastAlert(context, 'Invalid email / password!');

    } else {
      handleUserLogin();
    }

  }

  void handleUserLogin() async {

    var pr = await SharedPreferences.getInstance();

    var newMail = pr.getString('email')??"";
    var newPassword = pr.getString('password')??"";

    if(newMail == "") {
      AppAlerts.showToastAlert(context, 'No user found!');
    } else if(email != newMail || password != newPassword){
      AppAlerts.showToastAlert(context, 'Mail / Password invalid!');
    }else {
      AppAlerts.showToastAlert(context, 'Login success!');
      //push to home
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=>const HomePg()));
    }

  }

  @override
  Widget build(BuildContext context) {
    // device size...
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Login to\ncontinue',style:TextStyle(
                    color:Colors.black,
                    fontSize: size.height*0.03,
                    fontWeight: FontWeight.bold
                  ),),
                ),
              ),

              const SizedBox(height:50,),

              // email
              TextField(
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                hintText: "Enter email",
                helperText: (email.isNotEmpty&&!validMail(email))?"Invalid email":null,
                prefixIcon: const Icon(Icons.email),
                helperStyle: const TextStyle(color:Colors.red)
              )),


              const SizedBox(height:20,),
              // password
              TextField(
                onChanged: (val){
                  setState(() {
                    password = val;
                  });
                },
                obscureText: showPassword,
                decoration: InputDecoration(
                hintText: "Enter password",
                prefixIcon: const Icon(Icons.key),
                suffixIcon: GestureDetector(
                  onTap: (){
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  child: Icon(showPassword ? Icons.visibility : Icons.visibility_off)
                )
              )),


              Container(
                padding: const EdgeInsets.symmetric(vertical:20),
                alignment: Alignment.centerRight,
                child: Text('Forgot password',style:TextStyle(
                  color:AppColors.primary,
                  fontSize:size.height*0.022
                ),),
              ),

              const SizedBox(height:50,),

              Button(
                title: "LOGIN",
                onTap: (){
                  validateInputs();
                },
              ),

              GestureDetector(
                onTap: (){

                  Navigator.push(context, MaterialPageRoute(builder: (c)=>const RegisterPg()));
                  
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical:20),
                  alignment: Alignment.center,
                  child: Text('New user?',style:TextStyle(
                    color:AppColors.primary,
                    fontSize:size.height*0.022
                  ),),
                ),
              ),


            ],
          ),
        ),
      ),
    ));
  }
}
