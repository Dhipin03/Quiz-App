import 'package:flutter/material.dart';
import 'package:quizapp/dummydb.dart';
import 'package:quizapp/utils/constants/color_constants.dart';

import 'package:quizapp/view/home_screen/home_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 18),
        width: double.infinity,
        color: ColorConstants.primarycolor,
        child: Column(
          children: [
            Text(
              'Quiz Categories',
              style: TextStyle(
                  color: ColorConstants.textcolor,
                  fontWeight: FontWeight.bold,
                  fontSize: 28),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    childAspectRatio: 162 / 200,
                    crossAxisSpacing: 12),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(
                            categoryIndex: index,
                          ),
                        ));
                  },
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Dummydb.categorycardlist[index]['imgurl'],
                          width: 80,
                        ),
                        SizedBox(height: 8),
                        Text(
                          Dummydb.categorycardlist[index]['text'],
                          style: TextStyle(
                              color: ColorConstants.progresscolor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        )
                      ],
                    ),
                    height: 105,
                    decoration: BoxDecoration(
                        color: ColorConstants.greenshade1,
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
