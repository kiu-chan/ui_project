import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ui_project/models/Home/destinations_model.dart';
import 'package:ui_project/models/Home/festival_model.dart';
import 'package:ui_project/models/Home/food_model.dart';
import 'package:ui_project/src/page/home/Culture/culture.dart';
import 'package:ui_project/src/page/home/Destinations/destinations.dart';
import 'package:ui_project/src/page/home/Food/detail_food.dart';
import 'package:ui_project/src/page/home/detail.dart';
import 'package:ui_project/src/page/home/Festival/festival.dart';
import 'package:ui_project/src/page/home/Food/food.dart';
import 'package:ui_project/src/page/home/search_page.dart';
import 'package:ui_project/utils/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Image.asset('lib/assets/images/market.png'),
        title: Text(
          'Hello',
          style: appBarStyle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Search(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Popular Destionations',
                      style: headLineStyle,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DestinationsPage(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          'View All',
                          style: viewAllStyle,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          LucideIcons.arrowRight,
                          color: primaryColor,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              PopularDestinations(),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Popular Festival',
                      style: headLineStyle,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FestivalPage(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          'View All',
                          style: viewAllStyle,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          LucideIcons.arrowRight,
                          color: primaryColor,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              PopularFestival(),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Popular Food',
                      style: headLineStyle,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FoodPage(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          'View All',
                          style: viewAllStyle,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          LucideIcons.arrowRight,
                          color: primaryColor,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              PopularFood(),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Popular Culture',
                      style: headLineStyle,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CulturesPage(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          'View All',
                          style: viewAllStyle,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          LucideIcons.arrowRight,
                          color: primaryColor,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              PopularCulture(),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Search bar
class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchPage(),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color.fromRGBO(246, 246, 246, 1),
        ),
        child: ListTile(
          leading: Icon(
            LucideIcons.search,
            size: 18,
            color: Color.fromRGBO(165, 165, 165, 1),
          ),
          title: Text(
            'Search',
            style: TextStyle(
              fontSize: 16,
              color: Color.fromRGBO(165, 165, 165, 1),
            ),
          ),
        ),
      ),
    );
  }
}

// List popular destinations
class PopularDestinations extends StatefulWidget {
  const PopularDestinations({super.key});

  @override
  State<PopularDestinations> createState() => _PopularDestinationsState();
}

class _PopularDestinationsState extends State<PopularDestinations> {
  final CollectionReference collectionDestinations =
      FirebaseFirestore.instance.collection('Destinations');
  bool isSave = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: collectionDestinations.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
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

            List<DestinationsModels> hotDestinations = destinations
                .where((destination) => destination.isHot == 1)
                .toList();

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: hotDestinations.map((destination) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
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
                      child: _cardDestination(
                        CachedNetworkImage(
                          imageUrl: destination.image[0],
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Image.asset(
                            'lib/assets/images/market.png',
                            fit: BoxFit.cover,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'lib/assets/images/market.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        destination.title,
                        SvgPicture.asset(
                          'lib/assets/icons/vn.svg',
                          width: 20,
                          height: 20,
                        ),
                        destination.address,
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }
        });
  }

  // Style card
  Widget _cardDestination(
      Widget image, String title, SvgPicture flag, String address) {
    return SizedBox(
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 140,
                width: 220,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                    child: image),
              ),
              // save
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
                            'lib/assets/icons/book_mark_fill.svg')
                        : SvgPicture.asset('lib/assets/icons/book_mark.svg'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: headLineStyle,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              flag,
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  address,
                  style: bodyStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// List popular festival
class PopularFestival extends StatefulWidget {
  const PopularFestival({super.key});

  @override
  State<PopularFestival> createState() => _PopularFestivalState();
}

class _PopularFestivalState extends State<PopularFestival> {
  final CollectionReference collectionFestival =
      FirebaseFirestore.instance.collection('Festivals');
  bool isSave = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: collectionFestival.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<FestivalModel> festivals = snapshot.data!.docs
                .map(
                  (doc) => FestivalModel.fromJson(
                      doc.data() as Map<String, dynamic>),
                )
                .cast<FestivalModel>()
                .toList();

            List<FestivalModel> hotFestivals = festivals
                .where((destination) => destination.isHot == 1)
                .toList();

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: hotFestivals.map((festival) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              title: festival.title,
                              image: festival.image,
                              address: festival.address,
                              description: festival.description,
                              history: festival.history,
                              feature: festival.feature,
                            ),
                          ),
                        );
                      },
                      child: _cardFestival(
                        CachedNetworkImage(
                          imageUrl: festival.image[0],
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Image.asset(
                            'lib/assets/images/market.png',
                            fit: BoxFit.cover,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'lib/assets/images/market.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        festival.title,
                        festival.address,
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }
        });
  }

  // Style card
  Widget _cardFestival(Widget image, String title, String address) {
    return SizedBox(
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 140,
                width: 220,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                    child: image),
              ),
              // save
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
                            'lib/assets/icons/book_mark_fill.svg')
                        : SvgPicture.asset('lib/assets/icons/book_mark.svg'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: headLineStyle,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  address,
                  style: bodyStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// List popular food
class PopularFood extends StatefulWidget {
  const PopularFood({super.key});

  @override
  State<PopularFood> createState() => _PopularFoodState();
}

class _PopularFoodState extends State<PopularFood> {
  final CollectionReference collectionFood =
      FirebaseFirestore.instance.collection('Food');
  bool isSave = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: collectionFood.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
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

            List<FoodModel> hotFoods =
                foods.where((food) => food.isHot == 1).toList();

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: hotFoods.map((food) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailFoodPage(
                              title: food.title,
                              image: food.image,
                              address: food.address,
                              description: food.description,
                              history: food.history,
                              feature: food.feature,
                              ingredients: food.ingredients,
                            ),
                          ),
                        );
                      },
                      child: _cardFood(
                        CachedNetworkImage(
                          imageUrl: food.image[0],
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Image.asset(
                            'lib/assets/images/market.png',
                            fit: BoxFit.cover,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'lib/assets/images/market.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        food.title,
                        SvgPicture.asset(
                          'lib/assets/icons/vn.svg',
                          width: 20,
                          height: 20,
                        ),
                        food.address[1],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }
        });
  }

  // Style card
  Widget _cardFood(
      Widget image, String title, SvgPicture flag, String address) {
    return SizedBox(
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 140,
                width: 220,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                    child: image),
              ),
              // save
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
                            'lib/assets/icons/book_mark_fill.svg')
                        : SvgPicture.asset('lib/assets/icons/book_mark.svg'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: headLineStyle,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              flag,
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  address,
                  style: bodyStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// List popular culture
class PopularCulture extends StatefulWidget {
  const PopularCulture({super.key});

  @override
  State<PopularCulture> createState() => _PopularCultureState();
}

class _PopularCultureState extends State<PopularCulture> {
  final CollectionReference collectionCulture =
      FirebaseFirestore.instance.collection('Culture');
  bool isSave = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: collectionCulture.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
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

            List<FoodModel> hotFoods =
                foods.where((food) => food.isHot == 1).toList();

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: hotFoods.map((food) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailFoodPage(
                              title: food.title,
                              image: food.image,
                              address: food.address,
                              description: food.description,
                              history: food.history,
                              feature: food.feature,
                              ingredients: food.ingredients,
                            ),
                          ),
                        );
                      },
                      child: _cardFood(
                        CachedNetworkImage(
                          imageUrl: food.image[0],
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Image.asset(
                            'lib/assets/images/market.png',
                            fit: BoxFit.cover,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'lib/assets/images/market.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        food.title,
                        SvgPicture.asset(
                          'lib/assets/icons/vn.svg',
                          width: 20,
                          height: 20,
                        ),
                        food.address[1],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }
        });
  }

  // Style card
  Widget _cardFood(
      Widget image, String title, SvgPicture flag, String address) {
    return SizedBox(
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 140,
                width: 220,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                    child: image),
              ),
              // save
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
                            'lib/assets/icons/book_mark_fill.svg')
                        : SvgPicture.asset('lib/assets/icons/book_mark.svg'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: headLineStyle,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              flag,
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  address,
                  style: bodyStyle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
