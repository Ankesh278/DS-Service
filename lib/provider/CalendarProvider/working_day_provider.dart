

import 'package:flutter/cupertino.dart';

class WorkState with ChangeNotifier {
  DateTime? _selectedDay;
  final List<String> _selectedTimeSlots = [];
  int _totalWorkingHours = 0;
  bool _isWorkingToday = false;
  bool _isTimeSlotsVisible = false;
  bool _totalTimeShow = false;
  bool _removeTimeSlot = true;

  DateTime? get selectedDay => _selectedDay;
  List<String> get selectedTimeSlots => _selectedTimeSlots;
  int get totalWorkingHours => _totalWorkingHours;
  bool get isWorkingToday => _isWorkingToday;
  bool get isTimeSlotsVisible => _isTimeSlotsVisible;
  bool get totalTimeShow => _totalTimeShow;
  bool get removeTimeSlot => _removeTimeSlot;
  void removeTime(bool remove){
    _removeTimeSlot=remove;
  }

  void setTotalTime(bool show){
    _totalTimeShow=show;
  }




  void setSelectedDay(DateTime selectedDay) {
    _selectedDay = selectedDay;
    _isWorkingToday = false;
    _selectedTimeSlots.clear();
    _removeTimeSlot=false;
    _totalWorkingHours = 0;
    _isTimeSlotsVisible = false;
    notifyListeners();
  }


  void toggleTimeSlot(String slot, bool isSelected) {
    if (isSelected) {
      _selectedTimeSlots.add(slot);
    } else {
      _selectedTimeSlots.remove(slot);
    }
    _totalWorkingHours = _selectedTimeSlots.length * 2;
    notifyListeners();
  }


  // Sets whether the user is working today
  void setWorkingToday(bool isWorking) {
    _isWorkingToday = isWorking;
    _isTimeSlotsVisible = isWorking;
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
