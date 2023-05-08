import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData assingTheme(context) {
  return Theme.of(context).copyWith(
    primaryColor: Colors.lightBlue,
    backgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
        color: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.lightBlue,
        ),
        textTheme: TextTheme(titleSmall: TextStyle(color: Colors.black)),
        elevation: 0),
    iconTheme: const IconThemeData(
      color: Color(0xFF101A30),
    ),
    cupertinoOverrideTheme: CupertinoThemeData(
      primaryColor: Colors.black,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
          Size(100.0, 50.0),
        ),
        side: MaterialStateProperty.resolveWith(
          (Set<MaterialState> state) {
            if (state.contains(MaterialState.disabled)) {
              return BorderSide(
                color: Colors.grey,
              );
            }
            return BorderSide(
              color: Colors.lightBlue,
            );
          },
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        // textStyle: MaterialStateProperty.resolveWith(
        //   (Set<MaterialState> state) {
        //     if (state.contains(MaterialState.disabled)) {
        //       return Theme.of(context).textTheme.labelLarge?.copyWith(
        //             color: Colors.grey.shade200,
        //           );
        //     } else {
        //       return Theme.of(context).textTheme.labelLarge?.copyWith(
        //             color: Colors.black,
        //           );
        //     }
        //   },
        // ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Color(0xFF101A30),
              ),
        ),
      ),
    ),
    textTheme: TextTheme(
        displayMedium: TextStyle(
          fontSize: 28.0,
          color: Colors.black,
        ),
        displaySmall: TextStyle(
          fontSize: 24.0,
          color: Colors.black,
        ),
        bodyMedium: TextStyle(
          fontSize: 18.0,
          color: Colors.black,
        ),
        titleMedium: TextStyle(
          fontSize: 18.0,
          color: Colors.black,
        ),
        headlineSmall: TextStyle(fontSize: 20, color: Colors.black)),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: Colors.black,
      ),
    ),
  );
}
