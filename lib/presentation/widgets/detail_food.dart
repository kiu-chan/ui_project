import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:ui_project/core/constant/assets.dart';
import 'package:ui_project/core/constant/button.dart';
import 'package:ui_project/core/constant/color.dart';
import 'package:ui_project/core/constant/textStyle.dart';
import '../screens/home/start_trip/step_screen.dart';

class DetailFoodPage extends StatefulWidget {
  final String title;
  final List<String> image;
  final String address;
  final String description;
  final String history;
  final String feature;
  final String ingredients;

  const DetailFoodPage({
    Key? key,
    required this.title,
    required this.image,
    required this.address,
    required this.description,
    required this.history,
    required this.feature,
    required this.ingredients,
  }) : super(key: key);

  @override
  State<DetailFoodPage> createState() => _DetailFoodPageState();
}

class _DetailFoodPageState extends State<DetailFoodPage> with SingleTickerProviderStateMixin {
  final isLogin = FirebaseAuth.instance.currentUser;
  final CollectionReference collectDestinations =
      FirebaseFirestore.instance.collection('Destinations');
  
  late ScrollController _scrollController;
  late AnimationController _animationController;
  bool _showTitle = false;
  final _imageHeight = 300.0;
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _showTitle = _scrollController.offset > _imageHeight - kToolbarHeight;
        });
      });
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildAppBar() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      color: _showTitle ? Colors.white : Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildBackButton(),
            if (_showTitle)
              Expanded(
                child: Text(
                  widget.title,
                  style: AppTextStyle.headLineStyle.copyWith(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            _buildBookmarkButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: back(),
    );
  }

  Widget _buildBookmarkButton() {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        onPressed: () {
          setState(() {
            _isBookmarked = !_isBookmarked;
          });
          // TODO: Implement bookmark functionality
        },
        icon: SvgPicture.asset(
          AppAssets.BookMark,
          color: _isBookmarked ? AppColors.primaryColor : null,
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return SizedBox(
      height: _imageHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            tag: 'food_${widget.title}',
            child: CachedNetworkImage(
              imageUrl: widget.image[0],
              fit: BoxFit.cover,
              placeholder: (context, url) => Image.asset(
                AppAssets.Marker,
                fit: BoxFit.cover,
              ),
              errorWidget: (context, url, error) => Image.asset(
                AppAssets.Marker,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.4),
                  Colors.transparent,
                  Colors.black.withOpacity(0.4),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGallerySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ảnh minh họa', style: AppTextStyle.headLineStyle),
        const SizedBox(height: 16),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.image.length - 1,
            itemBuilder: (context, index) {
              final i = index + 1;
              return Padding(
                padding: EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () {
                    // TODO: Implement full-screen gallery view
                  },
                  child: Hero(
                    tag: 'gallery_$i',
                    child: Container(
                      width: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: widget.image[i],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            AppAssets.Marker,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection({
    required String title,
    required String content,
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 24, color: AppColors.primaryColor),
              const SizedBox(width: 8),
            ],
            Text(title, style: AppTextStyle.headLineStyle),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          content,
          style: AppTextStyle.bodyStyle.copyWith(
            height: 1.5,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 20,
        bottom: MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
        onPressed: () {
          if (isLogin != null) {
            pushWithoutNavBar(
              context,
              MaterialPageRoute(builder: (context) => StepScreen()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Vui lòng đăng nhập để tạo lịch trình'),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height - 100,
                  right: 20,
                  left: 20,
                ),
              ),
            );
          }
        },
        child: Text(
          "Tạo lịch trình",
          style: AppTextStyle.buttonText.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageSection(),
                Container(
                  margin: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: AppTextStyle.headStyle.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.Vn,
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              widget.address,
                              style: AppTextStyle.bodyStyle.copyWith(
                                color: Colors.black54,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 32),
                      _buildInfoSection(
                        title: 'Giới thiệu',
                        content: widget.description,
                        icon: Icons.restaurant_menu,
                      ),
                      const SizedBox(height: 24),
                      _buildGallerySection(),
                      const Divider(height: 32),
                      _buildInfoSection(
                        title: 'Nguyên liệu',
                        content: widget.ingredients,
                        icon: Icons.kitchen,
                      ),
                      const Divider(height: 32),
                      _buildInfoSection(
                        title: 'Lịch sử',
                        content: widget.history,
                        icon: Icons.history,
                      ),
                      const Divider(height: 32),
                      _buildInfoSection(
                        title: 'Đặc trưng',
                        content: widget.feature,
                        icon: Icons.star_outline,
                      ),
                      const SizedBox(height: 100), // Space for bottom button
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildAppBar(),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomButton(),
          ),
        ],
      ),
    );
  }
}