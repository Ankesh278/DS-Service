import 'package:ds_service/Auth/tell_us_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HubController extends GetxController {
  TextEditingController nameController = TextEditingController();
  var location = "Fetching location...".obs;
  TextEditingController searchController = TextEditingController(); // Search field
  var isUsingCurrentLocation = true.obs;
  var currentPosition = const LatLng(0, 0).obs;
  RxString selectedProfession = "".obs;
  RxString selectedCity = "".obs;
  GoogleMapController? mapController;
  var hubs = [].obs;
  var markers = <Marker>{}.obs;
  var selectedHubId = ''.obs;
  RxSet<Circle> circles = <Circle>{}.obs;
  RxSet<Polygon> polygons = <Polygon>{}.obs; // Add this line


  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
    listenToLocationChanges();
  }

  void toggleLocationMode(bool useCurrent) {
    isUsingCurrentLocation.value = useCurrent;
    if (useCurrent) {
      getCurrentLocation().then((_) {
        fetchNearbyHubs(); // ✅ Hub tab fetch hoga jab user current location select kare
      });
    } else {
      searchController.clear();
      hubs.clear(); // ❌ Manually search nahi kiya toh hubs clear rakhna hai
      markers.removeWhere((marker) => marker.markerId.value != "user_location");
    }
  }

  void searchLocation(String query) async {
    try {
      final response = await http.get(Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json?address=$query&key=AIzaSyByV5YZ6mrv2lsmsqy1Iw8tDzZTZDjGo1I'));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['results'].isNotEmpty) {
          var locationData = data['results'][0]['geometry']['location'];
          LatLng searchedLocation = LatLng(
            locationData['lat'],
            locationData['lng'],
          );

          currentPosition.value = searchedLocation;
          mapController?.animateCamera(CameraUpdate.newLatLng(searchedLocation));

          markers.add(
            Marker(
              markerId: const MarkerId("searched_location"),
              position: searchedLocation,
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
              infoWindow: const InfoWindow(title: "Selected Location"),
            ),
          );

          fetchNearbyHubs(); // ✅ Sirf successful search hone par hub fetch kare
        }
      }
    } catch (e) {
      print("Error searching location: $e");
    }
  }


  void checkUserInsideCircle(LatLng hubLocation) {
    double distance = Geolocator.distanceBetween(
      currentPosition.value.latitude,
      currentPosition.value.longitude,
      hubLocation.latitude,
      hubLocation.longitude,
    );

    if (distance <= 50000) {
      print("✅ User is inside the 50 km hub area.");
    } else {
      print("❌ User is outside the 50 km hub area.");
    }
  }


  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      location.value = "Location services are disabled.";
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        location.value = "Location permissions are denied.";
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      location.value = "Location permissions are permanently denied.";
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    updateLocation(position);
  }

  void listenToLocationChanges() {
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // Update when user moves 10 meters
      ),
    ).listen((Position position) {
      updateLocation(position);
    });
  }

  void updateLocation(Position position) {
    location.value = "Lat: \${position.latitude}, Lng: \${position.longitude}";
    currentPosition.value = LatLng(position.latitude, position.longitude);
    mapController?.animateCamera(CameraUpdate.newLatLng(currentPosition.value));

    markers.removeWhere((marker) => marker.markerId.value == "user_location");
    markers.add(
      Marker(
        markerId: const MarkerId("user_location"),
        position: currentPosition.value,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(title: "Your Location"),
      ),
    );

  }

  void sendLocationData({String? fullName, String? profession, String? city}) {
    var userLocation = {
      "location": {
        "type": "Point",
        "coordinates": [currentPosition.value.longitude, currentPosition.value.latitude]
      },
      "hubId": selectedHubId.value,
      if (fullName != null) "fullName": nameController.text,
      if (profession != null) "profession": selectedProfession,
      if (city != null) "hometown": selectedCity,
    };
    print("Sending location data: $userLocation");
  }
  Future<void> fetchNearbyHubs() async {
    try {
      final response = await http.post(
        Uri.parse('http://15.207.112.43:8080/api/service/vendorhub'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "longitude": currentPosition.value.longitude,
          "latitude": currentPosition.value.latitude,
        }),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data['success'] == true && data['hub'] != null) {
          var hub = data['hub'];
          hubs.value = [hub];

          LatLng hubLocation = LatLng(
            hub['location']['coordinates'][1],
            hub['location']['coordinates'][0],
          );

          markers.removeWhere((marker) => marker.markerId.value != "user_location");

          markers.add(
            Marker(
              markerId: MarkerId(hub['_id']),
              position: hubLocation,
              infoWindow: InfoWindow(
                title: hub['hubname'],
                snippet: "Tap to select",
                onTap: () {
                  selectedHubId.value = hub['_id'];
                },
              ),
            ),
          );

          polygons.clear();

          List<LatLng> boundaryPoints = [];
          for (var point in hub['boundary']) {
            boundaryPoints.add(LatLng(point[0], point[1]));
          }

          polygons.add(
            Polygon(
              polygonId: PolygonId("hub_boundary"),
              points: boundaryPoints,
              strokeWidth: 3,
              strokeColor: Colors.red,
              fillColor: Colors.red.withOpacity(0.2),
              geodesic: true,
            ),
          );
          bool isPointInPolygon(LatLng point, List<LatLng> polygon) {
            int intersectCount = 0;
            for (int j = 0; j < polygon.length - 1; j++) {
              LatLng vertex1 = polygon[j];
              LatLng vertex2 = polygon[j + 1];

              if ((vertex1.longitude > point.longitude) != (vertex2.longitude > point.longitude) &&
                  (point.latitude < (vertex2.latitude - vertex1.latitude) *
                      (point.longitude - vertex1.longitude) /
                      (vertex2.longitude - vertex1.longitude) +
                      vertex1.latitude)) {
                intersectCount++;
              }
            }
            return (intersectCount % 2) == 1;
          }


          // ✅ Check if user is inside the polygon
          if (isPointInPolygon(currentPosition.value, boundaryPoints)) {
            Future.delayed(Duration(milliseconds: 500), () {
              Get.snackbar(
                "Inside Hub Area",
                "You are inside the designated hub area.",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            });
          }

          selectedHubId.value = hub['_id'];

          update();
        } else {
          Get.snackbar(
            "No Hubs Found",
            "There are no hubs nearby.",
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        Get.snackbar(
          "No Hubs Found",
          "There are no hubs nearby.",
          snackPosition: SnackPosition.BOTTOM,
        );
        print("Failed to fetch hub: ${response.body}");
      }
    } catch (e) {
      print("Error fetching hub: $e");
    }
  }




}

