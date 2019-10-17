import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'User.dart';

class Photos extends StatefulWidget {
  @override
  PhotosState createState() => PhotosState();
}

class PhotosState extends State<Photos> {
  Future<List<User>> getUsers() async {
    var data = await http.get('https://jsonplaceholder.typicode.com/photos');

    var jsonData = json.decode(data.body);

    List<User> users = [];

    for (var u in jsonData) {
      User user = User(u['id'], u['title'], u['url'], u['thumbnailUrl'], u['body']);

      users.add(user);
    }

    print(users.length);

    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text('Loading...'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    showDialog(
                                    context: context,
                                    builder: (builder){
                                      return Center(
                                       child: Material(
                                            child: Container(
                                         
                                          decoration: BoxDecoration(
                                            border: Border.all(color:Colors.black),
                                          ),
                                          child:Center(
                                            child:  PhotoView(
                                              imageProvider: NetworkImage(snapshot.data[index].url,),
                                              minScale: PhotoViewComputedScale.contained * 0.8,

                                              maxScale: PhotoViewComputedScale.covered * 2,

                                              loadingChild: Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                            ),
                                            
                                            
                                            
                                            
                                            
                                          ),
                                            

                                            
                                          
                                        
                                          
                                        ),
                                                                        ),
                                      );
                                    }
                                  );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2.5,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        elevation: 3.0,
                        child: Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 3.5,
                                  width: MediaQuery.of(context).size.width,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    child: Image.network(
                                      snapshot.data[index].thumbnailUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 6.0,
                                  right: 6.0,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0)),
                                    child: Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.star,
                                            size: 10,
                                          ),
                                          Text(
                                            '',
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 6.0,
                                  left: 6.0,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(3.0)),
                                    child: Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Text(
                                        " OPEN ",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 7.0),
                            Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: RichText(
                                    text: TextSpan(
                                        // set the default style for the children TextSpans
                                        style: Theme.of(context)
                                            .textTheme
                                            .body1
                                            .copyWith(fontSize: 20),
                                        children: [
                                      TextSpan(
                                          text: snapshot.data[index].title,
                                          style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold)),
                                    ])),
                              ),
                            ),
                            SizedBox(height: 7.0),
                            Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: RichText(
                                    text: TextSpan(
                                        // set the default style for the children TextSpans
                                        style: Theme.of(context)
                                            .textTheme
                                            .body1
                                            .copyWith(fontSize: 20),
                                        children: [
                                      TextSpan(
                                        text: 'des',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ])),
                              ),
                            ),
                            SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
