import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:survey/components/buttonHome.dart';
import 'package:survey/pages/homePage.dart';
import 'package:survey/pages/navigation.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({
    Key? key,
    required this.visible,
  }) : super(key: key);

  final bool visible;

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController emailController = TextEditingController();

  TextEditingController pwdController = TextEditingController();
  bool visiblePWD = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      setState(() {});
    });
    pwdController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !widget.visible,
      child: Container(
        padding: const EdgeInsets.only(
          left: 30.0,
          right: 30.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              AppLocalizations.of(context)!.issatso,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w900,
                fontSize: 30.0,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              AppLocalizations.of(context)!.email,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'emailEXAMPLE@email.com',
                labelText: 'E-Mail',
                prefixIcon: Icon(
                  Icons.email,
                ),
                suffixIcon: emailController.text.isEmpty
                    ? Container(
                        width: 0,
                      )
                    : IconButton(
                        onPressed: () {
                          emailController.clear();
                        },
                        icon: Icon(
                          Icons.close,
                        ),
                      ),
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              AppLocalizations.of(context)!.pwd,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            TextFormField(
              controller: pwdController,
              obscureText: !visiblePWD,
              decoration: InputDecoration(
                hintText: '******',
                labelText: 'password',
                prefixIcon: Icon(Icons.lock),
                suffixIcon: visiblePWD
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            visiblePWD = false;
                          });
                        },
                        icon: Icon(Icons.visibility))
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            visiblePWD = true;
                          });
                        },
                        icon: Icon(Icons.visibility_off)),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              AppLocalizations.of(context)!.forgot,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 12.0,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Button(
                text: AppLocalizations.of(context)!.login,
                fct: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => Navigation()),
                    ),
                  );
                  print('clicked login');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
