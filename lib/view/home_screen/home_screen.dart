import 'package:flutter/material.dart';
import 'package:quizapp/dummydb.dart';
import 'package:quizapp/utils/constants/color_constants.dart';
import 'package:quizapp/view/result_screen/result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int questionindex = 0;
  int? selectedindex;
  int? wrongindex;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          color: ColorConstants.blackcolor,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    textAlign: TextAlign.right,
                    '${questionindex + 1} / ${Dummydb.questionlist.length}',
                    style: TextStyle(
                        color: ColorConstants.whitecolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Expanded(
                child: Container(
                  child: Center(
                      child: Text(
                          Dummydb.questionlist[questionindex]['question'])),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: ColorConstants.greycolor,
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              SizedBox(height: 20),
              Column(
                  children: List.generate(
                4,
                (currentoptionindex) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: InkWell(
                    onTap: isSelected == false
                        ? () {
                            setState(() {});
                            selectedindex = currentoptionindex;
                            isSelected = true;
                          }
                        : null,
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: getcolor(currentoptionindex)),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Dummydb.questionlist[questionindex]['options']
                                  [currentoptionindex],
                              style:
                                  TextStyle(color: ColorConstants.whitecolor),
                            ),
                            Icon(
                              Icons.circle_outlined,
                              color: ColorConstants.whitecolor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  selectedindex = null;
                  isSelected = false;
                  if (questionindex < Dummydb.questionlist.length - 1) {
                    questionindex++;
                    setState(() {});
                  } else {
                    Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  ResultScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ));
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: ColorConstants.whitecolor)),
                  width: double.infinity,
                  height: 40,
                  child: Center(
                    child: Text(
                      "Next",
                      style: TextStyle(color: ColorConstants.whitecolor),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Color getcolor(int currentoptionindex) {
    if (selectedindex != null &&
        currentoptionindex ==
            Dummydb.questionlist[currentoptionindex]['answerindex']) {
      return ColorConstants.greencolor;
    }
    if (selectedindex == currentoptionindex) {
      if (selectedindex ==
          Dummydb.questionlist[currentoptionindex]['answerindex']) {
        return ColorConstants.greencolor;
      } else {
        return ColorConstants.redcolor;
      }
    } else {
      return ColorConstants.whitecolor;
    }
  }
}
