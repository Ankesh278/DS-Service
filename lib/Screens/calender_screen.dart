
import 'dart:convert';

import 'package:ds_service/AppsColor/app_color.dart';
import 'package:ds_service/Resources/app_images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});
  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}
class _CalendarScreenState extends State<CalendarScreen> {
  DateTime? _selectedDay;
  final DateTime _focusedDay = DateTime.now();
  late final  Map<DateTime, Widget> _dayMarkers = {};

  void _saveAvailabilityStatus(DateTime day, String status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(day.toIso8601String(), status); // Convert DateTime to String
  }


  Future<String?> _getAvailabilityStatus(String day) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(day);
  }
  void _loadAvailabilityStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _dayMarkers.forEach((date, value) async {
        String dayKey = date.toIso8601String(); // Convert DateTime to String
        String? status = prefs.getString(dayKey);

        if (status == "Yes") {
          _dayMarkers[date] = const Icon(Icons.done, color: Colors.green, size: 12);
        } else if (status == "No") {
          _dayMarkers[date] = const Icon(Icons.data_exploration_outlined, color: Colors.amber, size: 12);
        }
      });
    });
  }


  @override
  void initState() {
    super.initState();
    _loadAvailabilityStatus();
  }


  Future<void> _submitAvailability(DateTime selectedDay, List<String> selectedSlots) async {
    try {

        User? user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          Get.snackbar("Error", "User not logged in");
          return;
        }
        String uid = user.uid;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? vendorId = prefs.getString('vendor_id');


        final response = await http.post(
        Uri.parse('http://15.207.112.43:8080/api/vendor/markAvailability'), // Replace with your API URL
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "vendorId":vendorId ,
          "availabilities": [
            {
              "date": DateFormat('yyyy-MM-dd').format(selectedDay),
              "timeSlots": selectedSlots, // Send selected time slots
              "status": selectedSlots.isEmpty ? "leave" : "working"
            }
          ]
        }),
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("✅ Availability Updated: ${responseData['message']}");
      } else {
        print("❌ Failed to update availability: ${responseData['message']}");
        print(uid);
      }
    } catch (e) {
      print("❌ Error: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
          Positioned(
            top: 0,
            width: screenWidth,
            height: screenHeight * 0.7,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(50)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: screenHeight * 0.3,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                  ),
                ),
                Container(
                  width: screenWidth,
                  height: screenHeight * 0.3,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(50)),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            top: 30,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Text(
                        'Calendar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child:
                    TableCalendar(
                      firstDay: DateTime.now(),
                      lastDay: DateTime.utc(2100, 12, 31),
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) =>
                          isSameDay(day, _selectedDay),
                      onDaySelected: (selectedDay, focusedDay) {
                        _showWorkDialog(selectedDay);

                      },
                      calendarStyle: const CalendarStyle(
                        defaultTextStyle:
                            TextStyle(color: Colors.white, fontSize: 22),
                        todayDecoration: BoxDecoration(),
                        selectedDecoration: BoxDecoration(),
                        weekendTextStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                      daysOfWeekHeight: 25,
                      daysOfWeekStyle: const DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                        weekendStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w800
                        )
                      ),
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        leftChevronIcon:
                            Icon(Icons.chevron_left, color: Colors.white),
                        rightChevronIcon:
                            Icon(Icons.chevron_right, color: Colors.white),
                      ),
                      calendarBuilders: CalendarBuilders(
                        defaultBuilder: (context, day, focusedDay) {
                          // Handle custom display for all days including "today"
                          if (_dayMarkers.containsKey(day)) {
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                Text(
                                  '${day.day}',
                                  style: const TextStyle(color: Colors.white, fontSize: 22),
                                ),
                                Positioned(
                                  bottom: 1,
                                  child: _dayMarkers[day]!,
                                ),
                              ],
                            );
                          } else {
                            return Center(
                              child: Text(
                                '${day.day}',
                                style: const TextStyle(color: Colors.white, fontSize: 22),
                              ),
                            );
                          }
                        },
                        todayBuilder: (context, day, focusedDay) {
                          // Explicitly handle "today" date the same way as other dates
                          if (_dayMarkers.containsKey(day)) {
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                Text(
                                  '${day.day}',
                                  style: const TextStyle(color: Colors.white, fontSize: 22),
                                ),
                                Positioned(
                                  bottom: 1,
                                  child: _dayMarkers[day]!,
                                ),
                              ],
                            );
                          } else {
                            return Center(
                              child: Text(
                                '${day.day}',
                                style: const TextStyle(color: Colors.white, fontSize: 22),
                              ),
                            );
                          }
                        },
                      ),

                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }


  Future<List<String>> _showTimeSlotDialog(DateTime selectedDay) async {
    List<String> selectedSlots = []; // Declare before using it

    List<String>? result = await showDialog<List<String>>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text("Select Time Slots"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CheckboxListTile(
                    title: const Text("10:00-12:00"),
                    value: selectedSlots.contains("10:00-12:00"),
                    onChanged: (bool? value) {
                      setDialogState(() {
                        if (value == true) {
                          selectedSlots.add("10:00-12:00");
                        } else {
                          selectedSlots.remove("10:00-12:00");
                        }
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text("14:00-16:00"),
                    value: selectedSlots.contains("14:00-16:00"),
                    onChanged: (bool? value) {
                      setDialogState(() {
                        if (value == true) {
                          selectedSlots.add("14:00-16:00");
                        } else {
                          selectedSlots.remove("14:00-16:00");
                        }
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, selectedSlots); // Return selected slots
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      },
    );

    return result ?? []; // Ensure function always returns a list (empty if user cancels)
  }







  void _showWorkDialog(DateTime selectedDay) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 0,
                width: screenWidth,
                height: screenHeight * 0.7,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                width: screenWidth,
                height: screenHeight * 0.64,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(80),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: screenHeight * 0.3,
                      color: AppColors.primaryColor,
                    ),
                    Container(
                      width: screenWidth,
                      height: screenHeight * 0.3,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                top: 30,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                          const SizedBox(width: 48),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 35),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(7)
                      ),
                      child: Row(
                        children: [
                          const Text("Mark your calendar",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14),),
                          const Spacer(),
                          Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white
                              ),
                              child: const Icon(Icons.keyboard_arrow_up_outlined,color: Colors.black,))
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child:
                                Icon(Icons.work, size: 48, color: Colors.blue),
                          ),
                          const Text(
                            "Are you working?",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16,color: Colors.green),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.grey, // Text (foreground) color
                                      shadowColor: Colors.grey, // Shadow color
                                      elevation: 5, // Elevation of the button
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Padding
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8), // Rounded corners
                                      ),
                                  ),
                                    onPressed: () {
                                      _saveAvailabilityStatus(selectedDay, "No");
                                      _submitAvailability(selectedDay, [],);
                                      Navigator.pop(context);
                                      setState(() {
                                        _dayMarkers[selectedDay] =
                                        const Icon(Icons.data_exploration_outlined,color: Colors.amber,size: 12,);
                                      });
                                      _showLeaveConfirmationDialog(selectedDay);
                                      // ScaffoldMessenger.of(context).showSnackBar(
                                      //   SnackBar(content: Text('Marked as leave.')),
                                      // );
                                    },
                                    child: const Text("No",style: TextStyle(color: Colors.black),)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.green, // Text (foreground) color
                                      shadowColor: Colors.green, // Shadow color
                                      elevation: 5, // Elevation of the button
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Padding
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8), // Rounded corners
                                      ),
                                    ),
                                    onPressed: () async{
                                      List<String> selectedTimeSlots = await _showTimeSlotDialog(selectedDay);
                                      if (selectedTimeSlots.isNotEmpty) {
                                        _saveAvailabilityStatus(selectedDay , "Yes");
                                        _submitAvailability(selectedDay, selectedTimeSlots,);
                                      }
                                      Navigator.pop(context);
                                      setState(() {
                                        _dayMarkers[selectedDay] =
                                        const Icon(Icons.done,color: Colors.green,size: 12,);
                                      });
                                    },
                                    child: const Text("Yes",style: TextStyle(color: Colors.white),)),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLeaveConfirmationDialog(DateTime selectedDay) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final formattedDate =
        "${selectedDay.day}/${selectedDay.month}/${selectedDay.year}";

    showDialog(
        context: context,
        builder: (context) {
          return Scaffold(
              body: Stack(children: [
            Positioned(
              left: 0,
              top: -screenHeight * 0.07,
              child: Image.asset(
                AppImages.loginEllipse, // Replace with your logo asset path
                width: screenWidth * 0.55,
                height: screenHeight * 0.34,
              ),
            ),
            Positioned(
                top: -10,
                right: 0,
                child: Image.asset(AppImages.ellipseRight)),
            Positioned(
                left: 20,
                top: screenHeight * 0.05,
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 30,
                    ))),
            Positioned(
                bottom: -10,
                left: 0,
                right: 0,
                child: Container(
                    height: screenHeight * 0.55,
                    decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Center(
                        child: SizedBox(
                            width: screenWidth * 0.7,
                            height: screenHeight * 0.3,
                            child: Column(
                              children: [
                                const Align(
                                    alignment: Alignment.topLeft,
                                    child: Icon(
                                      Icons.help_outline_outlined,
                                      color: Colors.white,
                                      size: 40,
                                    )),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Confirm leave on $formattedDate",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                    "You will stop receiving any jobs for this day.",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12)),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _dayMarkers[selectedDay] = const Icon(Icons.close,color: Colors.red,size: 14,);
                                    });
                                    Navigator.pop(context, true);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Leave confirmed for $formattedDate.')),
                                    );
                                  },
                                  child: Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    width: screenWidth * 0.6,
                                    margin: EdgeInsets.only(
                                        top: screenWidth * 0.04),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.black45),
                                    child: const Center(
                                        child: Text(
                                      "Accept",
                                      style: TextStyle(
                                          color: Colors.white),
                                    )),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _dayMarkers[selectedDay] = const Icon(Icons.data_exploration_outlined,size: 14,color: Colors.yellow,);
                                      Navigator.pop(context);
                                    });

                                  },
                                  child: Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    width: screenWidth * 0.6,
                                    margin: const EdgeInsets.only(top: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white),
                                    child: const Center(
                                        child: Text(
                                      "Not now",
                                      style: TextStyle(
                                          color: AppColors.primaryColor),
                                    )),
                                  ),
                                ),
                              ],
                            )))))
          ]));
        });
  }
}
