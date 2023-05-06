import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:survey/components/surveyContainer.dart';
import 'package:survey/service/ImFirestore.dart';
import 'package:survey/service/Storage.dart';
import 'dart:math' as math;

import '../components/header.dart';
import '../models/Student.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _fireRep = FirestoreRepository();
  final _random = Random();
  final storage = new Storage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height / 5), // Set this height
        child: Header(),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recent Survey',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                    color: Color(0xFF101A30),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                FutureBuilder<String>(
                    initialData: "",
                    future: storage.getFiliere(),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      switch (snapshot.connectionState) {
                        // case ConnectionState.waiting:
                        //   return Center(
                        //     child: const CircularProgressIndicator(),
                        //   );
                        case ConnectionState.done:
                          return FutureBuilder<List<Object>>(
                              future:
                                  _fireRep.getCustomForms('forms', 'questions'),
                              builder: (context, AsyncSnapshot<List> snapshot) {
                                switch (snapshot.connectionState) {
                                  // case ConnectionState.waiting:
                                  //   return Flexible(
                                  //     child: ListView.builder(
                                  //       shrinkWrap: true,
                                  //       itemBuilder: (context, index) =>
                                  //           CardSkelton(),
                                  //       itemCount: 5,
                                  //     ),
                                  //   );
                                  case ConnectionState.done:
                                    if (snapshot.data!.isNotEmpty) {
                                      return Flexible(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, index) {
                                            // if (snapshot.data![index].deadline

                                            return SurveyContainer(
                                                id: snapshot.data![index].id,
                                                color: Colors.primaries[
                                                    _random.nextInt(Colors
                                                        .primaries.length)],
                                                icon:
                                                    Icons.format_quote_rounded,
                                                name:
                                                    snapshot.data![index].type,
                                                questionNumber: snapshot
                                                    .data![index].numQuestion);
                                          },
                                        ),
                                      );
                                    } else {
                                      return const Center(
                                          child: Text(
                                              "No surveys available right now"));
                                    }
                                  default:
                                    return Flexible(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) =>
                                            CardSkelton(),
                                        itemCount: 5,
                                      ),
                                    );
                                }
                              });
                        default:
                          return Center(
                              child: const CircularProgressIndicator());
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardSkelton extends StatelessWidget {
  const CardSkelton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skelton(
      height: 90,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 25),
      child: Row(
        children: [
          const Skelton(
              height: 50, width: 50, border: 0, margin: EdgeInsets.all(20)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Skelton(
                height: 20,
                width: MediaQuery.of(context).size.width / 1.8,
              ),
              const SizedBox(
                height: 5.0,
              ),
              Skelton(
                height: 15,
                width: MediaQuery.of(context).size.width / 5,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Skelton extends StatelessWidget {
  final double? height, width;
  final EdgeInsets? margin;
  final double border;
  final Widget? child;
  const Skelton(
      {this.height, this.width, this.child, this.border = 16, this.margin});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      width: this.width,
      margin: this.margin,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius: BorderRadius.all(Radius.circular(this.border))),
      child: child,
    );
  }
}
