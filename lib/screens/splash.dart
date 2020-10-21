import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:happy/utils/routes.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(21, 195, 214, 1), //
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Container(
              child: Image(
                image: AssetImage('assets/images/logo/logotipo.png'),
              ),
            ),
            Spacer(),
            Container(
              child: Text(
                'Brasília',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Nunito-ExtraBold',
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: Text(
                'Distrito Federal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.ONBORARD_ONE);
        },
        child: Icon(Icons.navigate_next),
        backgroundColor: Theme.of(context).accentColor,
      ),
    );
  }
}
