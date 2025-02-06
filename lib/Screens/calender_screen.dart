
import 'package:ds_service/AppsColor/app_color.dart';
import 'package:ds_service/Resources/app_images.dart';
import 'package:flutter/material.dart';
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
                    child: TableCalendar(
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





  void _showTimeSlotDialog(DateTime selectedDay) {
    List<String> timeSlots = ['8-10 AM', '10-12 AM', '12-2 PM', '2-4 PM', '4-6 PM', '6-8 PM'];
    Map<String, bool> selectedSlots = {
      for (var slot in timeSlots) slot: false,
    };

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(10), // Makes dialog wider
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Select Time Slots',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                StatefulBuilder(
                  builder: (context, setDialogState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: timeSlots.map((slot) {
                        return Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                title: Text(slot),
                                value: selectedSlots[slot],
                                onChanged: (isChecked) {
                                  setDialogState(() {
                                    selectedSlots[slot] = isChecked!;

                                  });
                                },
                                activeColor: Colors.green,
                                checkColor: Colors.white,
                              ),
                            ),
                            if (!selectedSlots[slot]!) // Show "Cut" button only when not selected
                              IconButton(
                                icon: const Icon(Icons.close, color: Colors.red),
                                onPressed: () {
                                  setDialogState(() {
                                    selectedSlots[slot] = false;
                                  });
                                },
                              ),
                          ],
                        );
                      }).toList(),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        final workingSlots = selectedSlots.entries
                            .where((entry) => entry.value)
                            .map((entry) => entry.key)
                            .toList();

                        if (workingSlots.isNotEmpty) {
                          setState(() {
                            _dayMarkers[selectedDay] = const Icon(
                              Icons.task_alt_outlined,
                              color: Colors.green,
                              size: 14,
                            );
                          });
                          Navigator.pop(context);
                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Working slots: ${workingSlots.join(", ")}'),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('No slots selected.')),
                          );
                        }
                      },
                      child: const Text('Submit'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
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

                                      Navigator.pop(context);
                                      _showLeaveConfirmationDialog(selectedDay);
                                      setState(() {
                                        _dayMarkers[selectedDay] =
                                        const Icon(Icons.data_exploration_outlined,color: Colors.amber,size: 12,);
                                      });
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
                                    onPressed: () {
                                      _showTimeSlotDialog(selectedDay);
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
