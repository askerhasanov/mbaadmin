import 'package:flutter/material.dart';
import 'package:mbaadmin/elements/colors.dart';

class UserTextField extends StatefulWidget {
  final String label;
  final String hint;
  final String initialValue;
  final ValueChanged<String> onChanged;
  final bool isLarge;

  const UserTextField({
    Key? key,
    required this.label,
    required this.isLarge,
    required this.hint,
    required this.initialValue,
    required this.onChanged,
  }) :super(key: key);

  @override
  State<UserTextField> createState() => _UserTextFieldState();
}

class _UserTextFieldState extends State<UserTextField> {
  late TextEditingController _controller;
  Color _borderColor = Colors.green;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            widget.label,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        TextField(
          controller: _controller,
          maxLines: widget.isLarge ? 5 : 1,
          decoration: InputDecoration(
            hintText: widget.hint,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:  BorderSide(
                  color: Colors.black,
                  width: 1,
                  style: BorderStyle.solid,
                  strokeAlign: 20
              ),
            ),
            hintStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:  BorderSide(
                  color: _borderColor,
                  width: 2,
                  style: BorderStyle.solid,
                  strokeAlign: 20
              ),
            ),
          ),
          onChanged: (value){
            print('initial : ${widget.initialValue}');
            print('new : ${value}');
            print(widget.initialValue == value);
            setState(() {
              _borderColor = widget.initialValue == value ? Colors.green : MbaColors.red;
            });
            widget.onChanged(value);
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}