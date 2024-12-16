import 'package:ds_service/AppsColor/appColor.dart';
import 'package:ds_service/Resources/app_images.dart';
import 'package:flutter/material.dart';

class JobHistoryPage extends StatefulWidget {
  const JobHistoryPage({super.key});

  @override
  JobHistoryPageState createState() => JobHistoryPageState();
}

class JobHistoryPageState extends State<JobHistoryPage> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Full list of items
    final items = List.generate(10, (index) => "Item $index");

    // Displayed items based on the expanded state
    final displayedItems = _isExpanded ? items : items.take(2).toList();

    return Scaffold(
      body: Stack(
        children: [
          // Background images
          Positioned(
            left: 0,
            top: -screenHeight * 0.05,
            child: Image.asset(
              AppImages.loginEllipse,
              width: screenWidth * 0.55,
              height: screenHeight * 0.34,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(AppImages.ellipseRight),
          ),

          // Back button with title
          Positioned(
            left: screenWidth*0.06,
            top: screenHeight * 0.05,
            child: Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                 SizedBox(width: screenWidth*0.02),
                const Text(
                  "Job History",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          // Job list with "View More"/"View Less" button
          Positioned(
            top: screenHeight * 0.25,
            bottom: 0,
            right: 0,
            left: 0,
            child: ListView.builder(
              padding:  EdgeInsets.symmetric(vertical: screenHeight*0.01,horizontal: screenWidth*0.1),
              itemCount: displayedItems.length + 1, // Extra for the button
              itemBuilder: (context, index) {
                if (index == displayedItems.length) {
                  // "View More"/"View Less" Button
                  return Center(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      child: Text(
                        _isExpanded ? "View Less" : "View All",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  );
                }

                // Job item
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffEFEDF0),
                    borderRadius: BorderRadius.vertical(
                      top: index == 0 ? const Radius.circular(12) : Radius.zero,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Timestamp
                       Padding(
                        padding: EdgeInsets.only(
                          top: screenHeight*0.007,
                          right: screenWidth*0.02,
                        ),
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "11:00 AM 21 Aug",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      // Content
                      Padding(
                        padding:  EdgeInsets.only(bottom: screenHeight*0.015),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left indicator
                            Container(
                              height: screenHeight*0.075,
                              width: screenWidth*0.028,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(8),
                                ),
                              ),
                            ),
                             SizedBox(width: screenWidth*0.04),

                            // User details
                             Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title
                                  const Text(
                                    "Verified User",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight*0.005),

                                  // Job value
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.account_balance_wallet_rounded,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: screenWidth*0.02),
                                      const Text(
                                        "Job value",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: screenHeight*0.005),

                                  // Payment method
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.computer_outlined,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: screenWidth*0.02),
                                      const Text(
                                        "Online payment",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
