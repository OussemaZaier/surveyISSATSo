import 'package:flutter/material.dart';

import 'clicked.dart';

class Options extends StatefulWidget {
  Options({
    Key? key,
    required this.color,
    required this.onMyFieldChange,
    required this.text,
  }) : super(key: key);
  final Color color;
  final ValueChanged<Color> onMyFieldChange;
  final String text;
  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  Clicked _clicked = new Clicked(false);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _clicked.setClicked(!_clicked.getClicked());
          widget.onMyFieldChange(const Color.fromRGBO(2, 136, 209, 1));
        });
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade600, width: 1.0),
          color:
              _clicked.getClicked() ? Colors.blue.shade200 : Colors.transparent,
          boxShadow: _clicked.getClicked()
              ? [
                  BoxShadow(
                    color: Colors.blue.withAlpha(130),
                    blurRadius: 7.0,
                    spreadRadius: 2.0,
                    offset: Offset(
                      0.0,
                      0.0,
                    ),
                  ),
                ]
              : null,
        ),
        child: Expanded(
          child: Row(
            children: [
              SizedBox(
                width: 15.0,
              ),
              Icon(
                Icons.check,
              ),
              Flexible(
                child: Text(
                  widget.text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
