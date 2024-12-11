import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ui_project/application/map_cubit/culture_map_cubit.dart';
import 'package:ui_project/application/map_cubit/des_map_cubit.dart';
import 'package:ui_project/application/map_cubit/fes_map_cubit.dart';
import 'package:ui_project/application/map_cubit/food_map_cubit.dart';
import 'package:ui_project/application/map_cubit/map_cubit.dart';
import 'package:ui_project/core/config/map_config.dart';
import 'package:ui_project/core/constant/color.dart';
import 'package:ui_project/data/models/Map/map_models.dart';
import 'package:ui_project/presentation/screens/map/map_layers.dart';
import 'package:ui_project/presentation/screens/map/nearest_locations_list.dart';
import 'package:ui_project/presentation/screens/map/search_bar.dart';
import 'package:ui_project/presentation/widgets/appbar_root.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Controller để điều khiển bản đồ
  final MapController _mapController = MapController();
  
  // Biến lưu trữ vị trí được chọn trên bản đồ
  LatLng? _selectedLocation;
  
  // Biến kiểm soát việc hiển thị danh sách địa điểm gần đây
  bool _showNearestLocations = false;

  @override
  void initState() {
    super.initState();
    // Khởi tạo dữ liệu cho các layer trên bản đồ
    context.read<MapDesCubit>().getPosition();    // Layer địa điểm du lịch
    context.read<FesMapCubit>().getPosition();    // Layer lễ hội
    context.read<CultureMapCubit>().getPosition(); // Layer văn hóa
    context.read<FoodMapCubit>().getPosition();   // Layer ẩm thực
  }

  @override
  Widget build(BuildContext context) {
    final mapConfig = MapConfig();

    return Scaffold(
      appBar: AppbarRoot(
        title: 'Bản đồ',
      ),
      body: BlocBuilder<UserLocationCubit, MapState>(
        builder: (context, state) {
          // Lấy vị trí mặc định hoặc vị trí hiện tại của người dùng
          final LatLng initialCenter = 
              state.userLocation ?? const LatLng(21.0368973, 105.8320918);

          // Kiểm tra xem bản đồ có đang được di chuyển không
          final bool isMapMoved = state.isMapMoved;

          return Stack(
            children: [
              // Widget bản đồ chính
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: initialCenter,
                  initialZoom: 15,
                  onPositionChanged: (position, bool? hasGesture) {
                    if (state.userLocation != null) {
                      // Cập nhật trạng thái khi bản đồ di chuyển
                      context.read<UserLocationCubit>().onMapMoved(
                            position.center != state.userLocation,
                          );
                    }
                  },
                  onTap: (tapPosition, LatLng latLng) {
                    // Reset trạng thái khi tap vào bản đồ
                    setState(() {
                      _selectedLocation = null;
                      _showNearestLocations = false;
                    });
                  },
                ),
                children: [
                  // Layer bản đồ nền từ Mapbox
                  TileLayer(
                    urlTemplate:
                        'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                    additionalOptions: {
                      'accessToken': mapConfig.MapApi,
                      'id': 'mapbox/streets-v12',
                    },
                  ),
                  // Layer hiển thị vị trí hiện tại
                  CurrentLocationLayer(),
                  // Layer hiển thị các marker
                  MapLayers(selectedLocation: _selectedLocation),
                ],
              ),

              // Thanh tìm kiếm
              Positioned(
                top: 10,
                left: 15,
                right: 15,
                child: MapSearchBar(
                  mapController: _mapController,
                  onLocationSelected: (location) {
                    setState(() {
                      _selectedLocation = location;
                      _showNearestLocations = false;
                    });
                  },
                ),
              ),

              // Nút định vị
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.1,
                right: 15,
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  shape: const CircleBorder(),
                  onPressed: () {
                    if (state.userLocation != null) {
                      // Di chuyển bản đồ đến vị trí hiện tại
                      _mapController.move(state.userLocation!, 15);
                      setState(() {
                        _selectedLocation = null;
                        _showNearestLocations = true;
                      });
                    }
                  },
                  child: Icon(
                    isMapMoved ? LucideIcons.locate : LucideIcons.locateFixed,
                    color: isMapMoved ? Colors.black87 : AppColors.primaryColor,
                    size: 25,
                  ),
                ),
              ),

              // Danh sách địa điểm gần đây
              // Thay đổi phần danh sách địa điểm gần đây trong MapScreen
              if (_showNearestLocations && state.userLocation != null)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    // Thay đổi chiều cao thành 1/2 màn hình
                    height: MediaQuery.of(context).size.height * 0.5, // Thay đổi từ 0.3 thành 0.5
                    child: NearestLocationsList(
                      userLocation: state.userLocation!,
                      mapController: _mapController,
                      onLocationSelected: (location) {
                        setState(() {
                          _selectedLocation = location;
                          _showNearestLocations = false;
                        });
                      },
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
