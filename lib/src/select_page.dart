import 'package:flutter/material.dart';
import 'package:ui_project/src/page/map/map_page.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({super.key});

  @override
  SelectPageState createState() => SelectPageState();
}

class SelectPageState extends State<SelectPage> {
  int currentindex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const Placeholder(),
      const MapPage(),
      const Placeholder(),
    ];
    return Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: Container(
            color: Colors.white,
            key: ValueKey<int>(currentindex),
            child: pages[currentindex],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            onTap: (int index) {
              setState(() {
                currentindex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            currentIndex: currentindex,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.map_outlined), label: 'Map'),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
              ),
            ]));
  }
}
