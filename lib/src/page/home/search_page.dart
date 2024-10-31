import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ui_project/models/Home/destinations_model.dart';
import 'package:ui_project/models/Home/festival_model.dart';
import 'package:ui_project/models/Home/food_model.dart';
import 'package:ui_project/src/page/home/detail.dart';
import 'package:ui_project/utils/style.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

enum Destinations { destination, food, culture, festival }

class _SearchPageState extends State<SearchPage> {
  Destinations _destinations = Destinations.destination;

  void _showFilter() {
    showModalBottomSheet(
        useRootNavigator: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.sizeOf(context).height * 0.6,
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    height: 4,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  AppBar(
                    backgroundColor: Colors.white,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        LucideIcons.arrowLeft,
                      ),
                    ),
                    title: Text(
                      'Filter',
                      style: appBarStyle,
                    ),
                    centerTitle: true,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 15,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    height: 1,
                    width: MediaQuery.sizeOf(context).width * 1,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        title: Text(
                          'Destinations',
                          style: bodyStyle,
                        ),
                        trailing: Radio<Destinations>(
                            activeColor: primaryColor,
                            value: Destinations.destination,
                            groupValue: _destinations,
                            onChanged: (Destinations? value) {
                              setState(() {
                                _destinations = value!;
                              });
                            }),
                      ),
                      ListTile(
                        title: Text(
                          'Food',
                          style: bodyStyle,
                        ),
                        trailing: Radio<Destinations>(
                            activeColor: primaryColor,
                            value: Destinations.food,
                            groupValue: _destinations,
                            onChanged: (Destinations? value) {
                              setState(() {
                                _destinations = value!;
                              });
                            }),
                      ),
                      ListTile(
                        title: Text(
                          'Festival',
                          style: bodyStyle,
                        ),
                        trailing: Radio<Destinations>(
                            activeColor: primaryColor,
                            value: Destinations.festival,
                            groupValue: _destinations,
                            onChanged: (Destinations? value) {
                              setState(() {
                                _destinations = value!;
                              });
                            }),
                      ),
                      ListTile(
                        title: Text(
                          'Culture',
                          style: bodyStyle,
                        ),
                        trailing: Radio<Destinations>(
                            activeColor: primaryColor,
                            value: Destinations.culture,
                            groupValue: _destinations,
                            onChanged: (Destinations? value) {
                              setState(() {
                                _destinations = value!;
                              });
                            }),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 15,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    height: 1,
                    width: MediaQuery.sizeOf(context).width * 1,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 60,
                          ),
                          decoration: BoxDecoration(
                            color: secondColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 60,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text(
                              'OK',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(LucideIcons.arrowLeft),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromRGBO(246, 246, 246, 1),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              LucideIcons.search,
                              size: 18,
                              color: Color.fromRGBO(165, 165, 165, 1),
                            ),
                            hintText: 'Search...',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(165, 165, 165, 1),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                _showFilter();
                              },
                              icon: SvgPicture.asset(
                                'lib/assets/icons/filter.svg',
                                // ignore: deprecated_member_use
                                color: Color.fromRGBO(165, 165, 165, 1),
                                width: 18,
                                height: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 20,
                    left: 15,
                  ),
                  child: Text(
                    'Most Popular Search',
                    style: headLineStyle,
                  ),
                ),
                const DestinationsSearch(),
                const FestivalSearch(),
                const FoodSearch(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Destinations
class DestinationsSearch extends StatefulWidget {
  const DestinationsSearch({super.key});

  @override
  State<DestinationsSearch> createState() => _DestinationsSearchState();
}

class _DestinationsSearchState extends State<DestinationsSearch> {
  final CollectionReference collectionDestinations =
      FirebaseFirestore.instance.collection('Destinations');

  bool isSave = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: destinations.map((destination) {
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
                      child: ListTile(
                        contentPadding: EdgeInsets.all(5),
                        leading: SizedBox(
                          height: MediaQuery.sizeOf(context).height * 1,
                          width: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            child: CachedNetworkImage(
                              imageUrl: destination.image[0],
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      Image.asset(
                                'lib/assets/images/market.png',
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                'lib/assets/images/market.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          destination.title,
                          style: headLineStyle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        subtitle: Row(
                          children: [
                            Expanded(
                              child: Text(
                                destination.address,
                                style: bodyStyle,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        trailing: Icon(
                          LucideIcons.chevronRight,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }
        });
  }
}

// Festival
class FestivalSearch extends StatefulWidget {
  const FestivalSearch({super.key});

  @override
  State<FestivalSearch> createState() => _FestivalSearchState();
}

class _FestivalSearchState extends State<FestivalSearch> {
  final CollectionReference collectionDestinations =
      FirebaseFirestore.instance.collection('Festivals');
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
            List<FestivalModel> festivals = snapshot.data!.docs
                .map(
                  (doc) => FestivalModel.fromJson(
                      doc.data() as Map<String, dynamic>),
                )
                .toList();

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: festivals.map((festival) {
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
                      child: ListTile(
                        contentPadding: EdgeInsets.all(5),
                        leading: SizedBox(
                          height: MediaQuery.sizeOf(context).height * 1,
                          width: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            child: CachedNetworkImage(
                              imageUrl: festival.image[0],
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      Image.asset(
                                'lib/assets/images/market.png',
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                'lib/assets/images/market.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          festival.title,
                          style: headLineStyle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        subtitle: Row(
                          children: [
                            Expanded(
                              child: Text(
                                festival.address,
                                style: bodyStyle,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        trailing: Icon(
                          LucideIcons.chevronRight,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }
        });
  }
}

// Food
class FoodSearch extends StatefulWidget {
  const FoodSearch({super.key});

  @override
  State<FoodSearch> createState() => _FoodSearchState();
}

class _FoodSearchState extends State<FoodSearch> {
  final CollectionReference collectionDestinations =
      FirebaseFirestore.instance.collection('Food');
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
            List<FoodModel> foods = snapshot.data!.docs
                .map(
                  (doc) =>
                      FoodModel.fromJson(doc.data() as Map<String, dynamic>),
                )
                .toList();

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: foods.map((foodd) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              title: foodd.title,
                              image: foodd.image,
                              address: foodd.address[1],
                              description: foodd.description,
                              history: foodd.history,
                              feature: foodd.feature,
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.all(5),
                        leading: SizedBox(
                          height: MediaQuery.sizeOf(context).height * 1,
                          width: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              15,
                            ),
                            child: CachedNetworkImage(
                              imageUrl: foodd.image[0],
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      Image.asset(
                                'lib/assets/images/market.png',
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                'lib/assets/images/market.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          foodd.title,
                          style: headLineStyle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        subtitle: Row(
                          children: [
                            Expanded(
                              child: Text(
                                foodd.address[1],
                                style: bodyStyle,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        trailing: Icon(
                          LucideIcons.chevronRight,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }
        });
  }
}
