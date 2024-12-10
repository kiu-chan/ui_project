// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:lucide_icons/lucide_icons.dart';
// import 'package:ui_project/core/constant/assets.dart';
// import 'package:ui_project/core/constant/color.dart';
// import 'package:ui_project/core/constant/textStyle.dart';
// import 'package:ui_project/data/models/Home/culture_model.dart';
// import 'package:ui_project/data/models/Home/destinations_model.dart';
// import 'package:ui_project/data/models/Home/festival_model.dart';
// import 'package:ui_project/data/models/Home/food_model.dart';
// import 'package:ui_project/presentation/widgets/detail.dart';

// class SearchPage extends StatefulWidget {
//   const SearchPage({super.key});

//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }

// enum Destinations { Destination, Food, Culture, Festival }

// class _SearchPageState extends State<SearchPage> {
//   Set<Destinations> _selectedFilters = {Destinations.Destination};
//   TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';

//   void _showFilter() {
//     showModalBottomSheet(
//         useRootNavigator: true,
//         context: context,
//         builder: (BuildContext context) {
//           Set<Destinations> tempSelectedFilters = Set.from(_selectedFilters);
//           return Container(
//             height: MediaQuery.sizeOf(context).height * 0.6,
//             padding: const EdgeInsets.symmetric(horizontal: 15),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   const SizedBox(height: 10),
//                   Container(
//                     margin: const EdgeInsets.symmetric(vertical: 10),
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                     height: 4,
//                     width: 40,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(50),
//                     ),
//                   ),
//                   AppBar(
//                     backgroundColor: Colors.white,
//                     leading: IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: const Icon(LucideIcons.arrowLeft),
//                     ),
//                     title: const Text(
//                       'Filter',
//                       style: TextStyle(color: Colors.black),
//                     ),
//                     centerTitle: true,
//                   ),
//                   Container(
//                     margin: const EdgeInsets.symmetric(
//                         vertical: 15, horizontal: 15),
//                     height: 1,
//                     width: MediaQuery.sizeOf(context).width * 1,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                       borderRadius: BorderRadius.circular(50),
//                     ),
//                   ),
//                   ListView(
//                     physics: const NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     children: Destinations.values.map((destination) {
//                       return ListTile(
//                         title: Text(
//                           destination.toString().split('.').last,
//                           style: const TextStyle(fontSize: 16),
//                         ),
//                         trailing: Checkbox(
//                           activeColor: AppColors.primaryColor,
//                           value: tempSelectedFilters.contains(destination),
//                           onChanged: (bool? value) {
//                             setState(() {
//                               if (value == true) {
//                                 tempSelectedFilters.add(destination);
//                               } else {
//                                 tempSelectedFilters.remove(destination);
//                               }
//                             });
//                           },
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Container(
//             margin: const EdgeInsets.symmetric(horizontal: 15),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: const Icon(LucideIcons.arrowLeft),
//                     ),
//                     Expanded(
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(vertical: 20),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           color: const Color.fromRGBO(246, 246, 246, 1),
//                         ),
//                         child: TextField(
//                           controller: _searchController,
//                           onChanged: (value) {
//                             setState(() {
//                               _searchQuery = value.toLowerCase();
//                             });
//                           },
//                           decoration: InputDecoration(
//                             contentPadding:
//                                 const EdgeInsets.symmetric(vertical: 15),
//                             border: InputBorder.none,
//                             prefixIcon: const Icon(
//                               LucideIcons.search,
//                               size: 18,
//                               color: Color.fromRGBO(165, 165, 165, 1),
//                             ),
//                             hintText: 'Search...',
//                             hintStyle: const TextStyle(
//                                 fontSize: 16,
//                                 color: Color.fromRGBO(165, 165, 165, 1)),
//                             suffixIcon: IconButton(
//                               onPressed: _showFilter,
//                               icon: SvgPicture.asset(
//                                 AppAssets.Filter,
//                                 // ignore: deprecated_member_use
//                                 color: const Color.fromRGBO(165, 165, 165, 1),
//                                 width: 18,
//                                 height: 18,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 20, left: 15),
//                   child: const Text('Most Popular Search',
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                 ),
//                 ..._selectedFilters.map((filter) {
//                   switch (filter) {
//                     case Destinations.Food:
//                       return FoodSearch(searchQuery: _searchQuery);
//                     case Destinations.Festival:
//                       return FestivalSearch(searchQuery: _searchQuery);
//                     case Destinations.Culture:
//                       return CultureSearch(searchQuery: _searchQuery);
//                     case Destinations.Destination:
//                     default:
//                       return DestinationsSearch(searchQuery: _searchQuery);
//                   }
//                 }).toList(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Destinations
// class DestinationsSearch extends StatefulWidget {
//   final String searchQuery;
//   const DestinationsSearch({super.key, required this.searchQuery});

