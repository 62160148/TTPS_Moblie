import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  // const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    // getUsername();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: ListView(
          children: [
            Image.network(
              'https://live.staticflickr.com/7021/6460364961_e13f69d3d3_n.jpg',
              height: 150,
              width: 150,
            ),
            SizedBox(height: 20),
            Text(
              'Login',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                  fontSize: 30),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
                controller: username,
                decoration: InputDecoration(
                    labelText: 'Username', border: OutlineInputBorder())),
            SizedBox(height: 20),
            TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Password', border: OutlineInputBorder())),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // if (username.text == 'admin' && password.text == '1234') {
                //   print("USERNAME = admin, PASSWORD = 1234");
                //   setState(() {
                //     username.text = 'admin';
                //     password.text = '1234';

                //     setUsername(username.text);
                //     setPassword(password.text);
                //     setStatus('Login Success');
                //   });
                // } else {
                //   print("User = Others");
                //   setStatus('Login Failed');
                // }
              },
              child: Text("SIGN IN"),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 255, 0, 25)),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.fromLTRB(50, 20, 50, 20)),
                  textStyle:
                      MaterialStateProperty.all(TextStyle(fontSize: 20))),
            ),
            // SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     // Navigator.push(context,
            //     //     MaterialPageRoute(builder: (context) => ProfilePage()));
            //   },
            //   // child: Text("ไปหน้า Profile"),
            //   // style: ButtonStyle(
            //   //     backgroundColor: MaterialStateProperty.all(Colors.black87),
            //   //     padding: MaterialStateProperty.all(
            //   //         EdgeInsets.fromLTRB(50, 20, 50, 20)),
            //   //     textStyle:
            //   //         MaterialStateProperty.all(TextStyle(fontSize: 30))),
            // ),
          ],
        ),
      ),
    );
  }
}

// Future<void> setUsername(textUsername) async {
//   final SharedPreferences pref = await SharedPreferences.getInstance();
//   pref.setString('username', textUsername);
// }

// Future<void> setPassword(textPassword) async {
//   final SharedPreferences pref = await SharedPreferences.getInstance();
//   pref.setString('password', textPassword);
// }

// Future<void> setStatus(textStatus) async {
//   final SharedPreferences pref = await SharedPreferences.getInstance();
//   pref.setString('status', textStatus);
// }
