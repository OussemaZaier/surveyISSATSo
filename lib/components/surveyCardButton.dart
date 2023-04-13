import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SurveyButton extends StatefulWidget {
  SurveyButton({Key? key, required this.text, required this.fct})
      : super(key: key);
  String text;
  VoidCallback fct;

  @override
  State<SurveyButton> createState() => _SurveyButtonState();
}

class _SurveyButtonState extends State<SurveyButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {});
        widget.fct();
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(30),
        //   color: Colors.lightBlue.shade700,
        // ),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            widget.text,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              letterSpacing: 2,
            ),
          ),
        )),
      ),
    );
  }
}
