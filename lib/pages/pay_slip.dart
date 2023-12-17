import 'package:employee_payment/utils/alerts.dart';
import 'package:employee_payment/utils/button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaySlip extends StatefulWidget {
  const PaySlip({ Key? key }) : super(key: key);

  @override
  PaySlipState createState() => PaySlipState();
}

class PaySlipState extends State<PaySlip> {

  var payment = [
    {
      'title':'Basic',
      'amount':'10,000'
    },
    {
      'title':'Dearness allowance',
      'amount':'500'
    },
    {
      'title':'House rent allowance',
      'amount':'500'
    },
    {
      'title':'Medical allowance',
      'amount':'2000'
    },
    {
      'title':'Special',
      'amount':'1000'
    },
    {
      'title':'Other tax',
      'amount':'-100'
    },
  ];

  //global
  var name = "";

  @override
  void initState() {
    // TODO: implement initState
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
        title:const Text('Payslip'),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding:const EdgeInsets.all(10),
        child:Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
          Text('Name : $name',style:TextStyle(
            fontSize:size.height*0.022
          ),),
          const SizedBox(height:15,),
          Text('Desigination : App developer',style:TextStyle(
            fontSize:size.height*0.022
          ),),
          const SizedBox(height:15,),
          Expanded(child: ListView.builder(
            itemCount:payment.length,
            shrinkWrap: true,
            itemBuilder: (c,i){
              return ListTile(
                title:Text('${payment[i]['title']}'),
                trailing:Text('Rs.${payment[i]['amount']}',style:TextStyle(
                fontSize: size.height*0.02,
                fontWeight: FontWeight.bold
              ),),
              );
            },
          )),
          Container(
            padding: const EdgeInsets.all(15),
            child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,  
            children: [
              Text('Total',style:TextStyle(
                fontSize: size.height*0.022
              ),),
              Text('13,900',style:TextStyle(
                fontSize: size.height*0.022,
                fontWeight: FontWeight.bold
              ),),
            ]),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child:Button(
              onTap: (){
                AppAlerts.showToastAlert(context, 'Coming soon!');
              },
              title:"Print...",
            ),
          )
        ]),
      ),
    );
  }
}