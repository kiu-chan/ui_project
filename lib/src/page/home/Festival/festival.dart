import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ui_project/utils/style.dart';

class FestivalPage extends StatefulWidget {
  const FestivalPage({super.key});

  @override
  State<FestivalPage> createState() => _FestivalPageState();
}

class _FestivalPageState extends State<FestivalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            LucideIcons.arrowLeft,
          ),
        ),
        title: Text(
          'Popular Festivals',
          style: appBarStyle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              LucideIcons.search,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
      ),
    );
  }
}
