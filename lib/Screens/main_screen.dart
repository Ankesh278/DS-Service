import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:ds_service/AppsColor/app_color.dart';
import 'package:ds_service/Resources/app_images.dart';
import 'package:ds_service/Screens/account_centre.dart';
import 'package:ds_service/Screens/booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DateTime now = DateTime.now();
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  final TextEditingController _msgController = TextEditingController();
  String formattedDate = '';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }
  @override
  void initState() {
    super.initState();
    // Get the current time and format it
    formattedDate = DateFormat('hh:mm a dd MMM').format(DateTime.now());
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: AppColors.primaryColor,
          ),
          Container(
            margin: EdgeInsets.only(bottom: screenHeight * 0.118),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(screenWidth * 0.15),
                    bottomRight: Radius.circular(screenWidth * 0.15))),
          ),
          Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  children: [
                    _buildHomePage(screenWidth, screenHeight),
                    _jobsPage(screenWidth, screenHeight),
                    _jonsUpcomingPage(screenWidth, screenHeight),
                    _androidPage(screenWidth, screenHeight),
                    _buildAccountPage(screenWidth, screenHeight),
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    color: AppColors.primaryColor,
                    height: screenHeight * 0.115,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.07),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: IconButton(
                              icon: const Icon(Icons.home_filled),
                              color: _selectedIndex == 0
                                  ? Colors.white
                                  : Colors.grey[300],
                              onPressed: () => _onItemTapped(0),
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              icon: const Icon(Icons.calendar_today_sharp),
                              color: _selectedIndex == 1
                                  ? Colors.white
                                  : Colors.grey[300],
                              onPressed: () => _onItemTapped(1),
                            ),
                          ),
                          Expanded(
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.center,
                              children: [
                                Positioned(
                                  bottom: screenHeight * 0.015,
                                  child: Container(
                                    width: screenWidth * 0.3,
                                    height: screenHeight * 0.07,
                                    decoration: BoxDecoration(
                                      color: _selectedIndex == 2
                                          ? Colors.white
                                          : Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.timer_outlined,
                                        color: _selectedIndex == 2
                                            ? AppColors.primaryColor
                                            : AppColors.primaryColor,
                                        size: 24,
                                      ),
                                      onPressed: () => _onItemTapped(2),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              icon: const Icon(Icons.data_saver_on_outlined),
                              color: _selectedIndex == 3
                                  ? Colors.white
                                  : Colors.grey[300],
                              onPressed: () => _onItemTapped(3),
                            ),
                          ),
                          Expanded(
                            child: IconButton(
                              icon: ImageIcon(
                                _selectedIndex == 4
                                    ? const AssetImage(AppImages.pouch)
                                    : const AssetImage(AppImages.pouch),
                                color: _selectedIndex == 4
                                    ? Colors.white
                                    : Colors.grey[300],
                              ),
                              onPressed: () => _onItemTapped(4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: screenHeight * 0.045),
                      height: screenHeight * 0.04,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1, // Border width
                          ),
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.07)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.005,
                            horizontal: screenHeight * 0.01),
                        child: const Text("Complete all task to end job"),
                      ),
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _jonsUpcomingPage(double screenWidth, double screenHeight) {
    return const Text("Interested");
  }

  Widget _buildHomePage(double screenWidth, double screenHeight) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: screenHeight * 0.237,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages.rectangleVerify),
                        fit: BoxFit
                            .cover, // Ensures the image covers the container
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.04,
                  right: screenWidth * 0.05,
                  child: Row(
                    children: [
                      const Icon(Icons.notifications_none, color: Colors.white),
                      const SizedBox(width: 5),
                      IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white),
                        onPressed: () {
                          // Navigate to the Account Center page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AccountCentre()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                // TabBar positioned below the background image
                Positioned(
                  top: screenHeight * 0.15,
                  left: screenWidth * 0.08,
                  right: screenWidth * 0.08,
                  child: Container(
                    height: screenHeight * 0.04,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white, width: 1.5), // Outer border
                      borderRadius: BorderRadius.circular(0), // Rounded corners
                    ),
                    child: SegmentedTabControl(
                      barDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(color: Colors.white)),
                      indicatorDecoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0),
                      ),
                      tabTextColor:
                          Colors.white, // Text color for inactive tabs
                      selectedTabTextColor: AppColors.primaryColor,
                      textStyle: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.w800),
                      tabs: const [
                        SegmentTab(label: 'Upcoming'),
                        SegmentTab(label: 'Pending'),
                        SegmentTab(label: 'Completed'),
                        SegmentTab(label: 'Cancelled'),
                      ],
                    ),
                  ),
                ),
                BookingScreen()
                // Positioned.fill(
                //   top: screenHeight * 0.23, //177
                //   child: TabBarView(
                //     children: [
                //       SingleChildScrollView(
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Container(
                //               margin: EdgeInsets.only(
                //                   left: screenWidth * 0.06,
                //                   top: screenHeight * 0.02),
                //               width: screenWidth * 0.22,
                //               height: screenHeight * 0.034,
                //               decoration: BoxDecoration(
                //                 color: AppColors.primaryColor,
                //                 borderRadius: BorderRadius.circular(20),
                //                 border: Border.all(color: Colors.black),
                //               ),
                //               child: const Center(
                //                 child: Padding(
                //                   padding: EdgeInsets.all(0.0),
                //                   child: Text(
                //                     "Today",
                //                     style: TextStyle(color: Colors.white),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //             const SizedBox(height: 10),
                //             // ListView Section
                //             ListView.builder(
                //               shrinkWrap: true,
                //               physics: const NeverScrollableScrollPhysics(),
                //               padding: EdgeInsets.symmetric(
                //                   horizontal: screenHeight * 0.025,
                //                   vertical: screenHeight * 0.01),
                //               itemCount: 10,
                //               itemBuilder: (context, index) {
                //                 return Container(
                //                   margin: EdgeInsets.only(
                //                       bottom: screenHeight * 0.035),
                //                   padding: const EdgeInsets.all(12),
                //                   decoration: BoxDecoration(
                //                     color: AppColors.primaryColor,
                //                     borderRadius: BorderRadius.circular(8),
                //                     boxShadow: [
                //                       BoxShadow(
                //                         color: Colors.grey.withValues(alpha: 0.6),
                //                         blurRadius: 6,
                //                         offset: const Offset(0, 3),
                //                       ),
                //                     ],
                //                   ),
                //                   child: Expanded(
                //                     child: Column(
                //                       mainAxisSize: MainAxisSize.min,
                //                       crossAxisAlignment:
                //                           CrossAxisAlignment.start,
                //                       children: [
                //                         const Row(
                //                           crossAxisAlignment:
                //                               CrossAxisAlignment.start,
                //                           children: [
                //                             Text(
                //                               "8:30pm",
                //                               style: TextStyle(
                //                                   color: Colors.white,
                //                                   fontWeight: FontWeight.w500),
                //                             ),
                //                             Spacer(),
                //                             ImageIcon(
                //                                 color: Colors.white,
                //                                 AssetImage(
                //                                     AppImages.navigation))
                //                           ],
                //                         ),
                //                         const Text(
                //                           "Test Kunal Dadar West Dad...",
                //                           style: TextStyle(
                //                               color: Colors.white,
                //                               fontSize: 10),
                //                         ),
                //                         const Text(
                //                           "Job not closed",
                //                           style: TextStyle(
                //                               color: Colors.white,
                //                               fontSize: 13,
                //                               fontWeight: FontWeight.w600),
                //                         ),
                //                         const SizedBox(
                //                           height: 5,
                //                         ),
                //                         Row(
                //                           children: [
                //                             const ImageIcon(
                //                                 color: Colors.white,
                //                                 AssetImage(
                //                                   AppImages.telephone,
                //                                 )),
                //                             const SizedBox(
                //                               width: 20,
                //                             ),
                //                             Container(
                //                               height: 30,
                //                               width: 212,
                //                               decoration: BoxDecoration(
                //                                 color: Colors.white,
                //                                 borderRadius:
                //                                     BorderRadius.circular(8),
                //                               ),
                //                               child: TextField(
                //                                 controller: _msgController,
                //                                 style: const TextStyle(
                //                                   color: Colors.black,
                //                                   fontSize: 12,
                //                                 ),
                //                                 decoration:
                //                                     const InputDecoration(
                //                                   hintText: "Type your message",
                //                                   hintStyle: TextStyle(
                //                                     fontSize: 10,
                //                                     color: Colors.grey,
                //                                   ),
                //                                   border: InputBorder.none,
                //                                   contentPadding:
                //                                       EdgeInsets.symmetric(
                //                                           vertical: 13,
                //                                           horizontal:
                //                                               10), // Centers the text vertically
                //                                 ),
                //                               ),
                //                             ),
                //                             const SizedBox(
                //                               width: 5,
                //                             ),
                //                             InkWell(
                //                                 onTap: () {
                //                                   _msgController.clear();
                //                                   FocusScope.of(context)
                //                                       .unfocus();
                //                                 },
                //                                 child: const Icon(
                //                                   Icons.send,
                //                                   color: Colors.white,
                //                                   size: 30,
                //                                 ))
                //                           ],
                //                         )
                //                       ],
                //                     ),
                //                   ),
                //                 );
                //               },
                //             ),
                //           ],
                //         ),
                //       ),
                //       const Center(child: Text("Content for Tab 2")),
                //       const Center(child: Text("Content for Tab 3")),
                //       const Center(child: Text("Content for Tab 4")),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountPage(double screenWidth, double screenHeight) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: screenHeight * 0.237,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages.rectangleVerify),
                        fit: BoxFit
                            .cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.04,
                  right: screenWidth * 0.05,
                  child: Row(
                    children: [
                      const Icon(Icons.notifications_none, color: Colors.white),
                      const SizedBox(width: 5),
                      IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AccountCentre()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.15,
                  left: screenWidth * 0.08,
                  right: screenWidth * 0.08,
                  child: Container(
                    height: screenHeight * 0.04,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1.5),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: SegmentedTabControl(
                      barDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(color: Colors.white)),
                      indicatorDecoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0),
                      ),
                      tabTextColor: Colors.white,
                      selectedTabTextColor: AppColors.primaryColor,
                      textStyle: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.w800),
                      tabs: const [
                        SegmentTab(label: 'All'),
                        SegmentTab(label: 'Today'),
                        SegmentTab(label: 'Tomorrow'),
                        SegmentTab(label: 'Week'),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  top: screenHeight * 0.23,
                  child: TabBarView(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             SizedBox(height: screenHeight*0.005),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenHeight * 0.025,
                                  vertical: screenHeight * 0.01),
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      bottom: screenHeight * 0.035),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withValues(alpha: 0.6),
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: AppColors.primaryColor,
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(8),
                                            bottomLeft: Radius.circular(8),
                                          ),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Icon(Icons.refresh_outlined,
                                                  color: Colors.white),
                                              Text(
                                                "Revisit request",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: screenHeight * 0.01),
                                       Padding(
                                        padding: const EdgeInsets.only(right: 5.0),
                                        child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              formattedDate,
                                              style: const TextStyle(
                                                  color:
                                                      AppColors.primaryColor),
                                            )),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: screenWidth * 0.022,
                                            height: screenHeight * 0.11,
                                            decoration: const BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(8),
                                                  bottomRight:
                                                      Radius.circular(8)),
                                            ),
                                          ),
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(left: 15.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Complaint : Swarthy dey",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 16),
                                                ),
                                                Text(
                                                  "Club Town Garden Phase 1",
                                                  style: TextStyle(
                                                      color: Colors.black38,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                                Text(
                                                  "Block-5, Club towns Gardens,",
                                                  style: TextStyle(
                                                      color: Colors.black38,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                                Text(
                                                  "Kolkata, West Bengal 700076,India ",
                                                  style: TextStyle(
                                                      color: Colors.black38,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(width: screenWidth * 0.1),
                                          const ImageIcon(
                                              AssetImage(AppImages.telephone),
                                              color: Colors.black),
                                          SizedBox(width: screenWidth * 0.06),
                                          const Icon(Icons.telegram_sharp,
                                              color: Colors.black),
                                        ],
                                      ),
                                      SizedBox(height: screenHeight * 0.01),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const Center(child: Text("Tab 2")),
                      const Center(child: Text("Tab 3")),
                      const Center(child: Text("Tab 4")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _jobsPage(double screenWidth, double screenHeight) {
    return const Text("Jobs");
  }

  Widget _androidPage(double screenWidth, double screenHeight) {
    return const Text("Android");
  }
}
