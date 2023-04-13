import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:survey/models/feedbackType.dart';
import 'package:survey/models/scale.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> feedbackType = FeedbackType.feedbackType;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ChooseTale(
              feedbackType: feedbackType,
            ),
            Expanded(
              child: Container(
                child: TextField(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChooseTale extends StatelessWidget {
  const ChooseTale({
    Key? key,
    required this.feedbackType,
  }) : super(key: key);

  final List<String> feedbackType;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        bottom: 20.0,
        top: 20.0,
      ),
      margin: EdgeInsets.only(
        bottom: 20.0,
      ),
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
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class FeedbackTale extends StatefulWidget {
  const FeedbackTale({
    Key? key,
    required this.feedbackType,
  }) : super(key: key);

  final String feedbackType;

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
              } else {
                containerColor = Colors.grey.shade400.withAlpha(100);
                textColor = Colors.grey.shade700;
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
                  //textScaleFactor: ScaleSize.textScaleFactor(context),
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