//   @override
//   State<DestinationsSearch> createState() => _DestinationsSearchState();
// }

// class _DestinationsSearchState extends State<DestinationsSearch> {
//   final CollectionReference collectionDestinations =
//       FirebaseFirestore.instance.collection('Destinations');

//   bool isSave = false;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: collectionDestinations.get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else {
//             List<DestinationsModels> destinations = snapshot.data!.docs
//                 .map(
//                   (doc) => DestinationsModels.fromJson(
//                       doc.data() as Map<String, dynamic>),
//                 )
//                 .toList();

//             return SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: destinations.map((destination) {
//                   return Padding(
//                     padding: const EdgeInsets.only(right: 15),
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => DetailPage(
//                               title: destination.title,
//                               image: destination.image,
//                               address: destination.address,
//                               description: destination.description,
//                               history: destination.history,
//                               feature: destination.feature,
//                             ),
//                           ),
//                         );
//                       },
//                       child: ListTile(
//                         contentPadding: EdgeInsets.all(5),
//                         leading: SizedBox(
//                           height: MediaQuery.sizeOf(context).height * 1,
//                           width: 80,
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(
//                               15,
//                             ),
//                             child: CachedNetworkImage(
//                               imageUrl: destination.image[0],
//                               fit: BoxFit.cover,
//                               progressIndicatorBuilder:
//                                   (context, url, downloadProgress) =>
//                                       Image.asset(
//                                 AppAssets.Marker,
//                                 fit: BoxFit.cover,
//                               ),
//                               errorWidget: (context, url, error) => Image.asset(
//                                 AppAssets.Marker,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ),
//                         title: Text(
//                           destination.title,
//                           style: AppTextStyle.headLineStyle,
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 1,
//                         ),
//                         subtitle: Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 destination.address,
//                                 style: AppTextStyle.bodyStyle,
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 1,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                           ],
//                         ),
//                         trailing: Icon(
//                           LucideIcons.chevronRight,
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             );
//           }
//         });
//   }
// }

// // Festival
// class FestivalSearch extends StatefulWidget {
//   final String searchQuery;
//   const FestivalSearch({super.key, required this.searchQuery});

//   @override
//   State<FestivalSearch> createState() => _FestivalSearchState();
// }

