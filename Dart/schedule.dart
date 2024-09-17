import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Schedule {
  late final DateTime date;
  late final String name;
  final TimeOfDay time;
  late final String participants;

  Schedule({
    required this.date,
    required this.name,
    required this.time,
    required this.participants,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': DateFormat('yyyy-MM-dd').format(date),
      'name': name,
      'hour': time.hour,
      'minute': time.minute,
      'participants': participants,
    };
  }

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      date: DateTime.parse(json['date']),
      name: json['name'],
      time: TimeOfDay(hour: json['hour'], minute: json['minute']),
      participants: json['participants'],
    );
  }
}
