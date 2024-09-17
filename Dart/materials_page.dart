import 'package:flutter/material.dart';

class MaterialsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                '연구실 자료',
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Upload
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
                      Icon(Icons.add, size: 22),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: Text(
                          '업로드',
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
                  //
                },
              ),
            ),

            // Edit
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
                      Icon(Icons.edit, size: 22),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: Text(
                          '수정',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  //
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
