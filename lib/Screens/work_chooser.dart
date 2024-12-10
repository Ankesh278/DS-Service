import 'package:ds_service/AppsColor/appColor.dart';
import 'package:ds_service/Resources/app_images.dart';
import 'package:ds_service/provider/CalendarProvider/workingDayProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class WorkChooser extends StatelessWidget {
  final DateTime initialDate;

  const WorkChooser({super.key, required this.initialDate});

  String formatDate(DateTime? date) {
    if (date == null) return 'No date selected';
    final day = DateFormat('EEEE').format(date);
    final month = DateFormat('MMMM').format(date);
    final dayNumber = date.day;
    final suffix = getDaySuffix(dayNumber);
    return '$day, $month $dayNumber$suffix';
  }

  String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<WorkState>(
        builder: (context, workState, _) {
          final screenHeight = MediaQuery.of(context).size.height;
          final screenWidth = MediaQuery.of(context).size.width;
          final formattedDate = formatDate(workState.selectedDay);

          return Stack(
            children: [
              Container(color: Colors.white),
              Positioned(
                top: 0,
                width: screenWidth,
                height: screenHeight * 0.7,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: screenHeight * 0.3,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                    ),
                  ),
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
                            onPressed: () => Navigator.pop(context),
                          ),
                          const SizedBox(width: 48), // Spacer for alignment
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30.0),
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: TableCalendar(
                        firstDay: DateTime.utc(2000, 1, 1),
                        lastDay: DateTime.utc(2100, 12, 31),
                        focusedDay: workState.selectedDay ?? initialDate,
                        calendarFormat: CalendarFormat.week,
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        selectedDayPredicate: (day) =>
                            isSameDay(workState.selectedDay, day),
                        enabledDayPredicate: (day) => day.isAfter(
                            DateTime.now().subtract(const Duration(days: 1))),
                        onDaySelected: (selectedDay, focusedDay) =>
                            workState.setSelectedDay(selectedDay),
                        headerVisible: false,
                        calendarStyle: const CalendarStyle(
                          isTodayHighlighted: false,
                          selectedDecoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.rectangle,
                          ),
                          selectedTextStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          defaultTextStyle: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          weekendTextStyle: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          disabledTextStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (workState.selectedDay != null)
                      Text(
                        formattedDate,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    if (!workState.isWorkingToday)
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.white, width: 1.5),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 20),
                            const Text(
                              "Mark your calendar",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                            const Spacer(),
                            const Icon(Icons.keyboard_arrow_up_outlined,
                                color: Colors.white),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                    if (workState.selectedDay != null)
                      workState.isWorkingToday
                          ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          children: [
                            _statusContainer(
                                "You are working today", true),
                            const SizedBox(height: 10),
                            _statusContainer(
                                "You are working ${workState.totalWorkingHours} hours",
                                true),
                          ],
                        ),
                      )
                          : _timeSlots(workState),
                  ],
                ),
              ),
              if (workState.selectedTimeSlots.isNotEmpty &&
                  !workState.isWorkingToday)
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      workState.setWorkingToday(true);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "You have set today's calendar successfully!"),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 3),
                        ),
                      );
                    },
                    child: const Text("Submit"),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _statusContainer(String message, bool isPositive) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: isPositive ? Colors.green : Colors.red, width: 1.5),
      ),
      child: Row(
        children: [
          Icon(isPositive ? Icons.check_circle : Icons.cancel,
              color: isPositive ? Colors.green : Colors.red),
          const SizedBox(width: 10),
          Text(
            message,
            style: TextStyle(
              color: isPositive ? Colors.green : Colors.red,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _timeSlots(WorkState workState) {
    return Visibility(
     // visible: workState.showTimeSlotDropdown, // Only show when the button is pressed
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Time Slots:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...['8-10', '10-12', '12-2', '2-4', '4-6', '6-8'].map((slot) {
              return CheckboxListTile(
                value: workState.selectedTimeSlots.contains(slot),
                onChanged: (isSelected) =>
                    workState.toggleTimeSlot(slot, isSelected!),
                title: Text(slot),
              );
            }),
          ],
        ),
      ),
    );
  }
}
