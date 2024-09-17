import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'schedule.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  late TextEditingController _nameController;
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  String _participants = '전체';

  List<Schedule> schedules = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
    _loadSchedules();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _loadSchedules() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? schedulesJson = prefs.getStringList('schedules');

    if (schedulesJson != null) {
      setState(() {
        schedules = schedulesJson.map((e) => Schedule.fromJson(json.decode(e))).toList();
      });
    }
  }

  Future<void> _saveSchedules() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> schedulesJson = schedules.map((e) => json.encode(e.toJson())).toList();
    prefs.setStringList('schedules', schedulesJson);
  }

  Future<void> _addSchedule() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: _selectedTime,
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDate = pickedDate;
          _selectedTime = pickedTime;
        });

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('스케줄 추가'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: '스케줄 이름'),
                ),
                DropdownButtonFormField(
                  value: _participants,
                  onChanged: (value) {
                    setState(() {
                      _participants = value.toString();
                    });
                  },
                  items: ['전체', '나'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('취소'),
              ),
              TextButton(
                onPressed: () {
                  final newSchedule = Schedule(
                    date: _selectedDate,
                    name: _nameController.text,
                    time: _selectedTime,
                    participants: _participants,
                  );

                  setState(() {
                    schedules.add(newSchedule);
                  });

                  _saveSchedules();
                  Navigator.pop(context);
                },
                child: Text('추가'),
              ),
            ],
          ),
        );
      }
    }
  }

  Future<void> _editSchedule(int index) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: schedules[index].date,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(schedules[index].date),
      );

      if (pickedTime != null) {
        setState(() {
          schedules[index].date = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('스케줄 수정'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: TextEditingController(text: schedules[index].name),
                  decoration: InputDecoration(labelText: '스케줄 이름'),
                  onChanged: (value) {
                    setState(() {
                      schedules[index].name = value;
                    });
                  },
                ),
                DropdownButtonFormField(
                  value: schedules[index].participants,
                  onChanged: (value) {
                    setState(() {
                      schedules[index].participants = value.toString();
                    });
                  },
                  items: ['전체', '나'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('취소'),
              ),
              TextButton(
                onPressed: () {
                  _saveSchedules();
                  Navigator.pop(context);
                },
                child: Text('저장'),
              ),
            ],
          ),
        );
      }
    }
  }

  Future<void> _deleteSchedule(int index) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('스케줄 삭제'),
        content: Text('이 스케줄을 삭제하시겠습니까?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('아니오'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                schedules.removeAt(index);
              });
              _saveSchedules();
              Navigator.pop(context);
            },
            child: Text('예'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Image(
              image: AssetImage('images/GVE_Logo.jpg'),
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                '스케줄',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: schedules.length,
        itemBuilder: (context, index) {
          final schedule = schedules[index];
          return ListTile(
            title: Text(schedule.name),
            subtitle: Text('${DateFormat('yyyy-MM-dd').format(schedule.date)} ${schedule.time.format(context)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _editSchedule(index);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteSchedule(index);
                  },
                ),
              ],
            ),
            onTap: () {
              // Implement tap logic if needed
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSchedule,
        tooltip: '스케줄 추가',
        child: Icon(Icons.add),
      ),
    );
  }
}
