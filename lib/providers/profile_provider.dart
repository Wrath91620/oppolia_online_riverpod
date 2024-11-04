// lib/providers/profile_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/profile.dart';

class ProfileNotifier extends StateNotifier<Profile> {
  ProfileNotifier()
      : super(Profile(
          name: 'John Doe',
          email: 'John@email.com',
          phone: '0988646467',
          address: 'Kafarsouseh',
          location: null,
        ));

  void updateName(String name) => state = Profile(
        name: name,
        email: state.email,
        phone: state.phone,
        address: state.address,
        location: state.location,
      );

  void updateEmail(String email) => state = Profile(
        name: state.name,
        email: email,
        phone: state.phone,
        address: state.address,
        location: state.location,
      );

  void updatePhone(String phone) => state = Profile(
        name: state.name,
        email: state.email,
        phone: phone,
        address: state.address,
        location: state.location,
      );

  void updateAddress(String address) => state = Profile(
        name: state.name,
        email: state.email,
        phone: state.phone,
        address: address,
        location: state.location,
      );

  void updateLocation(LatLng location) => state = Profile(
        name: state.name,
        email: state.email,
        phone: state.phone,
        address: state.address,
        location: location,
      );
}

final profileProvider =
    StateNotifierProvider<ProfileNotifier, Profile>((ref) => ProfileNotifier());
