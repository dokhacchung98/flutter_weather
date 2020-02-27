import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splash_screen.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              height: 86,
            ),
            Expanded(
              child: Text(
                'Weather App',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w700),
              ),
            ),
            FlatButton(
              onPressed: () {
                exit(0);
              },
              child: Text(
                'Thoát',
                style: TextStyle(
                    color: Colors.white.withOpacity(.6), fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
