import 'dart:async';
import 'dart:developer';

import 'package:boilerplate_flutter/page/book_controller.dart';
import 'package:boilerplate_flutter/widget/base/alertx.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class BaseMapOpenStreet extends StatefulWidget {
  final double? latitude;
  final double? longitude;
  final double? height;
  final Function(MapDataResult)? onChanged;
  const BaseMapOpenStreet({Key? key, this.onChanged, this.latitude, this.longitude, this.height}) : super(key: key);

  @override
  State<BaseMapOpenStreet> createState() => BaseMapOpenStreetState();
}

class BaseMapOpenStreetState extends State<BaseMapOpenStreet> {
  LocationPermission? _permissionGranted;
  bool loading = false;

  MapController mapController = MapController();
  LatLng point = LatLng(-6.20, 106.81);
  List<LatLng> tappedPoints = [];
  final cBook = Get.find<BookController>();
  @override
  void initState() {
    super.initState();

    if (widget.latitude != null && widget.longitude != null) {
      log('hi');
      point = LatLng(widget.latitude!, widget.longitude!);
      tappedPoints.add(point);
      cBook.selectLat = widget.latitude! as RxDouble;
      cBook.selectLong = widget.longitude! as RxDouble;
    } else {
      cekPermision();
    }
  }

  cekPermision() async {
    var _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    _permissionGranted = await Geolocator.checkPermission();

    log(_permissionGranted.toString());
    if (_permissionGranted == LocationPermission.denied || _permissionGranted == LocationPermission.unableToDetermine) {
      bool isAllow = await Alertx().confirmDialog(
          title: 'Permission location',
          desc: 'Medilab need to access current location to enable find nearest medilab medical facility',
          onPressed2: () async {
            _permissionGranted = await Geolocator.requestPermission();
            log(_permissionGranted.toString());

            if (_permissionGranted == LocationPermission.always || _permissionGranted == LocationPermission.whileInUse) {
              getLocation();
            } else {
              Alertx().error('Harap beri akses lokasi dari pengaturan aplikasi');
            }
          },
          onPressed: () {
            Get.back();
            Get.snackbar('Required permission', 'Harap beri akses lokasi');
          });
      // if (isAllow) {
      // } else {

      //   // Alertx().error('Harap beri akses lokasi dari pengaturan aplikasi');
      // }
    } else if (_permissionGranted == LocationPermission.deniedForever) {
      Alertx().error('Harap beri akses lokasi dari pengaturan aplikasi');
    } else if (_permissionGranted == LocationPermission.always || _permissionGranted == LocationPermission.whileInUse) {
      getLocation();
    }

    // mapController?.animateCamera(
    //   CameraUpdate.newLatLngZoom(
    //     LatLng(currentLocation.latitude, currentLocation.longitude),
    //     20.0,
    //   ),
    // );
    // setState(() {
    // markers.add(Marker(
    //     markerId: markerId,
    //     position: LatLng(currentLocation.latitude, currentLocation.longitude)));
  }

  setMarker(double latitude, double longitude) async {
    log('set marker');

    setState(() {
      tappedPoints.clear();
      tappedPoints.add(LatLng(latitude, longitude));
      mapController.move(LatLng(latitude, longitude), 17);
    });
    // await getAddressFromLatLong(latitude, longitude, true);
  }

  Future<void> getLocation() async {
    setState(() {
      loading = true;
    });
    log('getLocation');
    Position currentLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    if (currentLocation.latitude != null) {
      log("currentLocation.accuracy ${currentLocation.accuracy}");
      await setMarker(currentLocation.latitude, currentLocation.longitude);
      cBook.selectLat.value = currentLocation.latitude;
      cBook.selectLong.value = currentLocation.longitude;
      // if (currentLocation.accuracy < 30) {
      getAddressFromLatLong(currentLocation.latitude, currentLocation.longitude, true);
      // }
    }
    setState(() {
      loading = false;
    });
  }

  Future<void> getAddressFromLatLong(double latitude, double longitude, bool isMove) async {
    //TODO : JIKA bukan web, get addres from plugin
    if (!kIsWeb) {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      // log(placemarks.toString());
      Placemark place = placemarks[0];
      var address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

      if (widget.onChanged != null) {
        widget.onChanged!(MapDataResult(latitude, longitude, address));
      }
    }
    log('-----getaddress------');

    // widget.presensiState.setLatitude(position.latitude);
    // widget.presensiState.setLongitude(position.longitude);
    // widget.presensiState.setAddress(address);
  }

  void _handleTap(var tapPosition, LatLng latlng) {
    setState(() {
      tappedPoints.clear();
      tappedPoints.add(latlng);
      getAddressFromLatLong(latlng.latitude, latlng.longitude, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.latitude != null && widget.longitude != null) {
    //   tappedPoints.add(LatLng(widget.latitude!, widget.longitude!));
    //   point = LatLng(widget.latitude!, widget.longitude!);
    //   setState(() {
    //     mapController.move(point, 17);
    //   });
    // }
    var markers = tappedPoints.map((latlng) {
      return Marker(
        width: 80.0,
        height: 80.0,
        point: latlng,
        builder: (ctx) => Container(
          child: Icon(
            Icons.location_on,
            color: Colors.red,
          ),
        ),
      );
    }).toList();

    return SizedBox(
      width: double.infinity,
      height: widget.height ?? MediaQuery.of(context).size.height * 0.56,
      // double.infinity * 0.56,
      child: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center: point,
              zoom: 17.0,
              onTap: _handleTap,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
                attributionBuilder: (_) {
                  return Text("© OpenStreetMap contributors");
                },
              ),
              MarkerLayerOptions(markers: markers
                  // markers: [
                  //   Marker(
                  //     width: 80.0,
                  //     height: 80.0,
                  //     point: LatLng(gstate.latitude, gstate.longitude),
                  //     builder: (ctx) => Container(
                  //       child: Icon(
                  //         Icons.location_on,
                  //         color: Colors.red,
                  //       ),
                  //     ),
                  //   ),

                  // ],
                  ),
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  cekPermision();
                },
                icon: (loading)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Icon(
                        Icons.my_location,
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MapDataResult {
  final double latitude;
  final double longitude;
  final String address;

  MapDataResult(this.latitude, this.longitude, this.address);
}
