import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart';
import 'package:oppolia_online/l10n/generated/app_localizations.dart';
import 'package:oppolia_online/screens/drawer_page.dart';
import 'package:oppolia_online/screens/location_picker.dart';
import 'package:oppolia_online/constants/ApiKeys.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio(BaseOptions(
  baseUrl: 'https://yourapi.com', // Your backend base URL
  connectTimeout: Duration(milliseconds: 5000), // Connection timeout
  receiveTimeout: Duration(milliseconds: 3000), // Receive timeout
));

class EditProfilePage extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String address;
  final LatLng? location;

  EditProfilePage({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    this.location,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  LatLng? _selectedLocation;
  bool _isLoading = false;

  get apiKey => null; // Loading indicator

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _emailController = TextEditingController(text: widget.email);
    _phoneController = TextEditingController(text: widget.phone);
    _addressController = TextEditingController(text: widget.address);
    _selectedLocation = widget.location;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickLocation() async {
    final pickedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationPickerPage(),
      ),
    );

    if (pickedLocation != null) {
      setState(() {
        _selectedLocation = pickedLocation;
      });
      await _fetchAddress();
    }
  }

  Future<void> _fetchAddress() async {
    if (_selectedLocation == null) return;

    setState(() => _isLoading = true);
    try {
      final response = await dio.get(
        'https://maps.googleapis.com/maps/$apiKey/geocode/json',
        queryParameters: {
          'latlng':
              '${_selectedLocation!.latitude},${_selectedLocation!.longitude}',
          'key': apiKey,
        },
      );

      if (response.statusCode == 200 && response.data['results'].isNotEmpty) {
        setState(() {
          _addressController.text =
              response.data['results'][0]['formatted_address'];
        });
      }
    } catch (e) {
      print("Error fetching address: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch address.')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', _nameController.text);
    await prefs.setString('userEmail', _emailController.text);
    await prefs.setString('userPhone', _phoneController.text);
    await prefs.setString('userAddress', _addressController.text);

    Navigator.pop(context, {
      'name': _nameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
      'address': _addressController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.profile_title),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveProfile,
          ),
        ],
      ),
      drawer: DrawerPage(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildTextField(
                AppLocalizations.of(context)!.profile_name, _nameController),
            SizedBox(height: 10),
            buildTextField(
                AppLocalizations.of(context)!.profile_email, _emailController),
            SizedBox(height: 10),
            buildTextField(
                AppLocalizations.of(context)!.profile_phone, _phoneController),
            SizedBox(height: 10),
            buildTextField(AppLocalizations.of(context)!.profile_address,
                _addressController),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _pickLocation,
                  child: const Icon(
                    Icons.location_searching_rounded,
                    color: Colors.brown,
                  ),
                ),
                if (_isLoading)
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller) {
    return TextField(
      controller: controller,
      cursorColor: Colors.brown,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.brown),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.brown, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.brown, width: 2.0),
        ),
      ),
    );
  }
}
