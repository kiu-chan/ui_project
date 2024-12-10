import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ui_project/presentation/screens/home/home_screen.dart';
import 'package:ui_project/presentation/screens/select_screen.dart';
import '../../../../core/constant/assets.dart';
import '../../../../core/constant/color.dart';
import '../../../../core/constant/textStyle.dart';

class ReviewSummary extends StatelessWidget {
  final String image;
  final String title;
  final String date;
  final String group;
  final String budget;

  const ReviewSummary({
    super.key,
    required this.image,
    required this.title,
    required this.date,
    required this.group,
    required this.budget,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backGroundColor,
        centerTitle: true,
        title: Text(
          'Lịch trình',
          style: AppTextStyle.appBarStyle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(LucideIcons.mapPin),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Điểm đến',
                    style: AppTextStyle.headLineStyle,
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 38,
                      right: 30,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://bois.com.vn/wp-content/uploads/2023/12/Kien-truc-pho-co-Ha-Noi-hien-nay.jpg',
                        fit: BoxFit.cover,
                        width: 150,
                        height: 100,
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
                  ),
                  Text(
                    'Phố cổ',
                    style: AppTextStyle.bodyStyle,
                  ),
                ],
              ),
              Divider(
                thickness: 0.5,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(LucideIcons.user),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Đi với',
                    style: AppTextStyle.headLineStyle,
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 38,
                ),
                child: Text(
                  'Một mình 👤',
                  style: AppTextStyle.bodyStyle,
                ),
              ),
              Divider(
                thickness: 0.5,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(LucideIcons.calendar),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Ngày đi',
                    style: AppTextStyle.headLineStyle,
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 38,
                ),
                child: Text(
                  '12/09/2024',
                  style: AppTextStyle.bodyStyle,
                ),
              ),
              Divider(
                thickness: 0.5,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(LucideIcons.circleDollarSign),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    'Tài chính',
                    style: AppTextStyle.headLineStyle,
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 38,
                ),
                child: Text(
                  'Giá rẻ 💰',
                  style: AppTextStyle.bodyStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 10,
                  top: 220,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectPage()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Lưu",
                        style: AppTextStyle.buttonText,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
