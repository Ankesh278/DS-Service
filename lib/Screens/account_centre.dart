import 'dart:io';
import 'package:ds_service/Resources/app_images.dart';
import 'package:ds_service/Screens/calender_screen.dart';
import 'package:ds_service/Screens/job_history_page.dart';
import 'package:ds_service/Screens/main_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AccountCentre extends StatefulWidget {
  const AccountCentre({super.key});

  @override
  State<AccountCentre> createState() => _AccountCentreState();
}

class _AccountCentreState extends State<AccountCentre> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  // Helper function for image picking
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      // Handle any errors during image picking (e.g., permissions issues)
      if (kDebugMode) {
        print('Error picking image: $e');
      }
    }
  }

  // Function to show bottom sheet with image picker options
  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Pick from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Capture from Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              AppImages.rectangleVerify,
              fit: BoxFit.cover,
              height: screenHeight * 0.23,
            ),
          ),
          // Back button
          Positioned(
            top: screenHeight * 0.05,
            left: screenWidth * 0.0,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          // Profile section
          Positioned(
            top: screenHeight * 0.1,
            left: screenWidth * 0.1,
            child: Column(
              children: [
                const Text("My profile", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)),
                SizedBox(height: screenHeight * 0.06),
                _buildProfileSection(screenHeight, screenWidth),
                SizedBox(height: screenHeight * 0.04),
                _buildMenuSection(screenHeight, screenWidth),
                const SizedBox(height: 15),
                _buildInsuranceSection(screenHeight, screenWidth),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Profile Section with Image Picker
  Widget _buildProfileSection(double screenHeight, double screenWidth) {
    return Center(
      child: Container(
        width: screenWidth * 0.72,
        height: screenHeight * 0.095,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.30),
              offset: const Offset(4, 4),
              blurRadius: 12,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: _showImagePickerOptions,
              child: Container(
                padding: EdgeInsets.all(screenHeight * 0.035),
                margin: EdgeInsets.only(left: screenWidth * 0.02),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: 2.0),
                  image: _selectedImage != null
                      ? DecorationImage(image: FileImage(_selectedImage!), fit: BoxFit.cover)
                      : const DecorationImage(image: AssetImage(AppImages.profile), fit: BoxFit.cover),
                ),
              ),
            ),
            const Text("Ankesh Yadav", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600)),
            const Spacer(),
            CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              radius: 15,
              child: const Icon(Icons.edit, size: 18),
            ),
          ],
        ),
      ),
    );
  }

  // Menu section with navigation
  Widget _buildMenuSection(double screenHeight, double screenWidth) {
    return Container(
      width: screenWidth * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.30),
            offset: const Offset(4, 4),
            blurRadius: 12,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.margin_outlined,
            title: "Calendar",
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CalendarScreen())),
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.manage_accounts,
            title: "Job history",
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const JobHistoryPage())),
          ),
          _buildDivider(),
          _buildMenuItem(
            icon: Icons.ac_unit_sharp,
            title: "My hub",
            onTap: () {},
          ),
          _buildDivider(),
          _buildMenuItem(icon: Icons.eight_k_outlined, title: "Credits", onTap: () {}),
        ],
      ),
    );
  }

  // Insurance section
  Widget _buildInsuranceSection(double screenHeight, double screenWidth) {
    return Container(
      width: screenWidth * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.30),
            offset: const Offset(4, 4),
            blurRadius: 12,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildMenuItem(icon: Icons.safety_check_outlined, title: "Insurance", onTap: () {}),
          _buildDivider(),
          _buildMenuItem(icon: Icons.elderly_outlined, title: "Training", onTap: () {}),
          _buildDivider(),
          _buildMenuItem(icon: Icons.verified_user_outlined, title: "Safety Centre", onTap: () {}),
          _buildDivider(),
          _buildMenuItem(icon: Icons.help_outline_outlined, title: "Help Centre", onTap: () {}),
          _buildDivider(),
          _buildMenuItem(icon: Icons.girl_rounded, title: "Add Helps", onTap: () {}),
        ],
      ),
    );
  }

  // Common widget for menu items
  Widget _buildMenuItem({required IconData icon, required String title, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 17),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: Colors.black),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_outlined, color: Colors.black),
          ],
        ),
      ),
    );
  }

  // Divider for menu items
  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      width: double.infinity,
      height: 1,
      color: Colors.grey,
    );
  }
}
