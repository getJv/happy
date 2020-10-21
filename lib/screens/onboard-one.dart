import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:happy/utils/routes.dart';

class OnboardOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(237, 255, 246, 1),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Container(
              child: Image(
                image: AssetImage('assets/images/planet/planet.png'),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: Text(
                'Leve felicidade para o mundo',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 48,
                  color: Color.fromRGBO(0, 137, 165, 1),
                  fontFamily: 'Nunito-ExtraBold',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: Text(
                'Visite orfanatos e mude o dia de muitas crianças.',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(92, 133, 153, 1),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.ONBORARD_TWO);
        },
        child: Icon(Icons.navigate_next),
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }
}
