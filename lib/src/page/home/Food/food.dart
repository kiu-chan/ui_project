import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ui_project/models/Home/food_model.dart';
import 'package:ui_project/src/page/home/detail.dart';
import 'package:ui_project/src/page/home/search_page.dart';
import 'package:ui_project/utils/style.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  final CollectionReference collectFood =
      FirebaseFirestore.instance.collection('Food');
  bool isSave = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          'Popular Food',
          style: appBarStyle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage()));
            },
            icon: Icon(
              LucideIcons.search,
            ),
          ),
        ],
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: collectFood.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<FoodModel> foods = snapshot.data!.docs
                .map(
                  (doc) =>
                      FoodModel.fromJson(doc.data() as Map<String, dynamic>),
                )
                .toList();

            return ListView.builder(
              itemCount: foods.length,
              itemBuilder: (context, index) {
                var festival = foods[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext) => DetailPage(
                          title: festival.title,
                          image: festival.image,
                          address: festival.address[1],
                          description: festival.description,
                          history: festival.history,
                          feature: festival.feature,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: festival.image[0],
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        Image.asset(
                                  'lib/assets/images/market.png',
                                  fit: BoxFit.cover,
                                  height: 150,
                                  width: MediaQuery.sizeOf(context).width * 1,
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  'lib/assets/images/market.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isSave = !isSave;
                                    });
                                  },
                                  icon: isSave
                                      ? SvgPicture.asset(
                                          'lib/assets/icons/book_mark_fill.svg',
                                        )
                                      : SvgPicture.asset(
                                          'lib/assets/icons/book_mark.svg',
                                        ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          festival.title,
                          style: headLineStyle,
                        ),

                        Row(
                          children: [
                            SvgPicture.asset(
                              'lib/assets/icons/vn.svg',
                              width: 20,
                              height: 20,
                            ),
                            // const SizedBox(
                            //   width: 10,
                            // ),

                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.8,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 20,
                                ),
                                child: Text(
                                  festival.address[1],
                                  style: bodyStyle,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
