import 'package:flutter/material.dart';
import 'package:mbaadmin/elements/colors.dart';

class ProgressDialog extends StatelessWidget {

  final String status;

  const ProgressDialog({super.key,
    required this.status
  });



  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(16.0),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0)
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              const SizedBox(width: 5,),
              const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(MbaColors.red,)),
              const SizedBox(width: 25.0,),
              Text(status, style: const TextStyle(fontSize: 15),),
            ],
          ),
        ),
      ),
    );
  }
}
