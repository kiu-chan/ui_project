import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ui_project/utils/style.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

enum Destinations { destination, food, culture, festival }

class _SearchPageState extends State<SearchPage> {
  Destinations _destinations = Destinations.destination;

  void _showFilter() {
    showModalBottomSheet(
        useRootNavigator: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.sizeOf(context).height * 0.6,
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    height: 4,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  AppBar(
                    backgroundColor: Colors.white,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        LucideIcons.arrowLeft,
                      ),
                    ),
                    title: Text(
                      'Filter',
                      style: appBarStyle,
                    ),
                    centerTitle: true,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 15,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    height: 1,
                    width: MediaQuery.sizeOf(context).width * 1,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  ListView(
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        title: Text(
                          'Destinations',
                          style: bodyStyle,
                        ),
                        trailing: Radio<Destinations>(
                            activeColor: primaryColor,
                            value: Destinations.destination,
                            groupValue: _destinations,
                            onChanged: (Destinations? value) {
                              setState(() {
                                _destinations = value!;
                              });
                            }),
                      ),
                      ListTile(
                        title: Text(
                          'Food',
                          style: bodyStyle,
                        ),
                        trailing: Radio<Destinations>(
                            activeColor: primaryColor,
                            value: Destinations.food,
                            groupValue: _destinations,
                            onChanged: (Destinations? value) {
                              setState(() {
                                _destinations = value!;
                              });
                            }),
                      ),
                      ListTile(
                        title: Text(
                          'Festival',
                          style: bodyStyle,
                        ),
                        trailing: Radio<Destinations>(
                            activeColor: primaryColor,
                            value: Destinations.festival,
                            groupValue: _destinations,
                            onChanged: (Destinations? value) {
                              setState(() {
                                _destinations = value!;
                              });
                            }),
                      ),
                      ListTile(
                        title: Text(
                          'Culture',
                          style: bodyStyle,
                        ),
                        trailing: Radio<Destinations>(
                            activeColor: primaryColor,
                            value: Destinations.culture,
                            groupValue: _destinations,
                            onChanged: (Destinations? value) {
                              setState(() {
                                _destinations = value!;
                              });
                            }),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 15,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    height: 1,
                    width: MediaQuery.sizeOf(context).width * 1,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 60,
                          ),
                          decoration: BoxDecoration(
                            color: secondColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 60,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text(
                              'OK',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(LucideIcons.arrowLeft),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromRGBO(246, 246, 246, 1),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            LucideIcons.search,
                            size: 18,
                            color: Color.fromRGBO(165, 165, 165, 1),
                          ),
                          hintText: 'Search...',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(165, 165, 165, 1),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              _showFilter();
                            },
                            icon: SvgPicture.asset(
                              'lib/assets/icons/filter.svg',
                              // ignore: deprecated_member_use
                              color: Color.fromRGBO(165, 165, 165, 1),
                              width: 18,
                              height: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
