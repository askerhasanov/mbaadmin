import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mbaadmin/elements/colors.dart';
import 'package:mbaadmin/elements/formfield.dart';
import 'package:mbaadmin/elements/formfield2.dart';
import 'package:mbaadmin/elements/uiHelpers.dart';

import '../MbaUser.dart';

class UserPage extends StatefulWidget {
  final MbaUser user;

  const UserPage({
    Key? key,
    required this.user
  }) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  late MbaUser _user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = widget.user;
  }


  TextEditingController nameChangeCont = TextEditingController();
  TextEditingController emailChangeCont = TextEditingController();
  TextEditingController expChangeCont = TextEditingController();
  TextEditingController motoChangeCont = TextEditingController();
  TextEditingController bioChangeCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: MbaColors.red,
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(FontAwesome.arrow_left_solid, color: Colors.white,)),
        title: const Text('Mənim Profilim', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(_user.imageUrl),
              child: ClipOval(child: Container(color: Colors.grey.withAlpha(100),child: IconButton(onPressed: (){
                showDialog(context: context, builder: (context){
                  TextEditingController cont = TextEditingController();
                  return AlertDialog(
                    title: Text('Şəkili dəyiş'),
                    content: Container(
                      height: 90,
                      child: Column(
                        children: [
                          MbaTextField(controller: cont, label: 'Şəkil linkini daxil edin:', hint: 'https://sekil.linki', isLarge: false),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Text('Imtina')),
                      TextButton(onPressed: (){
                        setState(() {
                          _user.imageUrl = cont.text;
                        });
                        Navigator.pop(context);
                      }, child: Text('Təsdiq')),
                    ],
                  );
                });
              },icon: Icon(FontAwesome.camera_solid, color: Colors.white,)))),
            ),
            const SizedBox(height: 20),
            UserTextField(label: 'Ad Soyad', hint: 'Tam ad', isLarge: false, initialValue: _user.name, onChanged: (value) {
              bioChangeCont.text = value;
            }),
            UserTextField(label: 'Email', hint: 'username@mail.com', isLarge: false, initialValue: _user.email, onChanged: (value){
              emailChangeCont.text = value;
            }),
            UserTextField(label: 'Haqqında', hint: 'Haqqında', initialValue: _user.bio, isLarge: true, onChanged: (value){
              bioChangeCont.text = value;
            }),
            UserTextField(label: 'Təcrübə', hint: 'təcrübə', initialValue: _user.exp, isLarge: false, onChanged: (value){
              expChangeCont.text = value;
            }),
            UserTextField(label: 'Motosikl', hint: 'Marka model', initialValue: _user.moto, isLarge: false, onChanged: (value){
              motoChangeCont.text = value;
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Dillər',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _user.isAddingNewLanguage = true;
                    });
                  },
                  child: const Text('+', style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _user.lang.length,
              itemBuilder: (context, index) {
                final language = _user.lang[index];
                return ListTile(
                  title: Text(language),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _user.lang.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
        if (_user.isAddingNewLanguage)
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _user.newLanguageController,
                    decoration: InputDecoration(
                    hintText: 'Bildiyiniz dili daxil edin',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:  BorderSide(
                          color: Colors.red,
                          width: 2,
                          style: BorderStyle.solid,
                          strokeAlign: 20
                      ),
                    ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:  BorderSide(
                            color: MbaColors.red,
                            width: 2,
                            style: BorderStyle.solid,
                            strokeAlign: 20
                        ),
                      ),
                  ),
                ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final newLanguage = _user.newLanguageController.text;
                    if(newLanguage.isNotEmpty){
                      setState(() {
                        _user.lang.add(newLanguage);
                        _user.newLanguageController.clear();
                        _user.isAddingNewLanguage = false;
                      });
                    }else{
                      UiHelpers.showSnackBar(context, 'Dili düzgün daxil edin.');
                    }

                  },
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement save functionality
              },
              child: const Text('Yadda Saxla'),
            ),
          ],
        ),
      ),
    );
  }
}