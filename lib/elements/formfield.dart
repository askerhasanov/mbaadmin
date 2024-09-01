import 'package:flutter/material.dart';


class MbaTextField extends StatefulWidget {

  final TextEditingController controller;
  final String label;
  final String hint;
  final bool isLarge;


  const MbaTextField({super.key, required this.controller, required this.label, required this.hint, required this.isLarge});

  @override
  State<MbaTextField> createState() => _MbaTextFieldState();
}

class _MbaTextFieldState extends State<MbaTextField> {
  @override
  Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              widget.label,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Container(
            height: widget.isLarge ? 200 : 40,
            child: TextField(
              controller: widget.controller,
              cursorColor: Colors.red,
              maxLines: widget.isLarge ? 10 : 1,
              decoration: InputDecoration(
                  hintText: widget.hint,
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: Colors.red,
                          width: 1,
                          style: BorderStyle.solid
                      )
                  ),
                  isDense: true
              ),
            ),
          ),
          SizedBox(height: 10,),
        ],
      );
  }
}
