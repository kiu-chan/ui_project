import 'package:flutter/material.dart';
import 'package:ui_project/core/constant/assets.dart';
import 'package:ui_project/core/constant/textStyle.dart';
import 'package:ui_project/presentation/screens/home/Culture/culture.dart';
import 'package:ui_project/presentation/screens/home/Culture/popular_cultures_screen.dart';
import 'package:ui_project/presentation/screens/home/Destinations/destinations.dart';
import 'package:ui_project/presentation/screens/home/Destinations/popular_destinations_screen.dart';
import 'package:ui_project/presentation/screens/home/Festival/festival.dart';
import 'package:ui_project/presentation/screens/home/Festival/popular_festival_screen.dart';
import 'package:ui_project/presentation/screens/home/Food/food.dart';
import 'package:ui_project/presentation/screens/home/Food/popular_food_screen.dart';
import 'package:ui_project/presentation/widgets/title_with_button.dart';
import 'package:ui_project/presentation/widgets/search.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Image.asset(AppAssets.Marker),
        title: Text(
          'Hello',
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
              title: 'Popular Destinations',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DestinationsPage(),
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
              title: 'Popular Festivals',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FestivalPage(),
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
              title: 'Popular Foods',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodPage(),
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
              title: 'Popular Cultures',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CulturesPage(),
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
