import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/main_screen.dart';


class VendorStatusScreen extends StatefulWidget {
  @override
  _VendorStatusScreenState createState() => _VendorStatusScreenState();
}

class _VendorStatusScreenState extends State<VendorStatusScreen> {
  String vendorId = "";
  String status = "PENDING";
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadVendorId();
  }

  Future<void> _loadVendorId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    vendorId = prefs.getString('vendor_id') ?? "";
    if (vendorId.isNotEmpty) {
      _fetchVendorStatus();
      _timer = Timer.periodic(Duration(seconds: 10), (timer) => _fetchVendorStatus());
    }
  }

  Future<void> _fetchVendorStatus() async {
    final response = await http.get(Uri.parse('http://15.207.112.43:8080/api/vendor/getvendorbyid/$vendorId'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        status = data['status'];
      });
      if (status == "APPROVED") {
        _timer?.cancel();
        Get.offAll(MainScreen());
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Vendor Status")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Vendor ID: $vendorId"),
            SizedBox(height: 10),
            Text("Status: $status", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            if (status == "PENDING") CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
