import 'package:flutter/material.dart';

class SwitchCheckBox extends StatefulWidget {
  const SwitchCheckBox({super.key});

  @override
  State<SwitchCheckBox> createState() => _SwitchCheckBoxState();
}

class _SwitchCheckBoxState extends State<SwitchCheckBox> {
  bool _switchSelected = true;
  bool _checkboxSelected = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Switch(
            value: _switchSelected,
            onChanged: (value) {
              setState(() {
                _switchSelected = value;
              });
            }),
        Checkbox(
            value: _checkboxSelected,
            activeColor: Colors.red,
            onChanged: (value) {
              setState(() {
                _checkboxSelected = value!;
              });
            })
      ],
    );
  }
}
