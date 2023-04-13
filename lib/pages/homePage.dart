import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:survey/components/surveyContainer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height / 5), // Set this height
        child: Header(),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recent Survey',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                    color: Color(0xFF101A30),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                SurveyContainer(
                  color: Colors.yellow,
                  icon: Icons.format_quote,
                  name: 'Courses Survey',
                  questionNumber: 10,
                ),
                SurveyContainer(
                  color: Colors.red,
                  icon: Icons.compare_arrows_sharp,
                  name: 'Courses Survey',
                  questionNumber: 9,
                ),
                Text(
                  'Old Survey',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                    color: Color(0xFF101A30),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                SurveyContainer(
                  color: Colors.green,
                  icon: Icons.plus_one,
                  name: 'Courses Survey',
                  questionNumber: 9,
                ),
                SurveyContainer(
                  color: Colors.pink,
                  icon: Icons.school,
                  name: 'Courses Survey',
                  questionNumber: 9,
                ),
                SurveyContainer(
                  color: Colors.blue,
                  icon: Icons.abc,
                  name: 'Courses Survey',
                  questionNumber: 9,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      color: Color(0xFF101A30),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ISSATSo survey',
                  style: TextStyle(
                      //fontFamily: 'Falling',
                      fontSize: 30.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'together we are stronger',
                  style: TextStyle(
                      //fontFamily: 'Falling',
                      fontSize: 15.0,
                      fontWeight: FontWeight.w200,
                      color: Colors.white),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width / 5,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'OZ',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 30.0,
                    color: Color(0xFF101A30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
