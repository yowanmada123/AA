// import 'dart:async';
// import 'dart:collection';
// import 'dart:developer';

// import 'package:farmalab_mobile/utils/string.dart';
// import 'package:farmalab_mobile/widget/base/alertx.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart' as geoLoc;
// import 'package:location/location.dart';

// import '../../global_controller.dart';

// class BaseMap extends StatefulWidget {
//   @override
//   State<BaseMap> createState() => BaseMapState();
// }

// class BaseMapState extends State<BaseMap> {
//   final gstate = Get.find<GlobalController>();
//   bool _serviceEnabled = false;
//   geoLoc.LocationPermission? _permissionGranted;
//   GoogleMapController? mapController;
//   final markers = Set<Marker>();
//   MarkerId markerId = MarkerId("YOUR-MARKER-ID");

//   Set<Circle> _circles = HashSet<Circle>();

//   @override
//   void initState() {
//     super.initState();
//     cekPermision();
//   }

//   void _setCircles(LatLng point, double radius) {
//     final String circleIdVal = 'circle_id';

//     print(
//         'Circle | Latitude: ${point.latitude}  Longitude: ${point.longitude}  Radius: $radius');
//     _circles.add(Circle(
//       circleId: CircleId(circleIdVal),
//       center: point,
//       radius: radius,
//       strokeWidth: 0,
//       strokeColor: Color(primaryDark),
//       fillColor: Color(primaryDark).withOpacity(0.2),
//     ));
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   cekPermision() async {
//     _serviceEnabled = await geoLoc.Geolocator.isLocationServiceEnabled();
//     if (!_serviceEnabled) {
//       await geoLoc.Geolocator.openLocationSettings();
//       return Future.error('Location services are disabled.');
//     }

//     _permissionGranted = await geoLoc.Geolocator.checkPermission();
//     log(_permissionGranted.toString());
//     if (_permissionGranted == geoLoc.LocationPermission.denied) {
//       _permissionGranted = await geoLoc.Geolocator.requestPermission();
//     } else if (_permissionGranted == geoLoc.LocationPermission.deniedForever) {
//       Alertx().error('Harap beri akses lokasi dari pengaturan aplikasi');
//     } else if (_permissionGranted == geoLoc.LocationPermission.always) {}
//     geoLoc.Position currentLocation =
//         await geoLoc.Geolocator.getCurrentPosition(
//             desiredAccuracy: geoLoc.LocationAccuracy.high);

//     if (currentLocation.latitude != null) {
//       getAddressFromLatLong(currentLocation);
//     }

//     mapController?.animateCamera(
//       CameraUpdate.newLatLngZoom(
//         LatLng(currentLocation.latitude, currentLocation.longitude),
//         20.0,
//       ),
//     );
//     // setState(() {
//     markers.add(Marker(
//         markerId: markerId,
//         position: LatLng(currentLocation.latitude, currentLocation.longitude)));

//     _setCircles(
//         LatLng(
//           currentLocation.latitude,
//           currentLocation.longitude,
//         ),
//         currentLocation.accuracy);
//   }

//   Future<void> getAddressFromLatLong(geoLoc.Position position) async {
//     List<Placemark> placemarks =
//         await placemarkFromCoordinates(position.latitude, position.longitude);
//     print(placemarks);
//     Placemark place = placemarks[0];
//     var address =
//         '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
//     setState(() {
//       gstate.latitude = position.latitude;
//       gstate.longitude = position.longitude;
//       // locationState.addres.value = address;
//     });
//     // widget.presensiState.setLatitude(position.latitude);
//     // widget.presensiState.setLongitude(position.longitude);
//     // widget.presensiState.setAddress(address);
//   }

//   Completer<GoogleMapController> _controller = Completer();

//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(-6.1703188953825405, 106.8281301150148),
//     zoom: 14.4746,
//   );

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 300,
//       child: Stack(
//         children: [
//           GoogleMap(
//             onMapCreated: _onMapCreated,
//             mapType: MapType.normal,
//             markers: markers,
//             initialCameraPosition: _kGooglePlex,
//             circles: _circles,
//           ),
//           Align(
//             alignment: Alignment.bottomLeft,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: IconButton(
//                 onPressed: () {
//                   cekPermision();
//                 },
//                 icon: Icon(
//                   Icons.my_location,
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }