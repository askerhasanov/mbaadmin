import 'package:flutter/material.dart';
import 'package:mbaadmin/elements/colors.dart';
import 'package:mbaadmin/elements/mbabutton.dart';
import 'package:mbaadmin/pages/addDataElements/addMoto.dart';
import 'package:mbaadmin/pages/addDataElements/addNews.dart';
import 'package:mbaadmin/pages/addDataElements/addTutor.dart';


class AddDataPage extends StatefulWidget {
  const AddDataPage({super.key});

  @override
  State<AddDataPage> createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 60,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: MbaColors.darkRed
                ),
                child: Center(child: Text('ƏLAVƏ ET', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Column(
                    children: [
                      //xeber
                      MbaButton(callback: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddNews()));
                      }, bgColor: MbaColors.red, text: 'Xəbər'),
                      SizedBox(height: 10,),
                      //tutor
                      MbaButton(callback: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddTutor()));
                      }, bgColor: MbaColors.red, text: 'Müəllim'),
                      SizedBox(height: 10,),
                      //moto
                      MbaButton(callback: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddMoto()));
                      }, bgColor: MbaColors.red, text: 'Moto'),
                      SizedBox(height: 10,),
                      //event
                      MbaButton(callback: (){}, bgColor: MbaColors.red, text: 'Tədbir'),
                      SizedBox(height: 10,),
                      //course
                      MbaButton(callback: (){}, bgColor: MbaColors.red, text: 'Kurs'),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}
