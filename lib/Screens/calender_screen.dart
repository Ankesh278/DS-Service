import 'package:ds_service/AppsColor/appColor.dart';
import 'package:ds_service/Screens/work_chooser.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
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
                      firstDay: DateTime.utc(2000, 1, 1),
                      lastDay: DateTime.utc(2100, 12, 31),
                      focusedDay: DateTime.now(),
                     // selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                      onDaySelected: (selectedDay, focusedDay) {
                        print("Day is clicked ");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WorkChooser(
                              initialDate: selectedDay,
                            ),
                          ),
                        );

                      },
                      calendarStyle: CalendarStyle(
                        defaultTextStyle: TextStyle(color: Colors.white,fontSize: 22),
                        todayDecoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                        weekendTextStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22
                        ),
                      ),
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextStyle: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
                        rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

