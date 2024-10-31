import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_project/utils/style.dart';

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  String title;
  List<String> image;
  String address;
  String description;
  String history;
  String feature;

  DetailPage({
    super.key,
    required this.title,
    required this.image,
    required this.address,
    required this.description,
    required this.history,
    required this.feature,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final CollectionReference collectDestinations =
      FirebaseFirestore.instance.collection('Destinations');
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl: widget.image[0],
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Image.asset(
                  'lib/assets/images/market.png',
                  fit: BoxFit.cover,
                  height: 150,
                  width: MediaQuery.sizeOf(context).width * 1,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'lib/assets/images/market.png',
                  fit: BoxFit.cover,
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      back(),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            'lib/assets/icons/book_mark.svg',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  child: Text(
                    widget.title,
                    style: headStyle,
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'lib/assets/icons/vn.svg',
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.8,
                      child: Text(
                        widget.address,
                        style: bodyStyle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  child: Text(
                    widget.description,
                    style: bodyStyle,
                  ),
                ),
                Text(
                  'Gallery',
                  style: headLineStyle,
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 120,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: widget.image[1],
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Image.asset(
                            'lib/assets/images/market.png',
                            fit: BoxFit.cover,
                            height: 150,
                            width: MediaQuery.sizeOf(context).width * 1,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'lib/assets/images/market.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: widget.image[2],
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Image.asset(
                            'lib/assets/images/market.png',
                            fit: BoxFit.cover,
                            height: 150,
                            width: MediaQuery.sizeOf(context).width * 1,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'lib/assets/images/market.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: widget.image[3],
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Image.asset(
                            'lib/assets/images/market.png',
                            fit: BoxFit.cover,
                            height: 150,
                            width: MediaQuery.sizeOf(context).width * 1,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'lib/assets/images/market.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Text(
                    'History',
                    style: headLineStyle,
                  ),
                ),
                Text(
                  widget.history,
                  style: bodyStyle,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                  ),
                  child: Text(
                    'Feature',
                    style: headLineStyle,
                  ),
                ),
                Text(
                  widget.feature,
                  style: bodyStyle,
                ),
              ],
            ),
          ),
          MaterialButton(
            onPressed: () {},
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: 30,
              ),
              width: MediaQuery.sizeOf(context).width * 1,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  'Start a trip',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.1,
          ),
        ],
      ),
    );
  }
}
