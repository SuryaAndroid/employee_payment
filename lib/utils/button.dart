
import 'package:employee_payment/utils/styles.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget{

  String? title;
  dynamic onTap;

  Button({this.onTap,this.title});

  @override
  Widget build(BuildContext context) {

    // device size...
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: ()=>onTap(),
      child: Container(
        height:50,
        alignment: Alignment.center,
        width:size.width,
        decoration:BoxDecoration(
          color: AppColors.primary,
          borderRadius:BorderRadius.circular(25),
        ),
        child:Text('$title',style:TextStyle(
          color:Colors.white,
          fontSize: size.height*0.022
        ),),
      ),
    );
  }
}