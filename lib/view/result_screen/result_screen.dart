import 'package:flutter/material.dart';
import 'package:quizapp/utils/constants/color_constants.dart';
import 'package:quizapp/view/home_screen/home_screen.dart';

class ResultScreen extends StatefulWidget {
  //String score;
  ResultScreen({
    super.key,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        color: ColorConstants.blackcolor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              size: 70,
              Icons.star,
              color: ColorConstants.greycolor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  size: 40,
                  Icons.star,
                  color: ColorConstants.yellowcolor,
                ),
                SizedBox(width: 95),
                Icon(
                  size: 40,
                  Icons.star,
                  color: ColorConstants.greycolor,
                )
              ],
            ),
            SizedBox(height: 40),
            Text(
              'Congratulations',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.yellowcolor,
                  fontSize: 27),
            ),
            SizedBox(height: 30),
            Text(
              'Your Score',
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: ColorConstants.whitecolor,
                  fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              '6 / 13',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.yellowcolor,
                  fontSize: 26),
            ),
            SizedBox(height: 60),
            InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                  (route) => false,
                );
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ColorConstants.whitecolor,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: ColorConstants.blackcolor,
                      child: Center(
                        child: Icon(
                          Icons.rotate_left,
                          color: ColorConstants.whitecolor,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Retry',
                      style: TextStyle(
                          fontSize: 22,
                          color: ColorConstants.blackcolor,
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
}
