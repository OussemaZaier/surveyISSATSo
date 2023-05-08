import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:survey/components/card.dart';
import 'package:survey/components/surveyDetail.dart';

class SurveyContainer extends StatelessWidget {
  SurveyContainer(
      {Key? key,
      required this.color,
      required this.icon,
      required this.name,
      required this.questionNumber,
      required this.id})
      : super(key: key);
  MaterialColor color;
  IconData icon;
  String name;
  int questionNumber;
  String id;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: ((context) => SurveyDetail(id: this.id)),
          ),
        );
      }),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 90.0,
        margin: EdgeInsets.only(
          bottom: 20.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 15.0, // soften the shadow
              offset: Offset(
                10.0, // Move to right 5  horizontally
                10.0, // Move to bottom 5 Vertically
              ),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              margin: EdgeInsets.all(20.0),
              color: color.shade200,
              child: Icon(
                icon,
                color: color.shade700,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                        color: Color(0xFF101A30),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    '${questionNumber} questions',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15.0,
                      color: Color(0x6F101A30),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
