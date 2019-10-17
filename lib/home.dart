import 'package:flutter/material.dart';
import 'package:hackerkernel/photos.dart';
import 'package:hackerkernel/posts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class Home extends StatefulWidget{
  @override 
  HomeState createState() => HomeState();
}

class HomeState extends State<Home>{

  final tab = [
    Photos(),
    Posts()
  ];
   
  int currentTabIndex = 0; 
  onTapped(int index){
    setState(() {

     currentTabIndex = index; 
    });

  }


  @override 
  Widget build(BuildContext context){
    return DefaultTabController(
      length: 2,
          child: Scaffold(
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  DrawerHeader(
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: CircleAvatar(
                            radius: 25.0,
                            child: Icon(Icons.account_circle),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.account_box),
                          title: Text('jayant'),
                        )
                      ],
                    )
                  ),
                  InkWell(
                    onTap: ()async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('email');
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext ctx) => Login()));
          },
                                      child: ListTile(
                      leading: Icon(Icons.assessment),
                      title: Text('Logout'),
                    ),
                  )
                ],
              ),
            ),
        body: tab[currentTabIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTapped,
          currentIndex: currentTabIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.image,color: Colors.black,),
              title: Text('Photos',style: TextStyle(color: Colors.grey[400],fontSize: 12.0),),
     
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.cloud_circle,color: Colors.black,),
              title: Text('Post',style: TextStyle(color: Colors.grey[400],fontSize: 12.0),),
             
              
            ),
          ],
        ),
      ),
    );
  }
}