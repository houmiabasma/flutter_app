import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RaisedButton(
                child: Text('Weather Screen'),
                onPressed: () {
                  Navigator.pushNamed(context, '/weather');
                }),
            Padding(padding: new EdgeInsets.all(10.0)),
            RaisedButton(
                child: Text('Discovery screen'),
                onPressed: () {
                  Navigator.pushNamed(context, '/discovery');
                }),
          ],
        ),
      ),
    );
  }
}
