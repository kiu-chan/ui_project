import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ui_project/utils/style.dart';

class CulturesPage extends StatefulWidget {
  const CulturesPage({super.key});

  @override
  State<CulturesPage> createState() => _CulturesPageState();
}

class _CulturesPageState extends State<CulturesPage> {
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
          'Popular Cultures',
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