class HubScreen extends StatelessWidget {
  final HubController controller = Get.put(HubController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hub Screen")),
      body: Column(
        children: [
          // Toggle Buttons for Location Selection
          Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChoiceChip(
                label: const Text("Use Current Location"),
                selected: controller.isUsingCurrentLocation.value,
                onSelected: (value) => controller.toggleLocationMode(true),
              ),
              const SizedBox(width: 10),
              ChoiceChip(
                label: const Text("Search Location"),
                selected: !controller.isUsingCurrentLocation.value,
                onSelected: (value) => controller.toggleLocationMode(false),
              ),
            ],
          )),
          const SizedBox(height: 10),

          // Search Bar (only visible if searching manually)
          Obx(() => controller.isUsingCurrentLocation.value
              ? Container()
              : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: "Search location...",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    controller.searchLocation(controller.searchController.text);
                  },
                ),
              ),
            ),
          )),

          // Google Map
          Expanded(
            child: Obx(() => GoogleMap(
              initialCameraPosition: CameraPosition(
                target: controller.currentPosition.value,
                zoom: 14,
              ),
              onMapCreated: (GoogleMapController mapCtrl) {
                controller.mapController = mapCtrl;
              },
              markers: controller.markers.toSet(),
              polygons: controller.polygons.value,
            )),
          ),

          // **Add the Missing Hub List**
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Choose a hub from below:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: controller.hubs.length,
              itemBuilder: (context, index) {
                var hub = controller.hubs[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  elevation: 4,
                  child: ListTile(
                    title: Text("Hub ${index + 1}: ${hub['hubname']}",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("Location: ${hub['location']['coordinates']}"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      controller.selectedHubId.value = hub['_id'];
                      _showConfirmationDialog(context);
                    },
                  ),
                );
              },
            )),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Selection"),
        content: const Text("Do you want to proceed with the selected hub?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              controller.sendLocationData();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TellUsScreen()),
              );
            },
            child: const Text("Done"),
          ),
        ],
      ),
    );
  }
}


