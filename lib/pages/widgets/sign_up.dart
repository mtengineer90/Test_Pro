import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:testpro/widgets/snackbar.dart';

import '../name_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FocusNode focusNodePassword = FocusNode();
  final FocusNode focusNodeConfirmPassword = FocusNode();
  final FocusNode focusNodeEmail = FocusNode();

  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupConfirmPasswordController =
      TextEditingController();

    TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 13.0);
    TextStyle linkStyle = TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize:13.0);

  var authEmailandPassword = FirebaseAuth.instance;
  String _email = '', _password = '';
  String _error;

  void _create() async {
    try {
      await authEmailandPassword.createUserWithEmailAndPassword(
          email: _email, password: _password);
      Route route = MaterialPageRoute<void>(builder: (context) => NamePage());
      Navigator.push<void>(context, route);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setState(() {
          _error = 'The password provided is too weak.';
        });
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          _error = 'The account already exists for that email.';
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }

  @override
  void dispose() {
    focusNodePassword.dispose();
    focusNodeConfirmPassword.dispose();
    focusNodeEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

return SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 8),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20.0, bottom: 4),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: TextFormField(
                                        onChanged: (value) => _email = value,
                      keyboardType: TextInputType.emailAddress,
                    decoration: new InputDecoration(
                      hintText: '',
                      isDense: true,
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(4),
                        borderSide: new BorderSide(
                        //  color: HexColor("#DEDEDF"),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 18),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Create Password",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: TextFormField(
                                                      onChanged: (value) => _password = value,
                    keyboardType: TextInputType.text,
           
                    decoration: new InputDecoration(
                      hintText: "",
                      isDense: true,
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(4),
                        borderSide: new BorderSide(
                        //  color: HexColor("#DEDEDF"),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Boş geçilemez!';
                      }
                      return null;
                    },
                    onSaved: (e) {},
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Re-write Password",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )),
                SizedBox(
                  height: 8,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      hintText: "",
                      isDense: true,
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(4),
                        borderSide: new BorderSide(
                         // color: HexColor("#DEDEDF"),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Boş geçilemez!';
                      }
                      else if(value != _password){
                        return 'Şifre eşleşmiyor';
                      }
                      return null;
                    },
                    onSaved: (e) {},
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
   SizedBox(
                  height: 8,
                ),
                    //color: HexColor("#FAB23E"),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25.0,10.0,25.0,10.0),
                          child: Center(
                            child: RichText(textAlign: TextAlign.center,
      text: TextSpan(
                            style: defaultStyle,
                            children: <TextSpan>[
                                  TextSpan(text: 'By clicking Continue button'),
                                  TextSpan(
                                      text: ' Terms of Use and Privacy Notice',
                                      style: linkStyle,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          print('Üyelik ve Gizlilik Sözleşmesi"');

                                        }),
                                  TextSpan(text: ' will be accepted.'),

 
                            ],
      ),
    ),
                          ),
                        ),
                                        SizedBox(height: 5,),                
                  
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    margin: const EdgeInsets.only(left: 8, top: 2, right: 8),
                  width: double.infinity,
                  //padding: EdgeInsets.only(bottom: 8),
                  child: RaisedButton(
                                      shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                   
                                          onPressed: () {
                                            _create();
/*  Navigator.push(
        context,
        MaterialPageRoute<void>(builder: (context) => NamePage()),
      ); */
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Continue",
                        style: TextStyle(color: Colors.white, ),
                      ),
                    ),
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ),
      );

 }

  void _toggleSignUpButton() {
    CustomSnackBar(context, const Text('SignUp button pressed'));
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
    });
  }
}
