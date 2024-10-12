import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quizapp/dummydb.dart';
import 'package:quizapp/utils/constants/animation_constants.dart';
import 'package:quizapp/utils/constants/color_constants.dart';
import 'package:quizapp/view/result_screen/result_screen.dart';

class HomeScreen extends StatefulWidget {
  final int? categoryIndex;
  const HomeScreen({super.key, this.categoryIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int time = 30;
  int questionIndex = 0;
  int? selectedAnswerIndex;
  int score = 0;
  List<Map<String, dynamic>> currentQuestionList = [];
  Timer? countdownTimer;

  @override
  void initState() {
    super.initState();
    currentQuestionList = categoryList();
    startCountdown();
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  void startCountdown() {
    countdownTimer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (time > 0) {
          setState(() {
            time--;
          });
        } else {
          goToNextQuestion();
        }
      },
    );
  }

  void goToNextQuestion() {
    if (questionIndex < currentQuestionList.length - 1) {
      setState(() {
        questionIndex++;
        selectedAnswerIndex = null;
        time = 30;
      });
    } else {
      navigateToResultScreen();
    }
  }

  void navigateToResultScreen() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ResultScreen(
          score: score,
          categoryIndex: widget.categoryIndex,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  List<Map<String, dynamic>> categoryList() {
    switch (widget.categoryIndex) {
      case 0:
        return Dummydb.mathematicsquestions;
      case 1:
        return Dummydb.codingQuestions;
      case 2:
        return Dummydb.scienceQuestions;
      case 3:
        return Dummydb.sportsQuestions;
      default:
        return Dummydb.mathematicsquestions;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          color: ColorConstants.primarycolor,
          child: Column(
            children: [
              _buildProgressBar(),
              SizedBox(height: 12),
              _buildQuestionCard(),
              SizedBox(height: 20),
              _buildAnswerOptions(),
              SizedBox(height: 20),
              if (selectedAnswerIndex != null) _buildNextButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation(ColorConstants.progresscolor),
            value: (questionIndex + 1) / currentQuestionList.length,
            backgroundColor: ColorConstants.secondarycolor,
            minHeight: 6,
          ),
        ),
        SizedBox(width: 6),
        Text(
          '${questionIndex + 1} / ${currentQuestionList.length}',
          style: TextStyle(
            color: ColorConstants.textcolor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionCard() {
    return Expanded(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: ColorConstants.secondarycolor,
              borderRadius: BorderRadius.circular(15),
            ),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  currentQuestionList[questionIndex]['question'],
                  style: TextStyle(
                    color: ColorConstants.progresscolor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 35,
            left: 150,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: ColorConstants.greenshade1,
              child: Text(
                '$time',
                style: TextStyle(
                  color: ColorConstants.progresscolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          if (selectedAnswerIndex ==
              currentQuestionList[questionIndex]['answerindex'])
            Lottie.asset(AnimationConstants.celebration2),
        ],
      ),
    );
  }

  Widget _buildAnswerOptions() {
    return Column(
      children: List.generate(
        currentQuestionList[questionIndex]["options"].length,
        (optionIndex) {
          var currentQuestion = currentQuestionList[questionIndex];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: () {
                if (selectedAnswerIndex == null) {
                  setState(() {
                    selectedAnswerIndex = optionIndex;
                  });

                  if (selectedAnswerIndex == currentQuestion['answerindex']) {
                    setState(() {
                      score++;
                    });
                    Lottie.asset(AnimationConstants.celebration, width: 22);
                  }
                }
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: getColor(optionIndex)),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        currentQuestion["options"][optionIndex],
                        style: TextStyle(
                          color: ColorConstants.textcolor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        Icons.circle_outlined,
                        color: ColorConstants.textcolor,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNextButton() {
    return InkWell(
      onTap: goToNextQuestion,
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstants.secondarycolor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: ColorConstants.textcolor),
        ),
        width: double.infinity,
        height: 40,
        child: Center(
          child: Text(
            "Next",
            style: TextStyle(
              color: ColorConstants.progresscolor,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  Color getColor(int currentOptionIndex) {
    if (selectedAnswerIndex != null &&
        currentOptionIndex ==
            currentQuestionList[questionIndex]['answerindex']) {
      return ColorConstants.greencolor;
    }
    if (selectedAnswerIndex == currentOptionIndex) {
      if (selectedAnswerIndex ==
          currentQuestionList[questionIndex]['answerindex']) {
        return ColorConstants.greencolor;
      } else {
        return ColorConstants.redcolor;
      }
    } else {
      return ColorConstants.textcolor;
    }
  }
}
