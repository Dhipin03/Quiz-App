import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quizapp/dummydb.dart';
import 'package:quizapp/utils/constants/animation_constants.dart';
import 'package:quizapp/utils/constants/color_constants.dart';
import 'package:quizapp/view/category_screen/category_screen.dart';
import 'package:quizapp/view/home_screen/home_screen.dart';

class ResultScreen extends StatefulWidget {
  int score;
  int? categoryIndex;
  ResultScreen({super.key, required this.score, required this.categoryIndex});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    super.initState();
    calculatepercent();
  }

  int starcount = 0;
  calculatepercent() {
    var percent = (widget.score / Dummydb.questionlist.length) * 100;
    if (percent >= 80) {
      starcount = 3;
    } else if (percent >= 50) {
      starcount = 2;
    } else if (percent >= 30) {
      starcount = 1;
    } else {
      starcount = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        color: ColorConstants.primarycolor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => Padding(
                  padding: EdgeInsets.only(
                      left: 20, right: 20, bottom: index == 1 ? 80 : 0),
                  child: Icon(
                    Icons.star,
                    size: index == 1 ? 70 : 50,
                    color: index < starcount
                        ? ColorConstants.yellowcolor
                        : ColorConstants.secondarycolor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            Text(
              getResultMessage(),
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.yellowcolor,
                  fontSize: 27),
            ),
            Lottie.asset(getAnimation(), width: 200, height: 200),
            SizedBox(height: 30),
            Text(
              'Your Score',
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: ColorConstants.textcolor,
                  fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '${widget.score} / 13',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.yellowcolor,
                  fontSize: 26),
            ),
            SizedBox(height: 60),
            InkWell(
              onTap: () {
                showDialog<void>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shadowColor: ColorConstants.progresscolor,
                      elevation: 12,
                      backgroundColor: ColorConstants.primarycolor,
                      content: const SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Center(
                              child: Text(
                                'What would you like to do?',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: ColorConstants.progresscolor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 18,
                          ),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CategoryScreen(),
                                      ));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  decoration: BoxDecoration(
                                      color: ColorConstants.secondarycolor,
                                      borderRadius: BorderRadius.circular(32)),
                                  child: Container(
                                      child: Text(
                                    'Change Category',
                                    style: TextStyle(
                                        color: ColorConstants.progresscolor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  )),
                                ),
                              ),
                              SizedBox(
                                width: 14,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomeScreen(
                                          categoryIndex: widget.categoryIndex,
                                        ),
                                      ));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  decoration: BoxDecoration(
                                      color: ColorConstants.secondarycolor,
                                      borderRadius: BorderRadius.circular(32)),
                                  child: Container(
                                      child: Text(
                                    'Retry',
                                    style: TextStyle(
                                        color: ColorConstants.progresscolor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ColorConstants.textcolor,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: ColorConstants.primarycolor,
                      child: Center(
                        child: Icon(
                          Icons.rotate_left,
                          color: ColorConstants.textcolor,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Retry',
                      style: TextStyle(
                          fontSize: 22,
                          color: ColorConstants.primarycolor,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String getResultMessage() {
    if (starcount > 2) {
      return 'Congratulations';
    } else if (starcount > 1) {
      return 'Well Done!';
    } else {
      return 'Keep Practicing!';
    }
  }

  String getAnimation() {
    if (starcount > 2) {
      return AnimationConstants.congratulation;
    } else if (starcount > 1) {
      return AnimationConstants.welldone;
    } else {
      return AnimationConstants.keeptry;
    }
  }
}
