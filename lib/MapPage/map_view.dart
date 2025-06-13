import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

class OpenStreetMapPicker extends StatefulWidget {
  final String? initialAddress;
  final LatLng? initialPosition;

  const OpenStreetMapPicker({
    super.key,
    this.initialAddress,
    this.initialPosition,
  });

  @override
  State<OpenStreetMapPicker> createState() => _OpenStreetMapPickerState();
}

class _OpenStreetMapPickerState extends State<OpenStreetMapPicker> {
  LatLng _selectedPosition = LatLng(30.0444, 31.2357); // Cairo
  String _selectedAddress = "اختر موقعك";
  bool _isLoading = false;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    if (widget.initialPosition != null) {
      _selectedPosition = widget.initialPosition!;
    }
    if (widget.initialAddress != null) {
      _selectedAddress = widget.initialAddress!;
    }

    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoading = true);
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        _showSnackBar('تم رفض أذونات الموقع نهائيًا');
        return;
      }

      final position = await Geolocator.getCurrentPosition();
      setState(() {
        _selectedPosition = LatLng(position.latitude, position.longitude);
        _mapController.move(_selectedPosition, 15);
      });

      await _getAddressFromCoordinates(_selectedPosition);
    } catch (e) {
      _showSnackBar("خطأ أثناء الحصول على الموقع الحالي");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _getAddressFromCoordinates(LatLng position) async {
    try {
      print('lat: ${position.latitude}, lng: ${position.longitude}');

      if (position.latitude == 0.0 && position.longitude == 0.0) {
        _showSnackBar('إحداثيات غير صالحة');
        return;
      }

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        setState(() {
          _selectedAddress =
              '${place.street ?? ''}, ${place.subLocality ?? ''}, ${place.locality ?? ''}, ${place.country ?? ''}';
        });
      } else {
        _showSnackBar('لم يتم العثور على عنوان');
      }
    } catch (e) {
      print('Geocoding error: $e');
      _showSnackBar("فشل الحصول على العنوان");
    }
  }

  void _onTapMap(TapPosition tapPosition, LatLng latlng) async {
    setState(() {
      _selectedPosition = latlng;
      _isLoading = true;
    });
    await _getAddressFromCoordinates(latlng);
    setState(() => _isLoading = false);
  }

  void _confirmLocation() {
    Navigator.pop(context, {
      'address': _selectedAddress,
      'position': _selectedPosition,
    });
  }

  void _showSnackBar(String msg) {
    if (!mounted) return; // ⬅️ تأكد إن الواجهة لسه شغالة

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.orange),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("اختر الموقع")),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _selectedPosition,
              initialZoom: 15,
              onTap: _onTapMap,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _selectedPosition,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.location_on,
                      size: 40,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: _confirmLocation,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('تأكيد الموقع'),
            ),
          ),
        ],
      ),
    );
  }
}
