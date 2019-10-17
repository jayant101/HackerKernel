import 'package:flutter/material.dart';
import 'package:hackerkernel/User.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Posts extends StatefulWidget {
  @override
  PostsState createState() => PostsState();
}

class PostsState extends State<Posts> {
  Future<List<User>> getUsers() async {
    var data = await http.get('https://jsonplaceholder.typicode.com/posts');

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
                return Card(
                   elevation: 5.0,           
                   child: ExpansionTile(
                     leading: Icon(Icons.toc),
                    title: Text(snapshot.data[index].title),
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(10.0),                    
                          child: Container(
                          child: Text(snapshot.data[index].body,textDirection: TextDirection.ltr,style: TextStyle(color: Colors.grey[400]),),
                        ),
                      )
                    ],
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
