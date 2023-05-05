import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/Student.dart';
import '../service/ImFirestore.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final fireRep = FirestoreRepository();
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
              child: FutureBuilder(
                initialData: Student("", ""),
                future: fireRep.getStudentByEmail("students"),
                builder: (context, AsyncSnapshot<Student> student) {
                  if (student.data!.name.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Center(
                      child: Text(
                        getAbbriviation(student).toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 30.0,
                          color: Color(0xFF101A30),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getAbbriviation(AsyncSnapshot<Student> student) {
    String abNAme = "";
    if (student.data!.name.trim().contains(' ')) {
      abNAme = abNAme + student.data!.name[student.data!.name.indexOf(' ') + 1];
    } else {
      abNAme = abNAme + student.data!.name[0];
    }
    abNAme = abNAme + student.data!.lastName[0];
    return abNAme;
  }
}
