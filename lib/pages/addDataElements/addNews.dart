import 'package:flutter/material.dart';
import 'package:mbaadmin/elements/formfield.dart';
import 'package:mbaadmin/elements/mbabutton.dart';
import 'package:mbaadmin/elements/uiHelpers.dart';
import 'package:mbaadmin/helpers/addHelper.dart';

import '../../elements/colors.dart';


class AddNews extends StatefulWidget {
  const AddNews({super.key});

  @override
  State<AddNews> createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {


  TextEditingController titleCont = TextEditingController();
  TextEditingController imageUrlCont = TextEditingController();
  TextEditingController textCont = TextEditingController();


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
                child: Center(child: Text('Xəbər əlavə et', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),)),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    MbaTextField(controller: titleCont, label: 'Başlıq', hint: 'Başlıq',isLarge: false,),
                    MbaTextField(controller: imageUrlCont, label: 'Şəkil linki', hint: 'http://photourl.com', isLarge: false,),
                    MbaTextField(controller: textCont, label: 'Mətn', hint: 'Mətin', isLarge: true,),

                    MbaButton(callback: () async {
                      var result = await AddHelper().addNews(context, titleCont.text, imageUrlCont.text, textCont.text);
                      if(result == 'added'){
                        UiHelpers.showSnackBar(context, 'Xəbər uğurla əlavə edildi!');
                        titleCont.clear();
                        imageUrlCont.clear();
                        textCont.clear();
                      }else{
                        UiHelpers.showSnackBar(context, 'Xəbər əlavə edilərkən xəta baş verdi!');
                      }
                    }, bgColor: MbaColors.darkRed, text: 'Xəbəri yüklə')
                  ],
                ),
              )
            ],
          )
      ),
    );
  }
}
