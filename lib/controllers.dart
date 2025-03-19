import 'package:ds_service/services/booking_service.dart';
import 'package:get/get.dart';


class BookingController extends GetxController {
  var bookings = <Map<String, dynamic>>[].obs;
  final String vendorId = "67bc12837069384b8663c671";

  @override
  void onInit() {
    fetchBookings();
    super.onInit();
  }

  void fetchBookings() async {
    try {
      var result = await BookingService().fetchBookings(vendorId);
      bookings.assignAll(result);
    } catch (e) {
      print("Error fetching bookings: $e");
    }
  }
}
