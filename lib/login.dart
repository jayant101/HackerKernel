import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackerkernel/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> signIn(String emails, String passwords) async {
    final FirebaseUser user = await _auth.signInWithEmailAndPassword(
        email: emails, password: passwords);
    print(user.uid);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 100.0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
              child: Image.network(
                'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/c666b80b-e331-410d-b773-b82873b15a7f/dcjhmlz-4076f330-9f51-4ae9-9c93-ca61a801a964.png/v1/fill/w_1024,h_780,strp/waterfall_at_night__flat_design__updated__by_heather_42_dcjhmlz-fullview.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9NzgwIiwicGF0aCI6IlwvZlwvYzY2NmI4MGItZTMzMS00MTBkLWI3NzMtYjgyODczYjE1YTdmXC9kY2pobWx6LTQwNzZmMzMwLTlmNTEtNGFlOS05YzkzLWNhNjFhODAxYTk2NC5wbmciLCJ3aWR0aCI6Ijw9MTAyNCJ9XV0sImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl19._nrzHOnGNu_0DInjHrosy7mJdxl79JHbjaAne89UTgM',
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView(
            children: <Widget>[
              Text(
                '  LogIn',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange),
              ),
              SizedBox(height: MediaQuery.of(context).size.height - 450.0),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  height: 200.0,
                  width: 200.0,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30.0,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.mail_outline,
                          color: Colors.black,
                          size: 27.0,
                        ),
                        title: TextField(
                          controller: loginEmailController,
                          decoration: InputDecoration(
                            hintText: 'Enter Email',
                            hintStyle: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.lock,
                          color: Colors.black,
                          size: 27.0,
                        ),
                        title: TextField(
                          controller: loginPasswordController,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontWeight: FontWeight.bold),
                              hintText: 'Enter Password'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 55.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    onTap: () async {

                    //after the login REST api call && response code ==200
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('email', loginEmailController.text);
           







                      signIn(loginEmailController.text,
                              loginPasswordController.text)
                          .then((FirebaseUser user) {
                        Navigator.of(context).pushReplacement(
                            new MaterialPageRoute(
                                settings: RouteSettings(name: 'homepage'),
                                builder: (context) => new Home()));
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Container(
                        height: 60.0,
                        width: 60.0,
                        child: Icon(Icons.arrow_forward, color: Colors.red),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50.0)
                            ),
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
