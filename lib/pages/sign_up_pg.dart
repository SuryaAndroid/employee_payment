
// ignore_for_file: use_build_context_synchronously

import 'package:employee_payment/functions.dart';
import 'package:employee_payment/pages/login_pg.dart';
import 'package:employee_payment/utils/alerts.dart';
import 'package:employee_payment/utils/button.dart';
import 'package:employee_payment/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPg extends StatefulWidget {
  const RegisterPg({Key? key}) : super(key: key);

  @override
  State<RegisterPg> createState() => _RegisterPgState();
}

class _RegisterPgState extends State<RegisterPg> {

  //global
  var email = "";
  var password = "";
  var password2 = "";
  var name = "";
  var showPassword = false;
  var showPassword2 = false;

  //logics
  void validateInputs() {

    hideKeyboard(context);

    if(email.isEmpty) {

      AppAlerts.showToastAlert(context, 'Email is required!');

    }else if(password.isEmpty) {

      AppAlerts.showToastAlert(context, 'Password is required!');

    } else if(password2.isEmpty) {

      AppAlerts.showToastAlert(context, 'Confirm Password is required!');

    }else if(password != password2) {

      AppAlerts.showToastAlert(context, 'Passwords are mis-match!');

    } else if(!validMail(email)){

      AppAlerts.showToastAlert(context, 'Email is invalid!');

    } else {
      handleUserRegister();
    }

  }

  void handleUserRegister() async {

    var pr = await SharedPreferences.getInstance();

    var newMail = pr.getString('email')??"";

    if(newMail == email) {
      AppAlerts.showToastAlert(context, 'User already exist please login!');
    } else {
      pr.setString('email', email);
      pr.setString('name', name);
      pr.setString('password', password2);
      AppAlerts.showToastAlert(context, 'User created!');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=>const LoginPg()));
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
                  child: Text('Register\nAccount',style:TextStyle(
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
                    name = val;
                  });
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                hintText: "Enter name",
                prefixIcon: Icon(Icons.account_circle),
              )),


              const SizedBox(height:20,),

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

               const SizedBox(height:20,),

              // password
              TextField(
                onChanged: (val){
                  setState(() {
                    password2 = val;
                  });
                },
                obscureText: showPassword2,
                decoration: InputDecoration(
                hintText: "Confirm password",
                prefixIcon: const Icon(Icons.key),
                suffixIcon: GestureDetector(
                  onTap: (){
                    setState(() {
                      showPassword2 = !showPassword2;
                    });
                  },
                  child: Icon(showPassword2 ? Icons.visibility : Icons.visibility_off)
                )
              )),

              const SizedBox(height:50,),

              Button(
                title: "REGISTER",
                onTap: (){
                  validateInputs();
                },
              ),

              GestureDetector(
                onTap: (){
                  Navigator.pop(context);                  
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical:20),
                  alignment: Alignment.center,
                  child: Text('Back to Login',style:TextStyle(
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
