import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:ttpsmobile/pages/home.dart';

class LoginPage extends StatefulWidget {
  // const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // for login wrong
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  bool passenable = true; //boolean value to track password view enable disable

  String getUsername() {
    return username.text;
  }

  @override
  void initState() {
    username.text = "";
    password.text = "";
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: SizedBox.expand(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(
                  'https://docplayer.info/docs-images/100/143566411/images/1-0.jpg'),
              fit: BoxFit.cover,
            )),
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: ListView(
                children: [
                  Image.network(
                    'https://live.staticflickr.com/7021/6460364961_e13f69d3d3_n.jpg',
                    height: 150,
                    width: 150,
                  ),
                  SizedBox(height: 10),
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
                        labelText: 'Username',
                        icon: Icon(Icons.people),
                        // border: OutlineInputBorder()
                      )),
                  SizedBox(height: 20),
                  TextField(
                      obscureText: passenable,
                      controller: password,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          icon: Icon(Icons.lock),
                          // border: OutlineInputBorder()
                          suffix: IconButton(
                              onPressed: () {
                                //add Icon button at end of TextField
                                setState(() {
                                  //refresh UI
                                  if (passenable) {
                                    //if passenable == true, make it false
                                    passenable = false;
                                  } else {
                                    passenable =
                                        true; //if passenable == false, make it true
                                  }
                                });
                              },
                              icon: Icon(passenable == true
                                  ? Icons.remove_red_eye
                                  : Icons.password)))),
                  SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      if (username.text == "00009" &&
                          password.text == "123456") {
                        setState(() {
                          setUsername(username.text);
                          setStatus("Success!");

                          print("User = Employee");
                          print("Login Success");
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      } else {
                        setStatus("Failed!");
                        
                        print("User = Other");
                        print("Login Fail");

                        signIn();
                      }
                      print("Username = " + username.text);
                    },
                    child: Text("SIGN IN"),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 60, 165, 255)),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.fromLTRB(50, 20, 50, 20)),
                        textStyle:
                            MaterialStateProperty.all(TextStyle(fontSize: 20))),
                  ),
                ],
              ),
            ),
          ),
        ));
  } //widget build

  Future<void> setUsername(textUsername) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('username', textUsername);
  }

  void setStatus(textStatus) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('status', textStatus);
  }

  void signIn() {
    scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text(
        "username or password incorect!",
        style: TextStyle(color: Colors.white, fontSize: 18)
      ),
      backgroundColor: Colors.red,
    ));
  }
}
