import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:ds_service/AppsColor/app_color.dart';
import 'package:ds_service/Myscreens/quote.dart';
import 'package:ds_service/Resources/app_images.dart';
import 'package:ds_service/Screens/account_centre.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});
  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
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
                          borderRadius: BorderRadius.circular(screenWidth * 0.07)),
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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Positioned(
                left: -75.w,
                top: -50.h,
                child: Image.asset(AppImages.loginEllipse),
              ),
              Positioned(
                top: -30.h,
                right: 0.w,
                child: Image.asset(AppImages.ellipseRight),
              ),

              // Back Button
              Positioned(
                left: 10.w,
                top: 30.h,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
              Positioned(top: screenHeight*0.15,
                child: Container(
                    margin: EdgeInsets.only(
                        left: screenWidth * 0.06,
                        top: screenHeight * 0.02),
                    width: screenWidth * 0.88,
                    height: screenHeight * 0.040,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black),
                    ),
                    child:Row(
                      children: [
                        const SizedBox(width: 20,),
                        const Text('Today, 11:00 AM',style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.bold),),
                        const Spacer(),
                        Container(height: screenHeight * 0.040,width: screenWidth*0.1,
                          decoration: const BoxDecoration(color: AppColors.primaryColor,
                            borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),),
                          child: const Icon(Icons.keyboard_arrow_down_outlined,color: Colors.white,size: 20,),)
                      ],
                    )
                ),
              ),
              Positioned(top: screenHeight*0.21,
                child: Container(
                    margin: EdgeInsets.only(
                        left: screenWidth * 0.06,
                        top: screenHeight * 0.02),
                    width: screenWidth * 0.88,
                    height: screenHeight * 0.040,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black),
                    ),
                    child:Row(
                      children: [
                        const SizedBox(width: 20,),
                        const Text('Job detail',style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.bold),),
                        const Spacer(),
                        Container(height: screenHeight * 0.040,width: screenWidth*0.1,
                          decoration: const BoxDecoration(color: AppColors.primaryColor,
                            borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),),
                          child: const Icon(Icons.keyboard_arrow_down_outlined,color: Colors.white,size: 20,),)
                      ],
                    )
                ),
              ),
              Positioned(top: 258.h,left: 34.w,
                  child: Text('Tasks',style: TextStyle(fontSize: 20.sp,color: AppColors.primaryColor,fontWeight: FontWeight.bold),)),
              Positioned(top: 304.h,left: 65.w,
                child: Column(
                  children: [
                    Container(
                      width: 273.w,height: 80.h,color: const Color(0xffF7F7F7),
                      child: Row(
                      children: [
                        Container(
                          width: 66.w,
                          height:71.h,
                          color: Colors.black,
                          child: Center(child: Text('Step\n   1',style: TextStyle(color: Colors.white,fontSize: 16.sp),),),
                        ),
                        Column(
                          children: [
                            const Text('Create & share quote'),
                            SizedBox(height: 5.h,),
                           Padding(
                             padding: const EdgeInsets.only(left: 100.0,top: 20),
                             child: GestureDetector(
                               onTap: (){
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>const Quote()));
                               },
                               child: Container(width: 50.w,height: 18.h,decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(50)),
                                 child: Center(child: Text('Create',style: TextStyle(fontSize: 12.sp,color: Colors.white),)),),
                             ),
                           )
                          ],
                        )
                      ],
                    ),

                    ),
                  ],
                ),
              ),
              Positioned(top: 406.h,left: 65.w,
                child: Column(
                  children: [
                    Container(
                      width: 273.w,height: 80.h,color: const Color(0xffF7F7F7),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text('Upload repair proofs'),
                              ),
                              SizedBox(height: 5.h,),
                              Padding(
                                padding: const EdgeInsets.only(left: 50.0,top: 20),
                                child: Container(width: 80.w,height: 18.h,decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(50)),
                                  child: Center(child: Text('Add Proof',style: TextStyle(fontSize: 12.sp,color: Colors.white),)),),
                              )
                            ],
                          ),const Spacer(),
                          Container(
                            width: 66.w,
                            height:71.h,
                            color: Colors.black,
                            child: Center(child: Text('Step\n   2',style: TextStyle(color: Colors.white,fontSize: 16.sp),),),
                          ),
                        ],
                      ),

                    ),
                  ],
                ),
              ),
              Positioned(top: 501.h,left: 65.w,
                child: Column(
                  children: [
                    Container(
                      width: 273.w,height: 80.h,color: const Color(0xffF7F7F7),
                      child: Row(
                        children: [
                          Container(
                            width: 66.w,
                            height:71.h,
                            color: Colors.black,
                            child: Center(child: Text('Step\n   3',style: TextStyle(color: Colors.white,fontSize: 16.sp),),),
                          ),
                          Column(
                            children: [
                              const Text('Complete Repair'),
                              SizedBox(height: 5.h,),
                              Padding(
                                padding: const EdgeInsets.only(left: 100.0,top: 20),
                                child: Container(width: 50.w,height: 18.h,decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(50)),
                                  child: Center(child: Text('Create',style: TextStyle(fontSize: 12.sp,color: Colors.white),)),),
                              )
                            ],
                          )
                        ],
                      ),

                    ),
                  ],
                ),
              ),
              Positioned(top: 596.h,left: 65.w,
                child: Column(
                  children: [
                    Container(
                      width: 273.w,height: 80.h,color: const Color(0xffF7F7F7),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text('Create Invoice and collect\npayment',),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 80.0,top: 5),
                                child: Container(width: 100.w,height: 18.h,decoration: BoxDecoration(color: Colors.grey,borderRadius: BorderRadius.circular(50)),
                                  child: Center(child: Text('Create Invoice',style: TextStyle(fontSize: 12.sp,color: Colors.white),)),),
                              )
                            ],
                          ),const Spacer(),
                          Container(
                            width: 66.w,
                            height:71.h,
                            color: Colors.black,
                            child: Center(child: Text('Step\n   4',style: TextStyle(color: Colors.white,fontSize: 16.sp),),),
                          ),
                        ],
                      ),

                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
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
