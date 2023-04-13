import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:survey/components/buttonHome.dart';
import 'package:survey/components/clicked.dart';
import 'package:survey/components/surveyCardButton.dart';
import 'package:swipeable_card_stack/swipe_controller.dart';

class SurveyCard extends StatefulWidget {
  SwipeableCardSectionController cardController;

  String question;

  List<String> choices;

  SurveyCard({
    Key? key,
    required this.cardController,
    required this.question,
    required this.choices,
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
    return new Column(
        children: strings
            .map(
              (item) => new questionContainer(
                color: color,
                onMyFieldChange: onMyFieldChange,
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
                            // AppLocalizations.of(context)!.pwd,
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
                                  '${widget.question} your question here?',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 23.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
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
                                  //widget.cardController.addItem();
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

class questionContainer extends StatefulWidget {
  questionContainer({
    Key? key,
    required this.color,
    required this.onMyFieldChange,
  }) : super(key: key);
  final Color color;
  final ValueChanged<Color> onMyFieldChange;
  @override
  State<questionContainer> createState() => _questionContainerState();
}

class _questionContainerState extends State<questionContainer> {
  Clicked _clicked = new Clicked(false);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _clicked.setClicked(true);
            widget.onMyFieldChange(const Color.fromRGBO(2, 136, 209, 1));
          });
        },
        child: Container(
          height: 100,
          margin: EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade600, width: 1.0),
            color: _clicked.getClicked()
                ? Colors.blue.shade200
                : Colors.transparent,
            boxShadow: _clicked.getClicked()
                ? [
                    BoxShadow(
                      color: Colors.blue.withAlpha(130),
                      blurRadius: 7.0,
                      spreadRadius: 2.0,
                      offset: Offset(
                        0.0,
                        0.0,
                      ),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 15.0,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade600, width: 1.0),
                  color: _clicked.getClicked()
                      ? Colors.blue.shade700
                      : Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.check,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
