import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginActivity extends StatefulWidget {
  const LoginActivity({Key? key}) : super(key: key);

  @override
  State<LoginActivity> createState() => _LoginActivityState();
}

class _LoginActivityState extends State<LoginActivity> {
  Widget uiScreen(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
              Image.asset("images/logo.png"),
              Container(
                margin: EdgeInsets.only(left: 30,right: 30,top: 30),
               decoration: BoxDecoration(
                 border: Border.all(color: Colors.blue),
                 borderRadius: BorderRadius.all(Radius.circular(20))
               ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none
                        ,prefixIcon: Icon(Icons.person),
                    hintText: "Registered Email ID"
                  ),
                ),
              ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 30,right: 30,top: 20),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none
                  ,prefixIcon: Icon(Icons.lock),
                  hintText: "Password"
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: 30,right: 30,top: 60),
            width: MediaQuery.of(context).size.width,
            child: TextButton(
                child: Text(
                    "Login".toUpperCase(),
                    style: TextStyle(fontSize: 14)
                ),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(

                        RoundedRectangleBorder(

                            borderRadius: BorderRadius.circular(18.0),
                           // side: BorderSide(color: Colors.red)

                        )
                    )
                ),
                onPressed: () => Navigator.of(context).pushNamed("/home_page")
            ),
          ),
        ],
      ),
    );
    // return Container(
    //     width: double.maxFinite,
    //     height: double.maxFinite,
    //     decoration: BoxDecoration(
    //       gradient: LinearGradient(
    //         colors: [Colors.green, Color.fromARGB(255, 29, 221, 163)],
    //       ),
    //     ),
    //     child: Center(child: Text('GeeksforGeeks')));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: uiScreen(),
      ),
    );
  }
}
