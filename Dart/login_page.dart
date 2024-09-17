import 'package:flutter/material.dart';
import 'user.dart';
import 'signup_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image(
              image: AssetImage('images/GVE_Logo.jpg'),
              height: 20,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                '로그인',
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
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                labelText: 'ID',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password'
              ),
              obscureText: true,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 20, 10, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: Size(120, 50),
                      backgroundColor: Colors.blueGrey[500],
                      alignment: Alignment.center,
                    ),
                    onPressed: () {
                      _login(context);
                    },
                    child: Text(
                      '로그인',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 35, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: Size(120, 50),
                      backgroundColor: Colors.blueGrey[500],
                      alignment: Alignment.center,
                    ),
                    onPressed: () {
                      // 회원가입 페이지
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Text(
                      '회원가입',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _login(BuildContext context) {
    String id = _idController.text;
    String password = _passwordController.text;

    User? user = UserManager.authenticate(id, password);
    if (user != null) {
      Navigator.pushReplacementNamed(context, '/home', arguments: user); // 인증된 사용자 정보를 HomePage로 전달
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('로그인 실패'),
          content: Text('ID 또는 Password가 일치하지 않습니다.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('확인'),
            ),
          ],
        ),
      );
    }
  }
}
