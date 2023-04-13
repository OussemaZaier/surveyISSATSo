import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class settingItem extends StatelessWidget {
  final IconData iconName;
  final String name;
  final VoidCallback fct;
  final bool logOut;
  const settingItem(
      {Key? key,
      required this.iconName,
      required this.fct,
      required this.name,
      required this.logOut})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 30,
        right: 30,
        bottom: 5,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: fct,
            child: Container(
              padding: EdgeInsets.only(
                left: 15,
                right: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          iconName,
                          size: 30,
                          color: logOut ? Colors.red : Colors.grey.shade800,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: logOut ? Colors.red : Colors.grey.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    size: 30,
                    color: logOut ? Colors.red : Colors.grey.shade800,
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: !logOut,
            child: Divider(
              thickness: 2,
              height: 30,
            ),
          ),
        ],
      ),
    );
  }
}
