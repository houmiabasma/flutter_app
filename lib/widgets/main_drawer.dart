import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Drawer(
            child: ListView(
                children: <Widget>[
                    DrawerHeader(
                        child: Center(

                            child: SingleChildScrollView(
                  child: Column(children: [
                    Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage('images/anonymous.jpg'),
                        )),
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Anonymous",
                          style: TextStyle(fontSize: 16),
                        )),
                  ]),
                ),

                        ),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [Colors.orange[500],Colors.amberAccent])
                        ),
                    ),
                    ListTile(
                        leading: Icon(Icons.home),
                        title: Text("Home",style: TextStyle(fontSize: 15),),
                        onTap: (){
                             Navigator.pushNamed(context, '/');
                         
                        },),
                    Divider(color: Colors.deepOrangeAccent,),
                    ListTile(
                        leading: Icon(Icons.cloud),
                        title: Text("weather",style: TextStyle(fontSize: 15),),
                        onTap: (){
                           
                            Navigator.pushNamed(context, '/weather');
                        },),
                    Divider(color: Colors.deepOrangeAccent,),
                    ListTile(
                        leading: Icon(Icons.bluetooth),
                        title: Text("bluetooth",style: TextStyle(fontSize: 15),),
                        onTap: (){
                           Navigator.pushNamed(context, '/discovery');
                        },),
                    
                   
                ],
            ),
        );
    }
}