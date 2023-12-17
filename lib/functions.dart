import 'package:flutter/material.dart';

//hide keyboard
void hideKeyboard(BuildContext context){
  FocusScope.of(context).unfocus();
}

//check entered mail is mail or not
bool validMail(String email){
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}