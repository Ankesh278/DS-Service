import 'package:get/get.dart';

class BookingService extends GetConnect {
  Future<List<Map<String, dynamic>>> fetchBookings(String vendorId) async {
    final url =
        'http://15.207.112.43:8080/api/service/booking/$vendorId';

    try {
      final response = await get(url);

      if (response.status.hasError) {
        return Future.error("Failed to fetch bookings");
      }

      List<dynamic> bookings = response.body;
      return bookings.cast<Map<String, dynamic>>();
    } catch (e) {
      return Future.error("Error: $e");
    }
  }
}
