import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'schedule.dart';
import 'user.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User user;
  String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  List<Schedule> schedules = [];

  @override
  void initState() {
    super.initState();
    _loadSchedules();
  }

  Future<void> _loadSchedules() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? schedulesJson = prefs.getStringList('schedules');

    if (schedulesJson != null) {
      setState(() {
        schedules = schedulesJson.map((e) => Schedule.fromJson(jsonDecode(e))).toList();
      });
    }
  }

  void _showNotification() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          child: Center(
            child: Text('연구실 자료가 업데이트 되었습니다.'),
          )
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context)!.settings.arguments as User;

    // Filter today's schedules
    List<Schedule> todaysSchedules = schedules
        .where((schedule) =>
    schedule.date.year == DateTime.now().year &&
        schedule.date.month == DateTime.now().month &&
        schedule.date.day == DateTime.now().day)
        .toList();

    // Sort schedules by time
    todaysSchedules.sort((a, b) => a.time.hour.compareTo(b.time.hour));

    return Scaffold(
      appBar: AppBar(
        title: const Image(
          image: AssetImage('images/GVE_Logo.jpg'),
          height: 20,
        ),
        actions: [
          IconButton(
            onPressed: _showNotification,
            icon: Icon(Icons.add_alert),
          ),
        ],
      ),
      body: Container(
        color: Colors.grey.withOpacity(0.1),
        child: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [

                  // User name
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 40, 0, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${user.name}',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Homepage
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: Size(300, 65),
                        backgroundColor: Colors.blueGrey[500],
                        alignment: Alignment.centerLeft,
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.home_outlined, size: 22, color: Colors.white70,),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: Text(
                                '홈페이지',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                        launch("https://sites.google.com/view/gvelab/home");
                      },
                    ),
                  ),

                  // Lab Folder
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: Size(300, 65),
                        backgroundColor: Colors.yellow[600],
                        alignment: Alignment.centerLeft,
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.folder_copy_outlined, size: 22),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: Text(
                                '연구실 자료',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/materials');
                      },
                    ),
                  ),

                  // Ranking
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white70,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: Size(300, 65),
                        backgroundColor: Colors.teal[300],
                        alignment: Alignment.centerLeft,
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.leaderboard_outlined, size: 22),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: Text(
                                '랭킹',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/ranking');
                      },
                    ),
                  ),

                  // Schedule
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 30, 0, 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '스케줄',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: Size(345, 150),
                        backgroundColor: Colors.pink[100],
                        alignment: Alignment.centerLeft,
                        textStyle: const TextStyle(fontSize: 15),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              todayDate,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            if (todaysSchedules.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: todaysSchedules
                                    .map(
                                      (schedule) => Text(
                                    '${schedule.time.format(context)} - ${schedule.name}',
                                  ),
                                )
                                    .toList(),
                              )
                            else
                              Text('오늘 스케줄 없음'),
                          ],
                        ),
                      ),
                      onPressed: () async {
                        await Navigator.pushNamed(context, '/schedule');
                        _loadSchedules(); // 스케줄 페이지에서 돌아오면 스케줄을 다시 로드
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: DraggableScrollableSheet(
                initialChildSize: 0.2,
                minChildSize: 0.2,
                maxChildSize: 0.87,
                builder: (BuildContext context, ScrollController scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 6,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child: Column(
                                    children: [
                                      Text(
                                        '출근 태그',
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
                                        child: Icon(Icons.qr_code_2_rounded, size: 100),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
