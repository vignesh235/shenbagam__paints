import 'dart:async';

import 'dart:math';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:share/share.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shenbagam_paints/Pages/bank_details.dart';
import 'package:shenbagam_paints/db/database_helper.dart';
import 'package:shenbagam_paints/Pages/edit_profile.dart';
import 'package:shenbagam_paints/db/model/data.dart';
import 'package:shenbagam_paints/Pages/qr_page.dart';

import 'package:shenbagam_paints/animation/fadeanimation.dart';

import 'package:shenbagam_paints/Pages/login_form.dart';

class profile extends StatefulWidget {
  static const String routeName = "/profile";

  @override
  profileValidationState createState() => profileValidationState();
}

class profileValidationState extends State<profile> {
  late List<Note> details;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    refreshNote();
  }

  Future refreshNote() async {
    this.details = await NotesDatabase.instance.readAllNotes();

    get_profile(details[details.length - 1].api_key,
        details[details.length - 1].api_secret);
  }

  Map Mapresponse = {};
  Map Mapresponse_ = {};
  Map profileres = {};
  String dataResponse = '';

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool _hasBeenPressed = true;
  bool form_active = true;
  bool form_active1 = true;

  get prefixIcon => null;

  TextEditingController Mobilenum = TextEditingController();
  TextEditingController username_ = TextEditingController();
  TextEditingController feed = TextEditingController();

  String _content = '';
  String name = '';
  String city = '';
  String district = '';
  String pincode = '';

  String name1 = '';
  String city1 = '';
  String district1 = '';
  String pincode1 = '';

  void _shareContent() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            content: Form(
              // autovalidate: true,
              key: formkey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: !form_active
                        ? TextFormField(
                            enabled: false,
                            controller: Mobilenum,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                prefixIcon: prefixIcon ?? Icon(Icons.phone),
                                border: UnderlineInputBorder(),
                                contentPadding: EdgeInsets.all(16),
                                labelText: 'Mobile Number',
                                hintText: 'Enter your Mobile Number'),
                            validator: MultiValidator([
                              RequiredValidator(errorText: "* Required"),
                              MinLengthValidator(10,
                                  errorText:
                                      "Mobile Number should be 10 characters"),
                            ]))
                        : TextFormField(
                            controller: Mobilenum,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                prefixIcon: prefixIcon ?? Icon(Icons.phone),
                                border: UnderlineInputBorder(),
                                contentPadding: EdgeInsets.all(16),
                                labelText: 'Mobile Number',
                                hintText: 'Enter your Mobile Number'),
                            validator: MultiValidator([
                              RequiredValidator(errorText: "* Required"),
                              MinLengthValidator(10,
                                  errorText:
                                      "Mobile Number should be 10 characters"),
                            ])),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: !form_active
                        ? TextFormField(
                            enabled: false,
                            controller: username_,
                            decoration: InputDecoration(
                                prefixIcon: prefixIcon ?? Icon(Icons.person),
                                border: UnderlineInputBorder(),
                                contentPadding: EdgeInsets.all(16),
                                labelText: 'Name',
                                hintText: 'Enter your Name'),
                            validator: MultiValidator([
                              RequiredValidator(errorText: "* Required"),
                              MinLengthValidator(4,
                                  errorText:
                                      "Username should be atleast 4 characters"),
                            ]))
                        : TextFormField(
                            controller: username_,
                            decoration: InputDecoration(
                                prefixIcon: prefixIcon ?? Icon(Icons.person),
                                border: UnderlineInputBorder(),
                                contentPadding: EdgeInsets.all(16),
                                labelText: 'Name',
                                hintText: 'Enter your Name'),
                            validator: MultiValidator([
                              RequiredValidator(errorText: "* Required"),
                              MinLengthValidator(4,
                                  errorText:
                                      "Username should be atleast 4 characters"),
                            ])),
                  ),
                ],
              ),
            ),
            actions: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        child: Text("Share"),
                        onPressed: form_active
                            ? () {
                                if (formkey.currentState!.validate()) {
                                  setState(() {
                                    form_active = false;
                                  });
                                  Share_Mob(
                                      details[details.length - 1].api_key,
                                      details[details.length - 1].api_secret,
                                      username_,
                                      Mobilenum);
                                }
                              }
                            : null),
                    ElevatedButton(
                        child: Text("CANCEL"),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Text(
                      "Profile",
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                            color: Colors.black54,
                            fontSize: 23,
                            letterSpacing: .5),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(edit.routeName)
                          .then((result) async {
                        print(result);
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width / 8, 0, 0, 0),
                          child: Icon(Icons.edit),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text("Edit"),
                        ),
                      ],
                    ),
                  ),
                ]),
            SizedBox(
              height: 25,
            ),
            
              Container(
                child: 
                
                  Container(
                    width: double.infinity,
                    height: 100,
                    child: Container(
                      alignment: Alignment(0.0, 2.5),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage:
                            AssetImage("assets/login/usericonn.png"),
                        radius: 60.0,
                      ),
                    ),
                  ),
                ),
              
            
            SizedBox(
              height: 30,
            ),
           
          
              name1 == ''
                  ? Text(
                      name,
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.blueGrey,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w400),
                    )
                  : Text(
                      name1,
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.blueGrey,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w400),
                    ),
            
            SizedBox(
              height: 10,
            ),
           
              city1 == ''
                  ? Text(
                      city + "  ,  " + district,
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black45,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w300),
                    )
                  : Text(
                      city1 + "  ,  " + district1,
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black45,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w300),
                    ),
            
            SizedBox(
              height: 10,
            ),
            
              pincode1 == ''
                  ? Text(
                      pincode,
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black45,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w300),
                    )
                  : Text(
                      pincode1,
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black45,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w300),
                    ),
            
            SizedBox(
              height: 30,
            ),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(bank.routeName)
                          .then((result) async {
                        print(result);
                      });
                    },
                    child: Card(
                      // margin:
                      //   EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Icon(
                                  Icons.book,
                                  size: 22,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "Bank Account",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _shareContent();
                    },
                    child: Card(
                      color: Colors.white70,
                      // margin:
                      //   EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(40, 4, 40, 4),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Icon(
                                  Icons.share,
                                  size: 22,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "Share",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            
           
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(qr_page.routeName)
                          .then((result) async {
                        print(result);
                      });
                    },
                    child: Card(
                      color: Colors.white70,
                      //  margin:
                      //    EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Icon(
                                  Icons.qr_code,
                                  size: 22,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "Scan QR Code",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              scrollable: true,
                              content: Form(
                                autovalidateMode: AutovalidateMode.always,
                                key: formkey,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 20, 30),
                                      child: Text("Hi " + name + '!'),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: !form_active1
                                          ? TextFormField(
                                              controller: feed,
                                              maxLines: 2,
                                              decoration: InputDecoration(
                                                prefixIcon: prefixIcon ??
                                                    Icon(Icons.comment_bank),
                                                border: OutlineInputBorder(),
                                                contentPadding:
                                                    EdgeInsets.all(16),
                                                labelText: 'Send Feedback',
                                                hintText: 'Type Something',
                                              ),
                                              validator: MultiValidator([
                                                RequiredValidator(
                                                    errorText: "* Required"),
                                                MinLengthValidator(4,
                                                    errorText:
                                                        "Username should be atleast 4 characters"),
                                              ]))
                                          : TextFormField(
                                              controller: feed,
                                              maxLines: 2,
                                              decoration: InputDecoration(
                                                prefixIcon: prefixIcon ??
                                                    Icon(Icons.comment_bank),
                                                border: OutlineInputBorder(),
                                                contentPadding:
                                                    EdgeInsets.all(16),
                                                labelText: 'Send Feedback',
                                                hintText: 'Type Something',
                                              ),
                                              validator: MultiValidator([
                                                RequiredValidator(
                                                    errorText: "* Required"),
                                                MinLengthValidator(4,
                                                    errorText:
                                                        "Username should be atleast 4 characters"),
                                              ])),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                          child: Text("  SEND  "),
                                          onPressed: form_active1
                                              ? () {
                                                  if (formkey.currentState!
                                                      .validate()) {
                                                    setState(() {
                                                      form_active1 = false;
                                                    });
                                                    Navigator.pop(context);
                                                    feedback(
                                                        details[details.length -
                                                                1]
                                                            .api_key,
                                                        details[details.length -
                                                                1]
                                                            .api_secret,
                                                        feed);
                                                  }
                                                }
                                              : null),
                                      ElevatedButton(
                                          child: Text("  Cancel  "),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          }),
                                    ],
                                  ),
                                )
                              ],
                            );
                          });
                    },
                    child: Card(
                      // margin:
                      //   EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25, 8, 21, 8),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Icon(
                                  Icons.comment_bank,
                                  size: 22,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "Feed Back",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    ));
  }

