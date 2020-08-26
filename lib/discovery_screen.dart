import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:badges/badges.dart';

class DiscoveryPage extends StatefulWidget {
  /// If true, discovery starts on page start, otherwise user must press action button.
  final bool start;

  const DiscoveryPage({this.start = true});

  @override
  _DiscoveryPage createState() => new _DiscoveryPage();
}

class _DiscoveryPage extends State<DiscoveryPage> {
  /*var counterStream =
      Stream<int>.periodic(Duration(seconds: 60), (x) => x).take(15);*/
  Timer _timer;
  StreamSubscription<BluetoothDiscoveryResult> _streamSubscription;
  List<BluetoothDiscoveryResult> results = List<BluetoothDiscoveryResult>();
  bool isDiscovering;

  _DiscoveryPage();

  @override
  void initState() {
    super.initState();
    isDiscovering = widget.start;

    if (isDiscovering) {
      _startDiscovery();
    }
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      _restartDiscovery();
    });
  }

  void _restartDiscovery() {
    setState(() {
      results.clear();
      isDiscovering = true;
    });

    _startDiscovery();
  }

  _startDiscovery() {
    _streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        bool exist = checkIfExist(
            (element) => element.device.address == r.device.address);
        if (exist) {
          results.add(r);
        }
      });
    });
    _streamSubscription.onDone(() {
      setState(() {
        isDiscovering = false;
      });
    });
  }

  bool checkIfExist(bool test(BluetoothDiscoveryResult element)) {
    for (BluetoothDiscoveryResult element in results) {
      if (test(element)) return false;
    }
    return true;
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and cancel discovery
    _streamSubscription?.cancel();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
         title: Text(
          "Detection par bluetooth",
        ),
      ),
      body: isDiscovering
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Détecter ",
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 25),
                ),
                Padding(padding: new EdgeInsets.all(10.0)),
                Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                )),
              ],
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Badge(
                    badgeColor: Colors.black,
                    shape: BadgeShape.circle,
                    borderRadius: 20,
                    badgeContent: Text(
                      results.length.toString(),
                      style: new TextStyle(fontSize: 100, color: Colors.white),
                    ),
                    child: Icon(
                      Icons.person,
                      color: Colors.orangeAccent,
                      size: 200,
                    ),
                  ),
                  Text(
                    "Les gens près de chez vous ",
                    style: TextStyle(fontWeight: FontWeight.w200, fontSize: 25),
                  ),
                ],
              ),
            ),
    );
    /*ValueTile("Les gens près de chez vous", results.length.toString(),
        iconData: IconData(59475, fontFamily: 'MaterialIcons'));*/
    /*Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Icon(Icons.person),
          Text(
            ": " + ,
            style: TextStyle(fontWeight: FontWeight.w200, fontSize: 25),
          ),
        ]));*/
  }
}
