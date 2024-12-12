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

class CategoryButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const CategoryButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 30,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.backGroundColor,
        title: Text(
          'HanoiVibe',
          style: AppTextStyle.appBarStyle,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            Search(),
            SizedBox(height: 5),
            
            // Categories
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Danh mục',
                      style: AppTextStyle.headLineStyle.copyWith(
                        fontSize: AppTextStyle.headLineStyle.fontSize != null 
                            ? AppTextStyle.headLineStyle.fontSize! * 1.5
                            : 32, // giá trị mặc định nếu fontSize ban đầu không tồn tại
                      ),
                    ),
                  ),

                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CategoryButton(
                        icon: Icons.place,
                        label: 'Địa điểm',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListDestinationsScreen(),
                            ),
                          );
                        },
                      ),
                      CategoryButton(
                        icon: Icons.event,
                        label: 'Sự kiện',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListFestivalsScreen(),
                            ),
                          );
                        },
                      ),
                      CategoryButton(
                        icon: Icons.restaurant_menu,
                        label: 'Ẩm thực',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListFoodsScreen(),
                            ),
                          );
                        },
                      ),
                      CategoryButton(
                        icon: Icons.brush,
                        label: 'Nghệ thuật',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListCulture(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20),
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
            SizedBox(height: 10),
            PopularDestinationsScreen(),
            
            SizedBox(height: 20),
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
            SizedBox(height: 10),
            PopularFestivalScreen(),
            
            SizedBox(height: 20),
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
            SizedBox(height: 10),
            PopularFoodScreen(),
            
            SizedBox(height: 20),
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
            SizedBox(height: 10),
            PopularCulturesScreen(),
          ],
        ),
      ),
    );
  }
}