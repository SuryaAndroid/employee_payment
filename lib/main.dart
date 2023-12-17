import 'package:employee_payment/pages/login_pg.dart';
import 'package:employee_payment/utils/styles.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData(
        primarySwatch:primarySwatch(AppColors.primary)
      ),
      home:const LoginPg(),
    );
  }
}

