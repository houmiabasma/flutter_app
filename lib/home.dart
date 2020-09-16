import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_app/widgets/main_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bluetooth_app/widgets/value_tile.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  QuerySnapshot querySnapshot;

  @override
  void initState() {
    super.initState();
    getDataList().then((lists) {
      setState(() {
        querySnapshot = lists;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange[500],
        title: Text("Home"),
        actions: [],
      ),
      drawer: MainDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: showData(),
      ),
    );
  }

  Widget showData() {
    if (querySnapshot != null) {
      return ListView.builder(
        itemCount: querySnapshot.docs.length,
        primary: false,
        padding: EdgeInsets.only(top: 5, bottom: 10),
        itemBuilder: (context, i) {
          return Column(children: [
            Card(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage("images/process.png"),
                          radius: 35,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "System",
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            AutoSizeText(
                              querySnapshot.docs[i].data()['location'] != null
                                  ? querySnapshot.docs[i]
                                      .data()['location']
                                      .toString()
                                  : "Location Undefined",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            AutoSizeText(
                              querySnapshot.docs[i].data()['date'] != null
                                  ? DateFormat("EEEE H:mm a").format(
                                      querySnapshot.docs[i]
                                          .data()['date']
                                          .toDate())
                                  : ' ',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Center(
                        child: Text(
                      querySnapshot.docs[i].data()['commentaire'] != null
                          ? querySnapshot.docs[i].data()['commentaire']
                          : '',
                      style: TextStyle(fontSize: 22),
                    )),
                    SizedBox(
                      height: 8,
                    ),
                    querySnapshot.docs[i].data()['weather'] != null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      ValueTile(
                                          "temperature",
                                          querySnapshot.docs[i]
                                              .data()['weather']['temperature']
                                              .toString()),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Center(
                                            child: Container(
                                          width: 1,
                                          height: 30,
                                        )),
                                      ),
                                      ValueTile(
                                          "wind speed",
                                          querySnapshot.docs[i]
                                              .data()['weather']['windSpeed']),
                                    ]),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: Center(
                                      child: Container(
                                    width: 1,
                                    height: 15,
                                  )),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      ValueTile(
                                          "sunrise",
                                          querySnapshot.docs[i]
                                              .data()['weather']['sunrise']),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Center(
                                            child: Container(
                                          width: 1,
                                          height: 30,
                                        )),
                                      ),
                                      ValueTile(
                                          "sunset",
                                          querySnapshot.docs[i]
                                              .data()['weather']['sunset']),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Center(
                                            child: Container(
                                          width: 1,
                                          height: 30,
                                        )),
                                      ),
                                      ValueTile(
                                          "humidity",
                                          querySnapshot.docs[i]
                                              .data()['weather']['humidity']),
                                    ])
                              ])
                        : Container(),
                    querySnapshot.docs[i].data()['discovery'] != null
                        ? Center(
                            child: ValueTile(
                                '${querySnapshot.docs[i].data()['discovery']['nearby']}',
                                ''),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Divider(
              color: Colors.white,
            ),
            SizedBox(
              height: 5,
            ),
          ]);
        },
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  getDataList() async {
    return await FirebaseFirestore.instance.collection('crowdSensing').get();
  }
}
