import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:mbaadmin/elements/dropDownFormField.dart';
import 'package:mbaadmin/elements/formfield.dart';
import 'package:mbaadmin/elements/mbabutton.dart';
import 'package:mbaadmin/elements/uiHelpers.dart';
import 'package:mbaadmin/helpers/addHelper.dart';
import '../../elements/colors.dart';


class AddTutor extends StatefulWidget {
  const AddTutor({super.key});

  @override
  State<AddTutor> createState() => _AddTutorState();
}

class _AddTutorState extends State<AddTutor> {


  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController fullNameCont = TextEditingController();

  late SingleValueDropDownController typeCont;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    typeCont = SingleValueDropDownController();
  }

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
                child: Center(child: Text('Müəllim əlavə et', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    MbaTextField(controller: emailCont, label: 'Email', hint: 'Email',isLarge: false,),
                    MbaTextField(controller: passwordCont, label: 'Şifrə', hint: '*********', isLarge: false,),
                    MbaTextField(controller: fullNameCont, label: 'Ad Soyad', hint: 'Ad Soyad', isLarge: false,),
                    DropDownFormField(title: 'Rol', hint: '', controller: typeCont, map: {
                      'Əsas Admin' : 'master',
                      'Müəllim' : 'tutor'
                    }),
                    MbaButton(callback: () async {
                      var result = await AddHelper().addTutor(context, emailCont.text, passwordCont.text, fullNameCont.text, typeCont.dropDownValue!.value);
                      if(result == 'success'){
                        UiHelpers.showSnackBar(context, 'Müəllim uğurla əlavə edildi!');
                        emailCont.clear();
                        passwordCont.clear();
                        fullNameCont.clear();
                        typeCont.clearDropDown();
                      }else{
                        UiHelpers.showSnackBar(context, result);
                      }
                    }, bgColor: MbaColors.darkRed, text: 'Müəllim əlavə et')
                  ],
                ),
              )
            ],
          )
      ),
    );
  }
}
