import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:survey/components/buttonHome.dart';
import 'package:survey/components/surveyCardButton.dart';
import 'package:swipeable_card_stack/swipe_controller.dart';

import 'options.dart';

class SurveyCard extends StatefulWidget {
  SwipeableCardSectionController cardController;

  String question;
  bool multiSelect;
  List<String> choices;

  SurveyCard({
    Key? key,
    required this.cardController,
    required this.question,
    required this.choices,
    required this.multiSelect,
  }) : super(key: key);
  @override
  State<SurveyCard> createState() => _SurveyCardState();
}

class _SurveyCardState extends State<SurveyCard> {
  Color color = Color.fromRGBO(170, 170, 170, 0.8);
  bool clicked = false;
  void onMyFieldChange(Color newValue) {
    setState(() {
      color = newValue;
      if (clicked == false) {
        clicked = true;
      }
    });
  }

  Widget getQuestionWidgets(List<String> strings) {
    return ListView(
        children: strings
            .map(
              (item) => Options(
                color: color,
                multiSelect: widget.multiSelect,
                onMyFieldChange: onMyFieldChange,
                text: item,
              ),
            )
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: Material(
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox.expand(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black26],
                    begin: Alignment.center,
                    end: Alignment.bottomCenter),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select an answer',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black38,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.library_add_check_sharp,
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Flexible(
                                child: Text(
                                  // AppLocalizations.of(context)!.pwd,
                                  '${widget.question}',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: getQuestionWidgets(widget.choices),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SurveyButton(
                              text: 'Back',
                              fct: () {
                                setState(() {
                                  //TODO: back auto
                                  // widget.cardController.addItem();
                                });
                              }),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: Button(
                            text: 'Submit',
                            color: color,
                            fct: () {
                              if (clicked) {
                                setState(() {
                                  //TODO: swipe auto
                                  widget.cardController.submitButton();
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
