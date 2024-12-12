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
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ui_project/presentation/screens/home/search_screen.dart';

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
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 30,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imageList = [
    'https://bois.com.vn/wp-content/uploads/2023/12/Kien-truc-pho-co-Ha-Noi-hien-nay.jpg',
    'https://images.unsplash.com/photo-1710141968276-1461538e8bc9?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://hanoilarosahotel.com/wp-content/uploads/2019/05/ho-hoan-kiem.jpg',
  ];

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
        actions: [
          IconButton(
            icon: const Icon(
              LucideIcons.search,
              color: Colors.black,
              size: 24,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            const SizedBox(height: 15),
            // Image Slider
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: ImageSlideshow(
                width: double.infinity,
                height: 180,
                initialPage: 0,
                indicatorColor: AppColors.primaryColor,
                indicatorBackgroundColor: Colors.grey,
                autoPlayInterval: 3000,
                isLoop: true,
                children: imageList.map((image) {
                  return CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  );
                }).toList(),
              ),
            ),
            
            const SizedBox(height: 15),
            
            // Categories
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Danh mục',
                      style: AppTextStyle.headLineStyle.copyWith(
                        fontSize: AppTextStyle.headLineStyle.fontSize != null 
                            ? AppTextStyle.headLineStyle.fontSize! * 1.5
                            : 32,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
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
                              builder: (context) => const ListDestinationsScreen(),
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
                              builder: (context) => const ListFestivalsScreen(),
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
                              builder: (context) => const ListFoodsScreen(),
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
                              builder: (context) => const ListCulture(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            TitleWithButton(
              title: 'Các điểm đến phổ biến',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListDestinationsScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            const PopularDestinationsScreen(),
            
            const SizedBox(height: 20),
            TitleWithButton(
              title: 'Các lễ hội phổ biến',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListFestivalsScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            const PopularFestivalScreen(),
            
            const SizedBox(height: 20),
            TitleWithButton(
              title: 'Các món ăn phổ biến',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListFoodsScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            const PopularFoodScreen(),
            
            const SizedBox(height: 20),
            TitleWithButton(
              title: 'Các văn hóa phổ biến',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListCulture(),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            const PopularCulturesScreen(),
          ],
        ),
      ),
    );
  }
}