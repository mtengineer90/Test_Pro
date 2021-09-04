import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'dotscroll_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NamePage extends StatefulWidget {

  @override
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {

    TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 13.0);
    TextStyle linkStyle = TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize:13.0);

  var auth = FirebaseAuth.instance;
  User user;
  bool _isSignOut = false;

  String name='';

  void _signOut() async {
    await auth.signOut().then((value) {
      setState(() {
        _isSignOut = true;
      });
    });
  }

  String _result() {
    if (user.isAnonymous) {
      return 'UID: ' + user.uid;
    } else if (user.providerData[0].providerId == 'password') {
      return user.email;
    } else if (user.providerData[0].providerId == 'phone') {
      return user.phoneNumber;
    } else {
      return user.displayName;
    }
  }



  @override
  void initState() {
    user = auth.currentUser;
    super.initState();
  }

  @override
  void dispose() {
    //Navigator.pop(context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  //notifyMe = getNotificationsPost();
  //getNotificationsPost();
  //WidgetsFlutterBinding.ensureInitialized();
      if (_isSignOut) return MyApp();

    return Scaffold(
      //appBar: appbar_widget(context, "", true, false, false,isBackButton2: true),
      
      appBar: AppBar(

        leading: BackButton(
            color: Colors.blueGrey,
            onPressed: () => Navigator.pop(context)),
        backgroundColor: Colors.white,
        elevation: 2,
        automaticallyImplyLeading: false,
        title: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Padding(
              padding: EdgeInsets.only(top: 7),

            ),
            SizedBox(width: 40),
          ],
        ),),

      body:  Padding(
        padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 2.0),
          child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 8),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height:MediaQuery.of(context).size.height/5,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10.0,10.0,10.0,40.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Your Name?",
                    style: TextStyle(//fontWeight: FontWeight.bold,
                     fontSize: 28),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0,10.0,10.0,50.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: TextFormField(
                        onChanged: (value) => name = value,

                      decoration: new InputDecoration(
                        hintText: 'Your Name',
                        isDense: true,
                        //fillColor: Colors.white,
/*                         border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(4),
                          borderSide: new BorderSide(
                          //  color: HexColor("#DEDEDF"),
                          ),
                        ), */
                        border:InputBorder.none
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height:MediaQuery.of(context).size.height/7,
                  ),


                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    margin: const EdgeInsets.only(left: 8, top: 2, right: 8),
                  width: double.infinity,
                  //padding: EdgeInsets.only(bottom: 8),
                  child: RaisedButton(
                             shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),),
                    onPressed: () {
                                  FirebaseFirestore.instance
                .collection('data')
                .add(<String, dynamic>{'name': name});
                
                      Navigator.push(
                              context,
                              MaterialPageRoute<void>(builder: (context) => DotScrollPage()),
                            );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Continue",
                        style: TextStyle(color: Colors.white, ),
                      ),
                    ),
                    color: Colors.blueGrey,
                  ),
                )
              ],
            ),
          ),
        ),
      ),),
      

          
    );
  }
}

