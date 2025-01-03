import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_project/core/constant/assets.dart';
import 'package:ui_project/core/constant/color.dart';
import 'package:ui_project/presentation/screens/explore/explore_screen.dart';
import 'package:ui_project/presentation/screens/home/home_screen.dart';
import 'package:ui_project/presentation/screens/map/map_screen.dart';
import 'settings/setting_screen.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({Key? key}) : super(key: key);

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    const ExploreScreen(),
    const MapScreen(),
    const SettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.backGroundColor,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _selectedIndex == 0 ? AppAssets.HomeFill : AppAssets.Home,
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 0 ? AppColors.primaryColor : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _selectedIndex == 1 ? AppAssets.NewsFill : AppAssets.News,
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 1 ? AppColors.primaryColor : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Khám phá',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _selectedIndex == 2 ? AppAssets.MapFill : AppAssets.Map,
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 2 ? AppColors.primaryColor : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Bản đồ',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _selectedIndex == 3 ? AppAssets.SettingsFill : AppAssets.Settings,
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 3 ? AppColors.primaryColor : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Cài đặt',
            ),
          ],
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}