import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:mbaadmin/helpers/authHelper.dart';
import '../../elements/mbabutton.dart';
import '../../elements/mbadivider.dart';
import '../../elements/uiHelpers.dart';


class LoginPage extends StatefulWidget {

  static final  String id = 'login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{

  TabController? _tabController;
  bool _remindMe = false;
  bool _obscureText = true;

  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children:[
                  SizedBox(height: 80,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Giriş',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 40,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text('Moto Baku Akademi admin, müəllim girişi',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 300,
                          child: _buildEmailLogin(emailController, passwordController),
                        ),
                      ],
                    ),
                  ),
                  //rememberme
                  Row(
                    children: [
                      Checkbox(
                        value: _remindMe,
                        onChanged: (value) {
                          setState(() {
                            _remindMe = value!;
                          });
                        },
                      ),
                      Text('Məni xatırla', ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          // Forgot password action
                        },
                        child: Text('Şifrənizi unutmusunuz?',),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  MbaDivider(text: 'və ya', lineColor: Colors.red),
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(shape: CircleBorder()),
                          onPressed: (){
                            UiHelpers.showSnackBar(context, 'Google login gələcəkdə əlavə ediləcəkdir.');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Brand(Brands.google),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(shape: CircleBorder()),
                          onPressed: (){
                            UiHelpers.showSnackBar(context, 'Apple login gələcəkdə əlavə ediləcəkdir.');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Brand(Brands.apple_logo),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
              ),
            ),
          )
      ),
    );
  }

  Widget _buildEmailLogin(TextEditingController email, TextEditingController password) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
              'Emailiniz',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        TextField(
          controller: email,
          decoration: InputDecoration(
            hintText: 'example@mail.com',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            'Şifrəniz',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        TextField(
          obscureText: _obscureText,
          controller: password,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: "************",
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),),
        ),
        SizedBox(height: 20,),
        MbaButton(callback: (){AuthHelper().loginUser(context, email.text, password.text);}, bgColor: Colors.red, text: 'Daxil ol')
      ],
    );
  }
}

