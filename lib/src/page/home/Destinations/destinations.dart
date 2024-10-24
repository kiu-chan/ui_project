import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ui_project/models/Home/destinations_model.dart';
import 'package:ui_project/src/page/home/Destinations/detail_destination.dart';
import 'package:ui_project/utils/style.dart';

class DestinationsPage extends StatefulWidget {
  const DestinationsPage({super.key});

  @override
  State<DestinationsPage> createState() => _DestinationsPageState();
}

class _DestinationsPageState extends State<DestinationsPage> {
  final CollectionReference collectDestinations =
      FirebaseFirestore.instance.collection('Destinations');
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
          'Popular Destinations',
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
      body: FutureBuilder<QuerySnapshot>(
        future: collectDestinations.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<DestinationsModels> destinations = snapshot.data!.docs
                .map(
                  (doc) => DestinationsModels.fromJson(
                      doc.data() as Map<String, dynamic>),
                )
                .toList();

            return ListView.builder(
              itemCount: destinations.length,
              itemBuilder: (context, index) {
                var destination = destinations[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext) => DetailDestinationPage(
                          title: destination.title,
                          image: destination.image,
                          address: destination.address,
                          description: destination.description,
                          history: destination.history,
                          feature: destination.feature,
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
                                imageUrl: destination.image[0],
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
                          destination.title,
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
                                  destination.address,
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
