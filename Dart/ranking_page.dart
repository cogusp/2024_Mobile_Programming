import 'package:flutter/material.dart';

class RankingPage extends StatelessWidget {
  final List<Map<String, dynamic>> _rankings = [
    {'name': '사용자1', 'time': '100시간'},
    {'name': '사용자2', 'time': '90시간'},
    {'name': '사용자3', 'time': '80시간'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 20,),
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
                '랭킹',
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
        itemCount: _rankings.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${index + 1}    ${_rankings[index]['name']}                ${_rankings[index]['time']}'),
          );
        },
      ),
    );
  }
}
