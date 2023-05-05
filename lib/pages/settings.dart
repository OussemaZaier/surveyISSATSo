import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:survey/components/settingItem.dart';
import 'package:survey/main.dart';
import 'package:survey/models/language.dart';
import 'package:survey/pages/navigation.dart';
import 'package:survey/service/Auth.dart';
import 'package:survey/service/IAuthRepository.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    List<Language> e = Language.languageList();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.settings,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  settingItem(
                    iconName: Icons.language_outlined,
                    fct: () {
                      ArtSweetAlert.show(
                        context: context,
                        artDialogArgs: ArtDialogArgs(
                          title: AppLocalizations.of(context)!.language,
                          customColumns: <Widget>[
                            InkWell(
                              onTap: () {
                                MyApp.setLocale(
                                  context,
                                  Locale(e[0].languageCode, ''),
                                );
                                Navigator.pop(context);
                              },
                              child: languageItem(e: e[0]),
                            ),
                            InkWell(
                              onTap: () {
                                MyApp.setLocale(
                                  context,
                                  Locale(e[1].languageCode, ''),
                                );
                                Navigator.pop(context);
                              },
                              child: languageItem(e: e[1]),
                            ),
                            InkWell(
                              onTap: () {
                                MyApp.setLocale(
                                  context,
                                  Locale(e[2].languageCode, ''),
                                );
                                Navigator.pop(context);
                              },
                              child: languageItem(e: e[2]),
                            ),
                          ],
                        ),
                      );
                    },
                    name: AppLocalizations.of(context)!.language,
                    logOut: false,
                  ),
                  settingItem(
                    iconName: Icons.support_agent,
                    fct: () {
                      print('clicked 2');
                    },
                    name: AppLocalizations.of(context)!.support,
                    logOut: false,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  settingItem(
                    iconName: Icons.logout,
                    fct: () {
                      AuthRepository().logout();
                      Navigator.of(context).popAndPushNamed('/first');
                    },
                    name: AppLocalizations.of(context)!.logout,
                    logOut: true,
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

class languageItem extends StatelessWidget {
  const languageItem({
    Key? key,
    required this.e,
  }) : super(key: key);

  final Language e;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 30,
        ),
        Text(
          e.flag,
          style: const TextStyle(fontSize: 30),
        ),
        SizedBox(
          width: 20,
        ),
        Text(e.name)
      ],
    );
  }
}
