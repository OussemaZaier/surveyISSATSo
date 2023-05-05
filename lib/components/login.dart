import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:survey/components/buttonHome.dart';
import 'package:survey/pages/homePage.dart';
import 'package:survey/pages/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:survey/service/Auth.dart';
import 'package:survey/service/IAuthRepository.dart';

import '../firebase_options.dart';

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
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

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
      child: Stack(children: [
        Container(
          padding: const EdgeInsets.only(
            left: 30.0,
            right: 30.0,
          ),
          child: Form(
            key: _formKey,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'EXAMPLE@email.com',
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
                  obscureText: !visiblePWD,
                  controller: pwdController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
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
                    fct: () async {
                      if (_formKey.currentState!.validate()) {
                        final auth = AuthRepository().login(
                          emailController.text,
                          pwdController.text,
                        );
                        auth.then((either) {
                          either.fold((failure) {
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                        title: Text('Error'),
                                        content: Text(failure.toString()),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text('OK'),
                                          )
                                        ]));
                          }, (user) {
                            Navigator.of(context).popAndPushNamed('/home');
                          });
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_loading)
          const Opacity(
            opacity: 0.8,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if (_loading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ]),
    );
  }
}
