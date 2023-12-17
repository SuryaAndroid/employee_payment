
import 'package:employee_payment/pages/login_pg.dart';
import 'package:employee_payment/pages/pay_slip.dart';
import 'package:employee_payment/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePg extends StatefulWidget {
  const HomePg({Key? key}) : super(key: key);

  @override
  State<HomePg> createState() => _HomePgState();
}

class _HomePgState extends State<HomePg> {

  //global
  var name = "";

  @override
  void initState() {
    Future.delayed(Duration.zero , () async {
      var pr = await SharedPreferences.getInstance();
      setState(() {
        name = pr.getString('name')??'';
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // device size...
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding:const EdgeInsets.all(10),
        child: Column(children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(15),
            child: Text('Welcome $name!',style:TextStyle(
              color:Colors.black,
              fontSize: size.height*0.025
            ),),
          ),
          ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (c)=>const PaySlip()));
            },
            leading:Icon(Icons.note,color:AppColors.primary,),
            title: Text('My pay slips',style:TextStyle(
              color:Colors.black,
              fontSize: size.height*0.02
            ),),
            trailing:Icon(
              Icons.arrow_right_rounded,
              color:AppColors.primary,
              size:size.height*0.05,
            )
          ),
          ListTile(
            leading:Icon(Icons.account_circle_sharp,color:AppColors.primary,),
            title: Text('My profile',style:TextStyle(
              color:Colors.black,
              fontSize: size.height*0.02
            ),),
            trailing:Icon(
              Icons.arrow_right_rounded,
              color:AppColors.primary,
              size:size.height*0.05,
            )
          ),
          ListTile(
            onTap: () async {

              var pr = await SharedPreferences.getInstance();

              pr.remove('email');
              pr.remove('name');
              pr.remove('password');

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=>const LoginPg()));


            },
            leading:Icon(Icons.delete,color:AppColors.primary,),
            title: Text('Delete account',style:TextStyle(
              color:Colors.black,
              fontSize: size.height*0.02
            ),),
            trailing:Icon(
              Icons.arrow_right_rounded,
              color:AppColors.primary,
              size:size.height*0.05,
            )
          ),
        ]),
      ),
    );
  }
}