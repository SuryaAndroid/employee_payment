
import 'package:flutter/material.dart';

class AppAlerts {

  static void showToastAlert(BuildContext context,String msg){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Row(children: [
        const Icon(Icons.info_outline,color:Colors.white,),
        Expanded(child: Text('  $msg',style:const TextStyle(
          color:Colors.white
        ),))
      ],),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.black,
      )
    );
  }

}