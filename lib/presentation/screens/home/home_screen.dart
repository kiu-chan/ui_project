import 'package:flutter/material.dart';
import 'package:ui_project/core/constant/assets.dart';
import 'package:ui_project/core/constant/color.dart';
import 'package:ui_project/core/constant/textStyle.dart';
import 'package:ui_project/presentation/screens/home/Culture/list_culture_screen.dart';
import 'package:ui_project/presentation/screens/home/Culture/popular_cultures_screen.dart';
import 'package:ui_project/presentation/screens/home/Destinations/list_destinations_screen.dart';
import 'package:ui_project/presentation/screens/home/Destinations/popular_destinations_screen.dart';
import 'package:ui_project/presentation/screens/home/Festival/list_festivals_screen.dart';
import 'package:ui_project/presentation/screens/home/Festival/popular_festival_screen.dart';
import 'package:ui_project/presentation/screens/home/Food/list_foods_screen.dart';
import 'package:ui_project/presentation/screens/home/Food/popular_food_screen.dart';
import 'package:ui_project/presentation/widgets/title_with_button.dart';
import 'package:ui_project/presentation/widgets/search_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.backGroundColor,
        leading: Image.asset(AppAssets.Marker),
        title: Text(
          'HanoiVibe',
          style: AppTextStyle.appBarStyle,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: ListView(
          children: [
            Search(),
            TitleWithButton(
              title: 'Các điểm đến phổ biến',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListDestinationsScreen(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            PopularDestinationsScreen(),
            SizedBox(
              height: 20,
            ),
            TitleWithButton(
              title: 'Các lễ hội phổ biến',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListFestivalsScreen(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            PopularFestivalScreen(),
            SizedBox(
              height: 20,
            ),
            TitleWithButton(
              title: 'Các món ăn phổ biến',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListFoodsScreen(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            PopularFoodScreen(),
            SizedBox(
              height: 20,
            ),
            TitleWithButton(
              title: 'Các văn hóa phổ biến',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListCulture(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            PopularCulturesScreen(),
          ],
        ),
      ),
    );
  }
}
