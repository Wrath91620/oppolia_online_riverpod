// lib/models/profile.dart
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Profile {
  String name;
  String email;
  String phone;
  String address;
  LatLng? location;

  Profile({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    this.location,
  });
}
