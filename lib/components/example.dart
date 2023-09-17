import 'package:flutter/material.dart';

class Nio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
          child: Container(
        height: 200,
        child: GridView.count(
          scrollDirection: Axis.horizontal,
          crossAxisCount: 1,
          children: List.generate(50, (index) {
            return Container(
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Expanded(
                      child: Container(
                    color: Colors.yellowAccent,
                  )),
                  Expanded(
                    child: Container(
                      width: 50,
                      height: 100,
                      color: Colors.blue,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 50,
                      height: 100,
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 100,
                    color: Colors.red,
                  ),
                  Container(
                    width: 50,
                    height: 100,
                    color: Colors.yellowAccent,
                  ),
                  Container(
                    width: 50,
                    height: 100,
                    color: Colors.blue,
                  ),
                  Container(
                    width: 50,
                    height: 100,
                    color: Colors.green,
                  ),
                  Container(
                    width: 50,
                    height: 100,
                    color: Colors.red,
                  )
                ],
              ),
              color: Colors.amber,
            );
          }),
        ),
      )),
    );
  }
}
