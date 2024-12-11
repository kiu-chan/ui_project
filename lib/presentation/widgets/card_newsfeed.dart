import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui_project/core/constant/assets.dart';

class CardNewsfeed extends StatelessWidget {
  final String userName;
  final String image;
  final Timestamp time;
  final String content;
  final String avatar;
  const CardNewsfeed({
    super.key,
    required this.userName,
    required this.image,
    required this.time,
    required this.content,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 16,
              top: 25,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CachedNetworkImage(
                    imageUrl: avatar,
                    fit: BoxFit.cover,
                    width: 32,
                    height: 32,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Image.asset(
                      AppAssets.Marker,
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      AppAssets.Marker,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      DateFormat('yyyy-MM-dd HH:mm').format(time.toDate()),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
            ),
            child: Text(
              content,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Image.asset(
              AppAssets.Marker,
              fit: BoxFit.cover,
              height: 50,
              width: MediaQuery.sizeOf(context).width * 1,
            ),
            errorWidget: (context, url, error) => Image.asset(
              AppAssets.Marker,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
