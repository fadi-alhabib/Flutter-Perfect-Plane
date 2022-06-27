import 'package:fluppy_bird/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _showDialog() {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.green,
              title: Center(
                child: Text(
                  "Difficulty",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              actionsPadding: EdgeInsets.all(20),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomePage(
                              gameSpeed: 0.05,
                            )));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding: EdgeInsets.all(7),
                      color: Colors.grey.shade800,
                      child: Text(
                        "Pussy",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomePage(
                              gameSpeed: 0.1,
                            )));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding: EdgeInsets.all(7),
                      color: Colors.grey.shade800,
                      child: Text(
                        "Gangster",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomePage(
                              gameSpeed: 0.15,
                            )));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      padding: EdgeInsets.all(7),
                      color: Colors.grey.shade800,
                      child: Text(
                        "Thug",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            );
          });
    }

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Center(
          child: Text(
            "Thug Bird",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: ElevatedButton(
              onPressed: () {
                _showDialog();
              },
              child: Text("Play"),
              style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.all(10),
                  textStyle:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  fixedSize: Size(MediaQuery.of(context).size.width, 80))),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: ElevatedButton(
              onPressed: () {},
              child: Text("Settings"),
              style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.all(10),
                  textStyle:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  fixedSize: Size(MediaQuery.of(context).size.width, 80))),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: ElevatedButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: Text("Exit"),
              style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.all(10),
                  textStyle:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  fixedSize: Size(MediaQuery.of(context).size.width, 80))),
        )
      ]),
    );
  }
}
