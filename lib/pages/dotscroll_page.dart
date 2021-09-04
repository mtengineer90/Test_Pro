import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:testpro/widgets/dots_decorator.dart';
import 'package:testpro/widgets/dots_indicator.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'welcome_page.dart';
class DotScrollPage extends StatefulWidget {
  static String tag = '/DotScrollPage';

  @override
  DotScrollPageState createState() => DotScrollPageState();
}
int age=0;
int length=0;
int weight=0;
String gender='';

class DotScrollPageState extends State<DotScrollPage> {
  int currentIndexPage = 0;
  int pageLength;

  var titles = [
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.This is simply text ",
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.This is simply text  ",
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.This is simply text  ",
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.This is simply text  ",
  ];

  @override
  void initState() {
    super.initState();
    currentIndexPage = 0;
    pageLength = 4;
  }

int age2=age;
int length2=length;
int weight2=weight;
String gender='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(

        leading: BackButton(
            color: Colors.blueGrey,
            onPressed: () => Navigator.pop(context)),
        backgroundColor: Colors.white,
        elevation: 2,
        automaticallyImplyLeading: false,
        title: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(

            ),
            Padding(
              padding: EdgeInsets.only(top: 7),
              child: Container(
                height: 100,
                width: ((((MediaQuery.of(context).size.width) * (2 / 3)) - 24) /
                        3) -
                    5,
                decoration: BoxDecoration(
                  //color: Colors.red[200],
                  image: DecorationImage(
                    image: ExactAssetImage('assets/img/logo.jpg'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            SizedBox(width: 40),
          ],
        ),),
        body: SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
              )),
          Container(
            margin: EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: PageView(
              children: <Widget>[
                WalkThrough(textContent: "What is your sex?", title: "gender"),
                WalkThrough(textContent: "How old are you?", title: "age"),
                WalkThrough(
                    textContent: "How much is your length?", title: "length"),
                WalkThrough(
                    textContent: "How much is your weight?", title: "weight"),
              ],
              onPageChanged: (value) {
                setState(() => currentIndexPage = value);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Align(
                  child: new DotsIndicator(
                      dotsCount: pageLength,
                      position: currentIndexPage,
                      decorator: DotsDecorator(
                        color: Color(0XFFDADADA),
                        activeColor: Color(0XFF313384),
                      )),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(4)),
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  margin: const EdgeInsets.only(left: 8, top: 2, right: 8),
                  width: double.infinity,
                  //padding: EdgeInsets.only(bottom: 8),
                  child: RaisedButton(
                                      shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                    onPressed: () {

                                  FirebaseFirestore.instance
                .collection('data')
                .add(<String, dynamic>{
                  'age': age2,
                  'sex': gender,
                  'length': length2,
                  'weight': weight2,
                  
                  });

                                        Navigator.push(
                              context,
                              MaterialPageRoute<void>(builder: (context) => Welcome()),
                            );

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    color: Colors.blueGrey,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}

void saveAge(int agevar){
age=agevar;
}
void saveLength(int lengthvar){
length=lengthvar;
}
void saveWeight(int weightvar){
weight=weightvar;
}
void saveSex(bool isGenderMalevar){
gender = isGenderMalevar ? 'male' : 'female';
}

class WalkThrough extends StatefulWidget {
  final String textContent;
  final String title;

  WalkThrough({Key key, @required this.textContent, @required this.title})
      : super(key: key);

  @override
  _WalkThroughState createState() => _WalkThroughState();
}

class _WalkThroughState extends State<WalkThrough> {
  int currentAge = 18;
  int currentLength = 180;
  int currentWeight = 80;
  bool isGenderMale = false;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;

    if (widget.title == "gender") {
      return Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            SizedBox(
                height: MediaQuery.of(context).size.height/8),

            Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              child: Center(
                  child: Text(
                widget.textContent,
                style: TextStyle(fontSize: 18.0, color: Color(0XFF747474)),
                textAlign: TextAlign.center,
              )),
            ),
            SizedBox(
              height: h * 0.08,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isGenderMale = false;
                                                saveSex(isGenderMale);

                      });
                    },
                    child: Material(
                      elevation: 6,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.width / 2.5,
                        //color: Colors.white,
                        child: Icon(
                          FontAwesomeIcons.venus,
                          size: 88,
                          color: isGenderMale ? Colors.grey : Colors.red,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isGenderMale = true;
                        saveSex(isGenderMale);
                      });
                    },
                    child: Material(
                      elevation: 6,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.width / 2.5,
                        //color: Colors.white,
                        child: Icon(
                          FontAwesomeIcons.mars,
                          size: 88,
                          color: isGenderMale ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ),
                  )
                ])
          ],
        ),
      );
    } else if (widget.title == "age") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height/8),
              Container(
              //margin: EdgeInsets.only(left: 30, right: 30),
              child: Center(
                  child: Text(
                widget.textContent,
                style: TextStyle(fontSize: 18.0, color: Color(0XFF747474)),
                textAlign: TextAlign.center,
              )),
            ),
              SizedBox(
                height: h * 0.19,
              ),
              NumberPicker(
                haptics: true,
                value: currentAge,
                minValue: 14,
                maxValue: 120,
                onChanged: (value) => setState(() {
          currentAge = value;
          saveAge(currentAge);
                } ),
              ),
             // Text('Current value: $currentAge'),
            ],
          ),
        ],
      );
    } else if (widget.title == "length") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: <Widget>[
                SizedBox(
                height: MediaQuery.of(context).size.height/8),
              Container(
              //margin: EdgeInsets.only(left: 30, right: 30),
              child: Center(
                  child: Text(
                widget.textContent,
                style: TextStyle(fontSize: 18.0, color: Color(0XFF747474)),
                textAlign: TextAlign.center,
              )),
            ),
              SizedBox(
                height: h * 0.19,
              ),
              NumberPicker(
                value: currentLength,
                minValue: 80,
                maxValue: 250,
                onChanged: (value) => setState(() {
currentLength = value;
saveLength(currentLength);
                } ),
              ),
             // Text('Current value: $currentLength'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("cm"),
          )
        ],
      );
    } else if (widget.title == "weight") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height/8),
              Container(
              //margin: EdgeInsets.only(left: 30, right: 30),
              child: Center(
                  child: Text(
                widget.textContent,
                style: TextStyle(fontSize: 18.0, color: Color(0XFF747474)),
                textAlign: TextAlign.center,
              )),
            ),
              SizedBox(
                height: h * 0.19,
              ),
              NumberPicker(
                value: currentWeight,
                minValue: 40,
                maxValue: 250,
                onChanged: (value) => setState(() {
currentWeight = value;
saveWeight(currentWeight);
                } ),
              ),
              //Center(child: Text('Current value: $currentWeight')),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("kg"),
            ),
          )
        ],
      );
    }
/*     return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topCenter,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
          ),
          SizedBox(
            height: h * 0.08,
          ),
          Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Center(
                child: Text(
              widget.title,
              style: TextStyle(fontSize: 18.0, color: Color(0XFF747474)),
              textAlign: TextAlign.center,
            )),
          ),
        ],
      ),
    ); */
  }
}
