import 'package:flutter/material.dart';

class TimeSlotsProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _timesMorning = [];
  final List<Map<String, dynamic>> _timesAfternoon = [];
  final List<Map<String, dynamic>> _timesEvening = [];
  final List<Map<String, dynamic>> _zones = [];
  List<DateTime> _selectedTimes = [];
  bool _selected = false;

  //Constructor for initializing all Lists with init Values.
  TimeSlotsProvider({required DateTime date}) {
    initializeTimeZones();
    initializeDateTimesMorning(date);
    initializeDateTimesAfternoon(date);
    initializeDateTimesEvening(date);
  }

  //If at least one Item in any List is true, this returns true.
  bool get selected {
    return _selected;
  }
  //Is set if at least one item is selected.
  set selected(bool selected){
    _selected = selected;
  }
  //Returns the list of all selected times.
  List<DateTime> get selectedTimes {
    return _selectedTimes;
  }
  //Returns the list of all selectable times on afternoon
  List<Map<String, dynamic>> get timesAfternoon {
    return _timesAfternoon;
  }
  //Returns the list of all selectable times on evening
  List<Map<String, dynamic>> get timesEvening {
    return _timesEvening;
  }
  //Returns the list of all selectable times in the morning
  List<Map<String, dynamic>> get timesMorning {
    return _timesMorning;
  }
 //Returns the list of all selectable timezones.. whole morning.. evening..
  List<Map<String, dynamic>> get zones {
    return _zones;
  }
  //If timeslots get selected single till every timeslot in one timezone is selected
  //its associated container needs to be filled black.
  //So this function checks whether all elements in a group are toggled.
  void hasAllElementsToggled() {
    bool morningAllToggled =
    timesMorning.every((element) => element['Toggled']);
    bool afternoonAllToggled =
    timesAfternoon.every((element) => element['Toggled']);
    bool eveningAllToggled =
    timesEvening.every((element) => element['Toggled']);

    if(morningAllToggled){
      zones[0]["Toggled"] = true;
    }else{
      zones[0]["Toggled"] = false;
    }
    if(afternoonAllToggled){
      zones[1]["Toggled"] = true;
    }else{
      zones[1]["Toggled"] = false;
    }
    if(eveningAllToggled){
      zones[2]["Toggled"] = true;
    }else{
      zones[2]["Toggled"] = false;
    }

    notifyListeners();
  }



  //Iterate through all available lists.
  //If an element is Toggled(selected) it is added to the selectedTimes list.
  void addSelectedToggledTimes() {
    selectedTimes.clear();

    List<List<Map<String, dynamic>>> timeSlotLists = [
      timesMorning,
      timesAfternoon,
      timesEvening,
    ];

    for (List<Map<String, dynamic>> timeSlotList in timeSlotLists) {
      for (Map<String, dynamic> timeSlot in timeSlotList) {
        if (timeSlot['Toggled']) {
          selectedTimes.add(timeSlot['DateTime']);
        }
      }
    }
    notifyListeners();
  }
  //Iterates through all lists to check whether there is at least one element toggled,
  //for enabling and disabling the next button.
  void hasToggledElement() {
    bool morningToggled = timesMorning.any((element) => element['Toggled']);
    bool afternoonToggled =
        timesAfternoon.any((element) => element['Toggled']);
    bool eveningToggled = timesEvening.any((element) => element['Toggled']);
    if (morningToggled || afternoonToggled || eveningToggled) {
      selected = true;
    } else {
      selected = false;
    }
    notifyListeners();
  }
  //Toggles a single selectable element.
  void toggleSingleTimeSlot(int index, String listName) {
    switch (listName) {
      case "Morning":
        timesMorning[index]['Toggled'] = !timesMorning[index]['Toggled'];
        break;
      case "Afternoon":
        timesAfternoon[index]['Toggled'] = !timesAfternoon[index]['Toggled'];
        break;
      case "Evening":
        timesEvening[index]['Toggled'] = !timesEvening[index]['Toggled'];
        break;
      case "Zones":
        zones[index]['Toggled'] = !zones[index]['Toggled'];
        break;
    }
    //change "selected" if necessary
    hasToggledElement();
    hasAllElementsToggled();
    notifyListeners();
  }
  //Toggles a whole group if selecting one, morning.. afternoon.. evening
  void _toggleTimeSlotsGroup(List<dynamic> timeSlots, bool toggleState) {
    for (var i = 0; i < timeSlots.length; i++) {
      timeSlots[i]["Toggled"] = toggleState;
    }
    hasToggledElement();
  }
  //selecting which whole group needs to be selected.
  void toggleTimeSlotGroup(String group) {
    switch (group) {
      case "Morning":
        _toggleTimeSlotsGroup(timesMorning, zones[0]["Toggled"]);
        break;
      case "Afternoon":
        _toggleTimeSlotsGroup(timesAfternoon, zones[1]["Toggled"]);
        break;
      case "Evening":
        _toggleTimeSlotsGroup(timesEvening, zones[2]["Toggled"]);
        break;
    }
    notifyListeners();
  }

  //Initializes the zones list with its 3 possible zones. Morning, Afternoon and Evening.
  Future<bool> initializeTimeZones() async {
    zones.clear();
    List<String> dayTimeZones = ["Morning", "Afternoon", "Evening"];
    for (var element in dayTimeZones) {
      zones.add({
        "String": element,
        "Toggled": false,
      });
    }
    return true;
  }
  //Initializes the timesMorning list with all needed times.
  Future<bool> initializeDateTimesMorning(DateTime time) async {
    timesMorning.clear();
    //Set initial Hour to 7:00.
    //Change this if you want to change the starting hour => time = DateTime(time.year, time.month, time.day, 7, 0, time.second
    time = DateTime(time.year, time.month, time.day, 7, 0, time.second,
        time.millisecond, time.microsecond);
    //Generates 10 timeslots, each 30 minutes delayed.
    for (int i = 0; i < 10; i++) {
      timesMorning.add({
        "String":
            "${time.hour > 9 ? time.hour : "0${time.hour}"}:${time.minute != 0 ? time.minute : "00"}",
        "DateTime": time,
        "Toggled": false,
      });
      time = time.add(const Duration(minutes: 30));
    }
    return true;
  }
  //Initializes the timesAfternoon list with all needed times.
  initializeDateTimesAfternoon(DateTime time) async {
    timesAfternoon.clear();
    //Set initial Hour to 12:00.
    //Change this if you want to change the starting hour => time = DateTime(time.year, time.month, time.day, 12, 0, time.second
    time = DateTime(time.year, time.month, time.day, 12, 0, time.second,
        time.millisecond, time.microsecond);
    //Generates 11 timeslots, each 30 minutes delayed
    for (int i = 0; i < 11; i++) {
      timesAfternoon.add({
        "String":
            "${time.hour > 9 ? time.hour : "0${time.hour}"}:${time.minute != 0 ? time.minute : "00"}",
        "DateTime": time,
        "Toggled": false,
      });
      time = time.add(const Duration(minutes: 30));
    }
    return true;
  }
  //Initializes the timesEvening list with all needed times.
  initializeDateTimesEvening(DateTime time) async {
    timesEvening.clear();
    //Set initial Hour to 7:00.
    //Change this if you want to change the starting hour => time = DateTime(time.year, time.month, time.day, 17, 0, time.second
    time = DateTime(time.year, time.month, time.day, 17, 0, time.second,
        time.millisecond, time.microsecond);
    //Generates 5 timeslots, each 30 minutes dalayed.
    for (int i = 0; i < 5; i++) {
      timesEvening.add({
        "String":
            "${time.hour > 9 ? time.hour : "0${time.hour}"}:${time.minute != 0 ? time.minute : "00"}",
        "DateTime": time,
        "Toggled": false,
      });
      time = time.add(const Duration(minutes: 30));
    }
    return true;
  }
}
