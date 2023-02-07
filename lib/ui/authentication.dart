import 'package:clock_app/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:clock_app/helpers.dart';
import 'package:clock_app/net/flutterfire.dart';
import 'DetectMain.dart';
import 'Home.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Authentication extends StatefulWidget {
  Authentication({Key key}) : super(key: key);

  @override
  _AuthenticationState createState() => new _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final logo = CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: bigRadius,
      child: appLogo,
    );

    // email
    final pinCode = TextFormField(
      controller: _emailField,
      keyboardType: TextInputType.phone,
      maxLength: 20,
      maxLines: 1,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "something@email.com",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        hintStyle: TextStyle(color: appGreyColor),
        labelText: "電子郵件",
      ),
      style: TextStyle(
        color: appGreyColor,
      ),
    );

    //password
    final password = TextFormField(
      controller: _passwordField,
      obscureText: true,
      keyboardType: TextInputType.phone,
      maxLength: 20,
      maxLines: 1,
      autofocus: true,
      decoration: InputDecoration(
          hintText: "輸入密碼",
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
          hintStyle: TextStyle(color: appGreyColor),
          labelText: "密碼"),
      style: TextStyle(color: appGreyColor, fontSize: 15),
    );

    // loginbutton
    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () async {
          bool shouldNavigate =
              await signIn(_emailField.text, _passwordField.text);
          if (shouldNavigate) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
            Fluttertoast.showToast(
              msg: "登入成功",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black45,
              textColor: Colors.white,
              fontSize: 16.0,
              webShowClose: true,
              webBgColor: "#00b09b",
              webPosition: "center",
              );
          }
          else{
            Fluttertoast.showToast(
              msg: "登入失敗",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black45,
              textColor: Colors.white,
              fontSize: 16.0,
              webShowClose: true,
              webBgColor: "#00b09b",
              webPosition: "center",
              );
          }
        },
        padding: EdgeInsets.all(5),
        color: lightGreen,
        child: Text("登入", style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
    );

    //registerbutton
    final registerbutton = Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () async {
          bool shouldNavigate =
              await register(_emailField.text, _passwordField.text);
          if (shouldNavigate) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
            Fluttertoast.showToast(
              msg: "註冊成功",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black45,
              textColor: Colors.white,
              fontSize: 16.0,
              webShowClose: true,
              webBgColor: "#00b09b",
              webPosition: "center",
              );
          }
          else{
            Fluttertoast.showToast(
              msg: "註冊失敗",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black45,
              textColor: Colors.white,
              fontSize: 16.0,
              webShowClose: true,
              webBgColor: "#00b09b",
              webPosition: "center",
              );
          }
        },
        padding: EdgeInsets.all(5),
        color: lightGreen,
        child: Text("註冊", style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
    );

    return Scaffold(
      backgroundColor: RiceWhite,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: 60),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Center(
                  child: Text("藥報報",
                      style: TextStyle(
                          fontSize: 30,
                          color: DarkGreen,
                          fontWeight: FontWeight.bold)),
                )),
            logo,
            SizedBox(height: 40),
            pinCode,
            password,
            loginButton,
            registerbutton
          ],
        ),
      ),
    );
  }
}
