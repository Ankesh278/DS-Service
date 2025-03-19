import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../AppsColor/app_color.dart';
import '../controllers.dart';
import 'package:geocoding/geocoding.dart';

class BookingScreen extends StatelessWidget {
  final BookingController bookingController = Get.put(BookingController());

  Future<String> getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        return "${placemarks[0].locality}, ${placemarks[0].country}";
      }
    } catch (e) {
      return "Unknown Location";
    }
    return "Unknown Location";
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Positioned.fill(
      top: screenHeight * 0.23,
      child: TabBarView(
        children: [
          Obx(() {
            if (bookingController.bookings.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: screenWidth * 0.06, top: screenHeight * 0.02),
                    width: screenWidth * 0.22,
                    height: screenHeight * 0.034,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black),
                    ),
                    child: const Center(
                      child: Text(
                        "Today",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                        horizontal: screenHeight * 0.025,
                        vertical: screenHeight * 0.01),
                    itemCount: bookingController.bookings.length,
                    itemBuilder: (context, index) {
                      var booking = bookingController.bookings[index];
                      var coordinates = booking['userLocation']['coordinates'];
                      double lat = coordinates[1];
                      double lng = coordinates[0];

                      return FutureBuilder<String>(
                        future: getAddressFromLatLng(lat, lng),
                        builder: (context, snapshot) {
                          String address =
                          snapshot.hasData ? snapshot.data! : "Fetching...";

                          return Container(
                            margin:
                            EdgeInsets.only(bottom: screenHeight * 0.035),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.6),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      booking['timeSlot'],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        address,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Icon(Icons.navigation,
                                        color: Colors.white),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // Future Action for Accept
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(8)),
                                      ),
                                      child: const Text("Accept",
                                          style:
                                          TextStyle(color: Colors.white)),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Future Action for Reject
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(8)),
                                      ),
                                      child: const Text("Reject",
                                          style:
                                          TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          }),
          const Center(child: Text("Content for Tab 2")),
          const Center(child: Text("Content for Tab 3")),
          const Center(child: Text("Content for Tab 4")),
        ],
      ),
    );
  }
}