// class _FestivalSearchState extends State<FestivalSearch> {
//   final CollectionReference collectionDestinations =
//       FirebaseFirestore.instance.collection('Festivals');
//   bool isSave = false;
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: collectionDestinations.get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else {
//             List<FestivalModel> festivals = snapshot.data!.docs
//                 .map(
//                   (doc) => FestivalModel.fromJson(
//                       doc.data() as Map<String, dynamic>),
//                 )
//                 .toList();

//             return SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: festivals.map((festival) {
//                   return Padding(
//                     padding: const EdgeInsets.only(right: 15),
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => DetailPage(
//                               title: festival.title,
//                               image: festival.image,
//                               address: festival.address,
//                               description: festival.description,
//                               history: festival.history,
//                               feature: festival.feature,
//                             ),
//                           ),
//                         );
//                       },
//                       child: ListTile(
//                         contentPadding: EdgeInsets.all(5),
//                         leading: SizedBox(
//                           height: MediaQuery.sizeOf(context).height * 1,
//                           width: 80,
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(
//                               15,
//                             ),
//                             child: CachedNetworkImage(
//                               imageUrl: festival.image[0],
//                               fit: BoxFit.cover,
//                               progressIndicatorBuilder:
//                                   (context, url, downloadProgress) =>
//                                       Image.asset(
//                                 AppAssets.Marker,
//                                 fit: BoxFit.cover,
//                               ),
//                               errorWidget: (context, url, error) => Image.asset(
//                                 AppAssets.Marker,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ),
//                         title: Text(
//                           festival.title,
//                           style: AppTextStyle.headLineStyle,
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 1,
//                         ),
//                         subtitle: Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 festival.address,
//                                 style: AppTextStyle.bodyStyle,
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 1,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                           ],
//                         ),
//                         trailing: Icon(
//                           LucideIcons.chevronRight,
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             );
//           }
//         });
//   }
// }

// // Food
// class FoodSearch extends StatefulWidget {
//   final String searchQuery;
//   const FoodSearch({super.key, required this.searchQuery});

//   @override
//   State<FoodSearch> createState() => _FoodSearchState();
// }

// class _FoodSearchState extends State<FoodSearch> {
//   final CollectionReference collectionDestinations =
//       FirebaseFirestore.instance.collection('Food');
//   bool isSave = false;
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: collectionDestinations.get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else {
//             List<FoodModel> foods = snapshot.data!.docs
//                 .map(
//                   (doc) =>
//                       FoodModel.fromJson(doc.data() as Map<String, dynamic>),
//                 )
//                 .toList();

//             return SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: foods.map((foodd) {
//                   return Padding(
//                     padding: const EdgeInsets.only(right: 15),
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => DetailPage(
//                               title: foodd.title,
//                               image: foodd.image,
//                               address: foodd.address[1],
//                               description: foodd.description,
//                               history: foodd.history,
//                               feature: foodd.feature,
//                             ),
//                           ),
//                         );
//                       },
//                       child: ListTile(
//                         contentPadding: EdgeInsets.all(5),
//                         leading: SizedBox(
//                           height: MediaQuery.sizeOf(context).height * 1,
//                           width: 80,
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(
//                               15,
//                             ),
//                             child: CachedNetworkImage(
//                               imageUrl: foodd.image[0],
//                               fit: BoxFit.cover,
//                               progressIndicatorBuilder:
//                                   (context, url, downloadProgress) =>
//                                       Image.asset(
//                                 AppAssets.Marker,
//                                 fit: BoxFit.cover,
//                               ),
//                               errorWidget: (context, url, error) => Image.asset(
//                                 AppAssets.Marker,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ),
//                         title: Text(
//                           foodd.title,
//                           style: AppTextStyle.headLineStyle,
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 1,
//                         ),
//                         subtitle: Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 foodd.address[1],
//                                 style: AppTextStyle.bodyStyle,
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 1,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                           ],
//                         ),
//                         trailing: Icon(
//                           LucideIcons.chevronRight,
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             );
//           }
//         });
//   }
// }

// // Culture
// class CultureSearch extends StatefulWidget {
//   final String searchQuery;
//   const CultureSearch({super.key, required this.searchQuery});

//   @override
//   State<CultureSearch> createState() => _CultureSearchState();
// }

// class _CultureSearchState extends State<CultureSearch> {
//   final CollectionReference collectionDestinations =
//       FirebaseFirestore.instance.collection('Culture');
//   bool isSave = false;
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: collectionDestinations.get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else {
//             List<CultureModel> cultures = snapshot.data!.docs
//                 .map(
//                   (doc) =>
//                       CultureModel.fromJson(doc.data() as Map<String, dynamic>),
//                 )
//                 .toList();

//             return SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: cultures.map((culture) {
//                   return Padding(
//                     padding: const EdgeInsets.only(right: 15),
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => DetailPage(
//                               title: culture.title,
//                               image: culture.image,
//                               address: culture.address[1],
//                               description: culture.description,
//                               history: culture.history,
//                               feature: culture.feature[1],
//                             ),
//                           ),
//                         );
//                       },
//                       child: ListTile(
//                         contentPadding: EdgeInsets.all(5),
//                         leading: SizedBox(
//                           height: MediaQuery.sizeOf(context).height * 1,
//                           width: 80,
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(
//                               15,
//                             ),
//                             child: CachedNetworkImage(
//                               imageUrl: culture.image[0],
//                               fit: BoxFit.cover,
//                               progressIndicatorBuilder:
//                                   (context, url, downloadProgress) =>
//                                       Image.asset(
//                                 AppAssets.Marker,
//                                 fit: BoxFit.cover,
//                               ),
//                               errorWidget: (context, url, error) => Image.asset(
//                                 AppAssets.Marker,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ),
//                         title: Text(
//                           culture.title,
//                           style: AppTextStyle.headLineStyle,
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 1,
//                         ),
//                         subtitle: Row(
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 culture.address,
//                                 style: AppTextStyle.bodyStyle,
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 1,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                           ],
//                         ),
//                         trailing: Icon(
//                           LucideIcons.chevronRight,
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             );
//           }
//         });
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:ui_project/application/map_cubit/culture_map_cubit.dart';
import 'package:ui_project/application/map_cubit/des_map_cubit.dart';
import 'package:ui_project/application/map_cubit/fes_map_cubit.dart';
import 'package:ui_project/application/map_cubit/food_map_cubit.dart';
import 'package:ui_project/core/constant/color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ui_project/core/constant/assets.dart';
import 'package:ui_project/core/constant/textStyle.dart';

class MapSearchBar extends StatefulWidget {
  final MapController mapController;
  final Function(LatLng?) onLocationSelected;

  const MapSearchBar({
    Key? key,
    required this.mapController,
    required this.onLocationSelected,
  }) : super(key: key);

  @override
  State<MapSearchBar> createState() => _MapSearchBarState();
}

class _MapSearchBarState extends State<MapSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  List<SearchResult> _searchResults = [];
  bool _isSearching = false;

  void _handleSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _searchResults.clear();
      });
      return;
    }

    final List<SearchResult> results = [];
    
    // Search in destinations
    final destinations = context.read<MapDesCubit>().state;
    results.addAll(destinations
        .where((dest) => dest.title.toLowerCase().contains(query.toLowerCase()) ||
            dest.address.toLowerCase().contains(query.toLowerCase()))
        .map((dest) => SearchResult(
              title: dest.title,
              address: dest.address,
              location: dest.location,
              type: 'Địa điểm du lịch',
              image: dest.image[0],
            )));

    // Search in festivals
    final festivals = context.read<FesMapCubit>().state;
    results.addAll(festivals
        .where((fest) => fest.title.toLowerCase().contains(query.toLowerCase()) ||
            fest.address.toLowerCase().contains(query.toLowerCase()))
        .map((fest) => SearchResult(
              title: fest.title,
              address: fest.address,
              location: fest.location,
              type: 'Lễ hội',
              image: fest.image[0],
            )));

    // Search in cultures
    final cultures = context.read<CultureMapCubit>().state;
    results.addAll(cultures
        .where((cult) => cult.title.toLowerCase().contains(query.toLowerCase()) ||
            cult.address.toLowerCase().contains(query.toLowerCase()))
        .map((cult) => SearchResult(
              title: cult.title,
              address: cult.address,
              location: cult.location,
              type: 'Văn hóa',
              image: cult.image[0],
            )));

    // Search in foods
    final foods = context.read<FoodMapCubit>().state;
    results.addAll(foods
        .where((food) => food.title.toLowerCase().contains(query.toLowerCase()) ||
            food.address.toLowerCase().contains(query.toLowerCase()))
        .map((food) => SearchResult(
              title: food.title,
              address: food.address,
              location: food.location,
              type: 'Ẩm thực',
              image: food.image[0],
            )));

    setState(() {
      _isSearching = true;
      _searchResults = results;
    });
  }

  void _animateToLocation(LatLng location) {
    const double zoomLevel = 17.0;
    widget.mapController.move(location, zoomLevel);
    widget.onLocationSelected(location);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextField(
            controller: _searchController,
            onChanged: _handleSearch,
            decoration: InputDecoration(
              hintText: 'Tìm kiếm địa điểm...',
              border: InputBorder.none,
              icon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                          _searchResults.clear();
                          _isSearching = false;
                          widget.onLocationSelected(null);
                        });
                      },
                    )
                  : null,
            ),
          ),
        ),
        if (_isSearching && _searchResults.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.3,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final result = _searchResults[index];
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: result.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          Image.asset(
                        AppAssets.Marker,
                        fit: BoxFit.cover,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        AppAssets.Marker,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    result.title,
                    style: AppTextStyle.headLineStyle,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        result.type,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        result.address,
                        style: AppTextStyle.bodyStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  onTap: () {
                    _animateToLocation(result.location);
                    setState(() {
                      _isSearching = false;
                      _searchResults.clear();
                      _searchController.clear();
                    });
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}


class SearchResult {
  final String title;
  final String address;
  final LatLng location;
  final String type;
  final String image;

  SearchResult({
    required this.title,
    required this.address,
    required this.location,
    required this.type,
    required this.image,
  });
}