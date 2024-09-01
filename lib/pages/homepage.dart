import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:mbaadmin/MbaUser.dart';
import 'package:mbaadmin/elements/colors.dart';
import 'package:mbaadmin/elements/mbabutton.dart';
import 'package:mbaadmin/helpers/authHelper.dart';
import 'package:mbaadmin/pages/reservationWidget.dart';
import 'package:mbaadmin/pages/userPage.dart';
import 'adddatapage.dart';


class HomePage extends StatefulWidget {

  const HomePage({super.key,});

  static final  String id = 'home';

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {

  Future<MbaUser?> user = AuthHelper.loadLoggedUserData(FirebaseAuth.instance.currentUser!.uid);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: FutureBuilder<MbaUser?>(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    MbaUser user = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          //header
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Row(
                              children: [
                                ClipOval(
                                    child: Container(
                                        height:50,
                                        width:50,
                                        child: Image.network(user.imageUrl)
                                    )
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(user.name),
                                    Text(user.type),
                                  ],
                                ),
                                IconButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> UserPage(user: user)));
                                }, icon: Icon(FontAwesome.pencil_solid),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Text(DateFormat('EEEE, MMMM d, yyyy  HH:mm').format(DateTime.now()).toString(), textAlign: TextAlign.end,),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: MbaButton(
                                callback: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddDataPage()));
                                },
                                bgColor: MbaColors.red,
                                text: 'Əlavə et'),
                          ),
                          ReservationWidget(),
                        ],
                      ),
                    );
                  } else {
                    return Center(child: Text('No data'));
                  }
                },
            ),
          ),
        ),
      );
  }
}
