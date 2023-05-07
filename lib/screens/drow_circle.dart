import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/attendance_controller.dart';

class MapWithCircle extends StatefulWidget {
  const MapWithCircle({super.key});

  @override
  _MapWithCircleState createState() => _MapWithCircleState();
}

class _MapWithCircleState extends State<MapWithCircle> {
  final Completer<GoogleMapController> _controller = Completer();

  final double _radius = 500;
  Set<Circle> _circles = {};
  final con = Get.put(AttendanceController());

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _updateCircle(LatLng center) {
    setState(() {
      _circles = {
        Circle(
          circleId: const CircleId("circle"),
          center: center,
          radius: _radius,
          fillColor: const Color.fromRGBO(255, 0, 0, 0.5),
          strokeColor: Colors.red,
        )
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(con.center.latitude, con.center.longitude),
          zoom: 16.0,
        ),
        circles: _circles,
        onTap: (LatLng latLng) {
          _updateCircle(latLng);
          print(latLng.latitude);
          print(latLng.longitude);
        },
      ),
    );
  }
}
