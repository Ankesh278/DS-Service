import 'package:flutter/cupertino.dart';

class WorkState with ChangeNotifier {
  DateTime? _selectedDay; // The selected day
  List<String> _selectedTimeSlots = []; // List of selected time slots
  int _totalWorkingHours = 0; // Total working hours
  bool _isWorkingToday = false; // Is the user working today
  bool _isTimeSlotsVisible = false; // Is the time slots dropdown visible

  // Getters for the private fields
  DateTime? get selectedDay => _selectedDay;
  List<String> get selectedTimeSlots => _selectedTimeSlots;
  int get totalWorkingHours => _totalWorkingHours;
  bool get isWorkingToday => _isWorkingToday;
  bool get isTimeSlotsVisible => _isTimeSlotsVisible;

  // Sets the selected day and resets relevant states
  void setSelectedDay(DateTime selectedDay) {
    _selectedDay = selectedDay;
    _isWorkingToday = false;
    _selectedTimeSlots.clear();
    _totalWorkingHours = 0;
    _isTimeSlotsVisible = false; // Reset flag when day changes
    notifyListeners();
  }

  // Toggles a time slot selection
  void toggleTimeSlot(String slot, bool isSelected) {
    if (isSelected) {
      _selectedTimeSlots.add(slot);
    } else {
      _selectedTimeSlots.remove(slot);
    }
    _totalWorkingHours = _selectedTimeSlots.length * 2; // Each slot is 2 hours
    notifyListeners();
  }


  // Sets whether the user is working today
  void setWorkingToday(bool isWorking) {
    _isWorkingToday = isWorking;
    _isTimeSlotsVisible = isWorking; // Show/hide time slots based on working status
    notifyListeners();
  }

  // Manually sets time slots visibility
  void setTimeSlotsVisible(bool isVisible) {
    _isTimeSlotsVisible = isVisible;
    notifyListeners();
  }

  // Clears all selections
  void clearSelections() {
    _selectedDay = null;
    _selectedTimeSlots.clear();
    _totalWorkingHours = 0;
    _isWorkingToday = false;
    _isTimeSlotsVisible = false;
    notifyListeners();
  }
}
