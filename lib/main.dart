import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'pages/name_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test Pro',
      home: LoginPage(),
      //home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var authAnonymous = FirebaseAuth.instance;


  void _signInWithAnonymous() async {
    final userCredentialAnonymous = await authAnonymous.signInAnonymously();
    var userAnonymous = userCredentialAnonymous.user;

    print(userAnonymous);
                    if (authAnonymous.currentUser != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(builder: (context) => NamePage()),
                  );
                }
    setState(() {});
  }


  var authGoogle = FirebaseAuth.instance;
  void _signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final userCredentialGoogle = await authGoogle.signInWithCredential(credential);
    var userGoogle = userCredentialGoogle.user;
    print(userGoogle);

                var route = MaterialPageRoute<void>(builder: (context) => NamePage());
                Navigator.push<void>(context, route);
    setState(() {
      // reload build for login check
    });
  }


  var authFacebook = FirebaseAuth.instance;
  void _signInWithFacebook() async {
    print('_signInWithFacebook');
    final result = await FacebookAuth.instance.login();
    final accessToken = result.accessToken;
    final credential = FacebookAuthProvider.credential(accessToken.token);
    final userCredentialFacebook = await authFacebook.signInWithCredential(credential);
    var userFacebook = userCredentialFacebook.user;

    print(userFacebook);
                    var route = MaterialPageRoute<void>(builder: (context) => NamePage());
                Navigator.push<void>(context, route);
    setState(() {
      // reload build for login check
    });
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Test Pro"),
      ),
      body: Container(
        color: Colors.black87,
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            SizedBox(height: 20),
            SignInButton(
              Buttons.Email,
              padding: EdgeInsets.all(15),
              onPressed: () {
                var route = MaterialPageRoute<void>(builder: (context) => LoginPage());
                Navigator.push<void>(context, route);
              },
            ),
            SizedBox(height: 20),
            SignInButton(
              Buttons.Google,
              padding: EdgeInsets.all(8),
              onPressed: () {
                  _signInWithGoogle();
              },
            ),
            SizedBox(height: 20),
            SignInButton(
              Buttons.Facebook,
              padding: EdgeInsets.all(15),
              onPressed: () {
_signInWithFacebook();
              },
            ),
            SizedBox(height: 20),
            SignInButtonBuilder(
              text: 'Anonymous',
              icon: Icons.ac_unit,
              padding: EdgeInsets.all(15),
              onPressed: () {
                _signInWithAnonymous();

              },
              backgroundColor: Colors.blueGrey,
            ),
          ],
        ),
      ),
    );
  }
}
