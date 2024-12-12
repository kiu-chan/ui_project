// lib/core/utils/trip_data_manager.dart

class TripDataManager {
  // Singleton instance
  static final TripDataManager _instance = TripDataManager._internal();
  factory TripDataManager() => _instance;
  TripDataManager._internal();

  String _destination = '';
  String _imageUrl = '';
  String _date = '';
  String _group = '';
  String _budget = '';

  // Getters
  String get destination => _destination;
  String get imageUrl => _imageUrl;
  String get date => _date;
  String get group => _group; 
  String get budget => _budget;

  // Setters
  void setDestination(String destination, String imageUrl) {
    _destination = destination;
    _imageUrl = imageUrl;
  }

  void setDate(String date) {
    _date = date;
  }

  void setGroup(String group) {
    _group = group;
  }

  void setBudget(String budget) {
    _budget = budget;
  }

  void clear() {
    _destination = '';
    _imageUrl = '';
    _date = '';
    _group = '';
    _budget = '';
  }
}