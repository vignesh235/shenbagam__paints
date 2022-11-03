import 'dart:async';
import 'dart:convert';
import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shenbagam_paints/animation/fadeanimation.dart';
import 'package:shenbagam_paints/db/database_helper.dart';
import 'package:shenbagam_paints/db/model/data.dart';

import 'login_form.dart';

class qr_page extends StatefulWidget {
  @override
  static const String routeName = "/qr_page";
  qr_pageState createState() {
    return new qr_pageState();
  }
}

class qr_pageState extends State<qr_page> {
  Map Mapresponse_ = {};
  String dataResponse = '';
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
  }

  String result = "Scan For Rewards !";
  String qrResult = '';
  bool pressed = true;
  bool pressed_ = false;
  Future _scanQR() async {
    try {
      qrResult = (await BarcodeScanner.scan()) as String;
      setState(() {
        pressed = false;
        pressed_ = true;
        result = " Wow! Claim Your Rewards !";
      });
    } on PlatformException catch (ex) {
      // if (ex.code == BarcodeScanner.CameraAccessDenied) {
      //   setState(() {
      //     result = "Camera permission was denied";
      //   });
      // } else {
      //   setState(() {
      //     result = "Unknown Error $ex";
      //   });
      // }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything ";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black54),
          // centerTitle: true,
          title: Text(
            "Senbagam Paints",
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                  color: Colors.black54, fontSize: 25, letterSpacing: .5),
            ),
          ),

          // backgroundColor: Colors.white10.withOpacity(0.01),
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
                child: Stack(children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 10),
                    child: Container(
                      child: Column(children: [
                        Text(
                          "Scan QR Code",
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                                color: Colors.black54,
                                fontSize: 23,
                                letterSpacing: .5),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Card(
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          borderOnForeground: true,
                          elevation: 0,
                          child: Text(
                            result,
                            style: new TextStyle(fontSize: 20.0),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width / 5,
                        0,
                        MediaQuery.of(context).size.width / 5,
                        0),
                    child: ElevatedButton(
                      // minWidth: 190,
                      child: Text('SCAN'),
                      onPressed: pressed
                          ? () {
                              _scanQR();
                            }
                          : null,
                      // color: Colors.purple.shade200,
                      // splashColor: Colors.green,
                      // disabledColor: Colors.black12,
                      // disabledTextColor: Colors.blueGrey,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width / 5,
                        0,
                        MediaQuery.of(context).size.width / 5,
                        0),
                    child: ElevatedButton(
                      // minWidth: 190,
                      child: Text('CLAIM REWARDS'),
                      onPressed: pressed_
                          ? () {
                              qr_page(
                                  details[details.length - 1].api_key,
                                  details[details.length - 1].api_secret,
                                  qrResult);
                            }
                          : null,
                      // color: Colors.purple.shade200,
                      // splashColor: Colors.green,
                      // disabledColor: Colors.black12,
                      // disabledTextColor: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            ])))

        //onPressed: _scanQR,
        );
  }

//Claim Reward API ....
  void qr_page(x, y, content) async {
    var headers = {
      'Authorization': 'token ' + x.toString() + ':' + y.toString(),
      'Content-Type': "application/json",
      'Accept': "*/*",
      'Connection': "keep-alive"
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://test_senbagam.aerele.in/api/method/senbagam_api.api.add_qr'));
    request.body = json.encode({
      "args": {"qr_code": content}
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
        pressed_ = false;
      });
      // print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
