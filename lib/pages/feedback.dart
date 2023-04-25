import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:survey/components/buttonHome.dart';
import 'package:survey/components/clicked.dart';
import 'package:survey/models/feedbackType.dart';
import 'package:survey/models/scale.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

Color color = Colors.blue.shade200;
int numberOfSelectedTiles = 0;

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> feedbackType = FeedbackType.feedbackType;

    _changeColor(int val) {
      numberOfSelectedTiles += val;
      if (numberOfSelectedTiles < 0) {
        numberOfSelectedTiles = 0;
      } else if (numberOfSelectedTiles == 0) {
        setState(() {
          color = Colors.blue.shade200;
        });
      } else if (numberOfSelectedTiles == 1) {
        setState(() {
          color = Colors.blue.shade600;
        });
      }
    }

    return Scaffold(
      body: Column(
        children: [
          ChooseTale(
            feedbackType: feedbackType,
            fct: _changeColor,
          ),
          Expanded(
            child: TextField(),
          ),
          SubmitButton(
            color: color,
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  SubmitButton({
    Key? key,
    required this.color,
  }) : super(key: key);
  Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(color);
      },
      child: Container(
        color: Colors.white,
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.all(
            30.0,
          ),
          color: color,
          height: 50,
          child: Center(
            child: Text(
              'SUBMIT',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChooseTale extends StatelessWidget {
  ChooseTale({
    Key? key,
    required this.feedbackType,
    required this.fct,
  }) : super(key: key);

  List<String> feedbackType;
  Function(int val) fct;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        bottom: 20.0,
        top: 20.0,
        right: 8.0,
        left: 8.0,
      ),
      margin: EdgeInsets.only(
        bottom: 20.0,
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'tell us what is your problem?',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: [
              for (String e in feedbackType)
                FeedbackTale(
                  feedbackType: e,
                  index: feedbackType.indexOf(e),
                  fct: fct,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class FeedbackTale extends StatefulWidget {
  FeedbackTale({
    Key? key,
    required this.feedbackType,
    required this.index,
    required this.fct,
  }) : super(key: key);

  String feedbackType;
  int index;
  Function(int val) fct;

  @override
  State<FeedbackTale> createState() => _FeedbackTaleState();
}

class _FeedbackTaleState extends State<FeedbackTale> {
  Color containerColor = Colors.grey.shade400.withAlpha(100);
  Color textColor = Colors.grey.shade700;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              if (containerColor != Colors.blue.shade900) {
                containerColor = Colors.blue.shade900;
                textColor = Colors.white;
                widget.fct(1);
              } else {
                containerColor = Colors.grey.shade400.withAlpha(100);
                textColor = Colors.grey.shade700;
                widget.fct(-1);
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  widget.feedbackType,
                  style: TextStyle(
                    color: textColor,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
