import 'package:flutter/material.dart';
import 'package:mbaadmin/elements/formfield.dart';
import 'package:mbaadmin/elements/mbabutton.dart';
import 'package:mbaadmin/elements/uiHelpers.dart';
import 'package:mbaadmin/helpers/addHelper.dart';

import '../../elements/colors.dart';


class AddMoto extends StatefulWidget {
  const AddMoto({super.key});

  @override
  State<AddMoto> createState() => _AddMotoState();
}

class _AddMotoState extends State<AddMoto> {


  TextEditingController image1Cont = TextEditingController();
  TextEditingController image2Cont = TextEditingController();
  TextEditingController image3Cont = TextEditingController();

  TextEditingController makerCont = TextEditingController();
  TextEditingController modelCont = TextEditingController();
  TextEditingController engineCont = TextEditingController();

  TextEditingController yearCont = TextEditingController();
  TextEditingController tripCont = TextEditingController();
  TextEditingController priceCont = TextEditingController();

  TextEditingController aboutCont = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: MbaColors.darkRed
                  ),
                  child: Center(child: Text('Motosiklet əlavə et', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),)),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      MbaTextField(controller: image1Cont, label: 'Şəkil linki 1', hint: 'http://photourl.com', isLarge: false,),
                      MbaTextField(controller: image2Cont, label: 'Şəkil linki 2', hint: 'http://photourl.com', isLarge: false,),
                      MbaTextField(controller: image3Cont, label: 'Şəkil linki 3', hint: 'http://photourl.com', isLarge: false,),
            
                      MbaTextField(controller: makerCont, label: 'Marka', hint: 'marka', isLarge: false,),
                      MbaTextField(controller: modelCont, label: 'Model', hint: 'model', isLarge: false,),
                      MbaTextField(controller: engineCont, label: 'Mühərrik həcmi', hint: '0000 cc', isLarge: false,),
            
                      MbaTextField(controller: yearCont, label: 'İstehsal ili', hint: '2024', isLarge: false,),
                      MbaTextField(controller: tripCont, label: 'Yürüş', hint: 'km', isLarge: false,),
                      MbaTextField(controller: priceCont, label: 'Qiymət(azn)', hint: '11111', isLarge: false,),
                      MbaTextField(controller: aboutCont, label: 'Haqqında', hint: 'Motor haqqında bir neçə cümlə', isLarge: true,),

            
                      MbaButton(callback: () async {
            
                        if(image1Cont.text.isEmpty || image2Cont.text.isEmpty || image3Cont.text.isEmpty ||
                            makerCont.text.isEmpty || modelCont.text.isEmpty || engineCont.text.isEmpty ||
                            yearCont.text.isEmpty || tripCont.text.isEmpty || priceCont.text.isEmpty || aboutCont.text.isEmpty){
                          UiHelpers.showSnackBar(context, 'Məlumatlar boş ola bilməz!');
                        }else{
                          var result = await AddHelper().addMoto(context, image1Cont.text, image2Cont.text, image3Cont.text, makerCont.text,
                              modelCont.text, engineCont.text, yearCont.text, tripCont.text, priceCont.text, aboutCont.text);
                          if(result == 'added'){
                            UiHelpers.showSnackBar(context, 'Moto uğurla əlavə edildi!');
                            image1Cont.clear();image2Cont.clear();image3Cont.clear();
                            makerCont.clear();modelCont.clear();engineCont.clear();
                            yearCont.clear();tripCont.clear();priceCont.clear();aboutCont.clear();
                          }else{
                            UiHelpers.showSnackBar(context, 'Moto əlavə edilərkən xəta baş verdi!');
                          }
                        }
                      }, bgColor: MbaColors.darkRed, text: 'Motonu yüklə'),

                      SizedBox(height: 50,),
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
