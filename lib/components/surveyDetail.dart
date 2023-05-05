import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:survey/components/card.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';

class SurveyDetail extends StatefulWidget {
  const SurveyDetail({Key? key}) : super(key: key);

  @override
  State<SurveyDetail> createState() => _SurveyDetailState();
}

class _SurveyDetailState extends State<SurveyDetail> {
  @override
  Widget build(BuildContext context) {
    SwipeableCardSectionController _cardController =
        SwipeableCardSectionController();

    return Scaffold(
      backgroundColor: Color(0xFF101A30),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SwipeableCardsSection(
            cardHeightTopMul: 0.9,
            cardController: _cardController,
            context: context,
            //add the first 3 cards (widgets)
            items: [
              SurveyCard(
                key: Key('A'),
                cardController: _cardController,
                question:
                    'How satisfied are you with the quality of education provided by your university?',
                choices: [
                  'Extremely satisfied',
                  'Very satisfied',
                  'Moderately satisfied',
                  'Slightly satisfied',
                  "Not at all satisfied"
                ],
              ),
              SurveyCard(
                key: Key('B'),
                cardController: _cardController,
                question: 'test2',
                choices: [
                  '1',
                  '2',
                  '3',
                ],
              ),
              SurveyCard(
                key: Key('C'),
                cardController: _cardController,
                question: 'test3',
                choices: [
                  '1',
                  '2',
                ],
              ),
            ],
            //Get card swipe event callbacks
            onCardSwiped: (dir, index, widget) {
              //Add the next card using _cardController
              //TODO:
              //try to put all the SurveyCard in a list
              //then add them like this
              //eya the package work only for 3 cards
              //so when a card is deleted add the other ones
              //call me for HELP
              // :) :) :)
              // _cardController.addItem(
              //   SurveyCard(
              //     key: Key('D'),
              //   ),
              // );
              //auto swipe check
              // _cardController.submitButton();
              //Take action on the swiped widget based on the direction of swipe
              //Return false to not animate cards
              print(index);
            },
            //
            enableSwipeUp: true,
            enableSwipeDown: false,
          ),
        ],
      ),
    );
  }
}
