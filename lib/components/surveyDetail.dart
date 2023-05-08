import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:survey/components/card.dart';
import 'package:survey/models/answer.dart';
import 'package:survey/service/ImFirestore.dart';
import 'package:survey/service/Storage.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';
import 'package:survey_kit/survey_kit.dart';
import '../utils/const.dart';
import '../models/question.dart';

class SurveyDetail extends StatefulWidget {
  final String id;
  const SurveyDetail({Key? key, required this.id}) : super(key: key);

  @override
  State<SurveyDetail> createState() => _SurveyDetailState();
}

class _SurveyDetailState extends State<SurveyDetail> {
  @override
  Widget build(BuildContext context) {
    SwipeableCardSectionController _cardController =
        SwipeableCardSectionController();
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: FirestoreRepository().getQuestions(widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<Question> data = snapshot.data as List<Question>;
              return Card(
                elevation: 20,
                shadowColor: Colors.indigo[200],
                margin: const EdgeInsetsDirectional.symmetric(
                    horizontal: 10, vertical: 30),
                child: SurveyKit(
                    showProgress: true,
                    themeData: assingTheme(context),
                    task: NavigableTask(
                      id: TaskIdentifier(id: widget.id),
                      steps: _getListWidget(data),
                    ),
                    onResult: (SurveyResult result) async {
                      String filiere = await Storage().getFiliere();
                      var respond;
                      for (var answer in result.results) {
                        List<String> list = [];
                        // FirestoreRepository().addAnswer(widget.id, , value)
                        for (var choice in answer.results) {
                          print(choice.result.runtimeType == TextChoice);
                          choice.result.runtimeType == TextChoice
                              ? list.add(choice.result.value)
                              : list.add(choice.result);
                        }
                        await FirestoreRepository().addAnswer(Answer(
                            filiere: filiere,
                            questionId: answer.id!.id,
                            answer: list,
                            formId: widget.id));
                      }
                      Navigator.pop(context);
                    }),
              );
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //   SwipeableCardsSection(
                    //     cardHeightTopMul: 0.9,
                    //     cardController: _cardController,

                    //     context: context,
                    //     //add the first 3 cards (widgets)
                    //     items: _getListWidget(data, _cardController),
                    //     // SurveyCard(cardController: cardController, question: question, choices: choices)

                    //     //Get card swipe event callbacks
                    //     onCardSwiped: (dir, index, widget) {
                    //       //Add the next card using _cardController
                    //       // _cardController.submitButton();
                    //       //TODO:
                    //       //try to put all the SurveyCard in a list
                    //       //then add them like this
                    //       //eya the package work only for 3 cards
                    //       //so when a card is deleted add the other ones
                    //       //call me for HELP
                    //       // :) :) :)
                    //       // _cardController.addItem(
                    //       //   SurveyCard(
                    //       //     key: Key('D'),
                    //       //   ),
                    //       // );
                    //       //auto swipe check
                    //       //Take action on the swiped widget based on the direction of swipe
                    //       //Return false to not animate cards
                    //       print(index);
                    //     },
                    //   ),
                  ]);
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

List<QuestionStep> _getListWidget(List<Question> data) {
  List<QuestionStep> survey = [];
  for (var doc in data) {
    switch (doc.type) {
      case ('multipleAnswer'):
        survey.add(QuestionStep(
            stepIdentifier: StepIdentifier(id: doc.id),
            title: doc.question,
            answerFormat: MultipleChoiceAnswerFormat(
                textChoices: doc.options.map((e) {
              return TextChoice(text: e, value: e);
            }).toList())));
        break;
      case ('singleAnswer'):
        {
          survey.add(QuestionStep(
              stepIdentifier: StepIdentifier(id: doc.id),
              title: doc.question,
              answerFormat: SingleChoiceAnswerFormat(
                  textChoices: doc.options.map((e) {
                return TextChoice(text: e, value: e);
              }).toList())));
          break;
        }
      default:
        {
          survey.add(QuestionStep(
              stepIdentifier: StepIdentifier(id: doc.id),
              title: doc.question,
              answerFormat: TextAnswerFormat(
                  maxLines: 10, validationRegEx: "[a-bA-B]*")));
        }
    }
  }
  return survey;
}
