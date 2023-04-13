import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:survey/pages/loginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Color(0xFF101A30));
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), // Arabic
        Locale('fr'), // French
      ],
      locale: _locale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        splash: Expanded(
          child: Column(
            children: [
              // Image.asset(
              //   'assets/images/leaf.png',
              //   width: 100,
              //   height: 100,
              // ),
              Text(
                'ISSATSo',
                style: TextStyle(
                    //fontFamily: 'Falling',
                    fontSize: 60,
                    letterSpacing: -4,
                    fontWeight: FontWeight.w100,
                    color: Colors.white),
              ),
            ],
          ),
        ),
        //nextScreen: verified ? Navigation() : HomePage(),
        nextScreen: LoginPage(),
        //nextScreen: HomePage(),
        // detailsPage(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.leftToRight,
        duration: 4000,
        animationDuration: const Duration(seconds: 1),
        backgroundColor: Color(0xFF101A30),
        splashIconSize: 200,
        centered: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