// Share link to Mobile via Share API...(Add Referal API)...
  void Share_Mob(x, y, name, mob) async {
    var headers = {
      'Authorization': 'token ' + x.toString() + ':' + y.toString(),
      'Content-Type': "application/json",
      'Accept': "*/*",
      'Connection': "keep-alive"
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://test_senbagam.aerele.in/api/method/senbagam_api.api.add_referral'));
    request.body = json.encode({
      "args": {
        "name": name.text.toString().trim(),
        "mobile_no": mob.text.toString().trim()
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 403) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.black26,
        duration: const Duration(seconds: 6),
        content: Text(
          "Session Expired",
          style: TextStyle(color: Colors.white),
        ),
      ));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginForm()));
    }

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();

      Mapresponse = await json.decode(res);
      setState(() {
        _content = Mapresponse['message']['share'];
      });

      Navigator.pop(context);
      Share.share(_content);
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

//FeedBack Api....
  void feedback(x, y, feed) async {
    var headers = {
      'Authorization': 'token ' + x.toString() + ':' + y.toString(),
      'Content-Type': "application/json",
      'Accept': "*/*",
      'Connection': "keep-alive"
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://test_senbagam.aerele.in/api/method/senbagam_api.api.add_feedback'));
    request.body = json.encode({
      "args": {"feedback": feed.text.toString().trim()}
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 403) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.black26,
        duration: const Duration(seconds: 6),
        content: Text(
          "Session Expired",
          style: TextStyle(color: Colors.white),
        ),
      ));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginForm()));
    }

    if (response.statusCode == 200) {
      var res1 = await response.stream.bytesToString();

      Mapresponse_ = await json.decode(res1);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.black26,
        duration: const Duration(seconds: 12),
        content: Text(
          Mapresponse_['message']['message'],
          style: TextStyle(color: Colors.white),
        ),
      ));
      setState(() {
        form_active1 = true;
      });
      //  print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> get_profile(x, y) async {
    var headers = {
      'Authorization': 'token ' + x.toString() + ':' + y.toString(),
      'Content-Type': "application/json",
      'Accept': "*/*",
      'Connection': "keep-alive"
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://test_senbagam.aerele.in/api/method/senbagam_api.api.get_profile'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 403) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.black26,
        duration: const Duration(seconds: 6),
        content: Text(
          "Session Expired",
          style: TextStyle(color: Colors.white),
        ),
      ));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginForm()));
    }

    if (response.statusCode == 200) {
      var res2 = await response.stream.bytesToString();

      profileres = await json.decode(res2);
      setState(() {
        name1 = profileres['message']['name'];
        city1 = profileres['message']['city'];
        district1 = profileres['message']['district'];
        pincode1 = profileres['message']['pincode'];
      });
      // print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
      setState(() {
        name = details[details.length - 1].name;
        city = details[details.length - 1].city;
        district = details[details.length - 1].district;
        pincode = details[details.length - 1].pincode;
      });
    }
  }
}
