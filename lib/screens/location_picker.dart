import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPickerPage extends StatefulWidget {
  @override
  _LocationPickerPageState createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  LatLng _pickedLocation =
      const LatLng(24.7136, 46.6753); // Default to Riyadh, KSA

  // Google Maps Controller

  // When the user selects a new location on the map
  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick Location'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // Pass the selected location back
              Navigator.pop(context, _pickedLocation);
            },
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _pickedLocation,
          zoom: 10,
        ),
        onMapCreated: (controller) {},
        onTap: _selectLocation, // Update marker on tap
        markers: {
          Marker(
            markerId: const MarkerId('selectedLocation'),
            position: _pickedLocation,
          ),
        },
      ),
    );
  }
}
