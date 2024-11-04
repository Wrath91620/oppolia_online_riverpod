import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oppolia_online/api_service.dart';
import 'package:oppolia_online/providers/apiservice_provider.dart';

class User {
  String name = "كريم";
  String email = "Karim@gmail.com";
  String phone = "123456789";
  String address = "Kafarsouseh";
  LatLng? location = [24.774265, 46.738586] as LatLng?;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    this.location,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      location: LatLng(json['lat'] as double, json['lng'] as double),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'lat': location?.latitude,
      'lng': location?.longitude,
    };
  }
}

class UserNotifier extends StateNotifier<User?> {
  final ApiService _apiService;

  UserNotifier(this._apiService) : super(null);

  Future<void> fetchUser() async {
    try {
      final response = await _apiService.getData('/user'); // Adjust endpoint
      state = User.fromJson(response.data);
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> updateUser(User updatedUser) async {
    try {
      final response = await _apiService.putData(
          '/user/${updatedUser.name}', updatedUser.toJson()); // Adjust endpoint
      state = User.fromJson(response.data);
    } catch (e) {
      print("Error updating user data: $e");
    }
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return UserNotifier(apiService);
});
