import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:shenbagam_paints/Pages/home.dart';
import 'package:shenbagam_paints/Pages/login_form.dart';
// import 'package:shenbagam_paints/Pages/login_form.dart';
import 'package:shenbagam_paints/db/database_helper.dart';
import 'package:shenbagam_paints/db/model/data.dart';
import 'package:shenbagam_paints/animation/fadeanimation.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  static const String routeName = "/Homepage";

  @override
  HomepageValidationState createState() => HomepageValidationState();
}

class HomepageValidationState extends State<Homepage> {
  Map Mapresponse = {};
  List Welcome_details = [];
  Map dataresponse = {};
  List Store_details = [];

  List<List> color_list = [
    [
      Colors.grey.shade50,
      Colors.grey.shade100,
      Colors.grey.shade200,
      Colors.grey.shade300,
      Colors.grey.shade400,
    ],
    [
      Colors.blueGrey.shade50,
      Colors.blueGrey.shade100,
      Colors.blueGrey.shade200,
      Colors.blueGrey.shade300,
      Colors.blueGrey.shade400,
    ],
    [
      Colors.green.shade50,
      Colors.green.shade100,
      Colors.green.shade200,
      Colors.green.shade300,
      Colors.green.shade400,
    ],
  ];

  int _selectedColor = 0;
  int _selectedSize = 1;

  late List<Note> details;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNote();
  }

  Future refreshNote() async {
    this.details = await NotesDatabase.instance.readAllNotes();

    Welcome(details[details.length - 1].api_key,
        details[details.length - 1].api_secret);
    Stores(details[details.length - 1].api_key,
        details[details.length - 1].api_secret);
  }

  Widget build(BuildContext context) {
    print(Welcome_details);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black54,
              title: Padding(
                padding: EdgeInsets.fromLTRB(
                    ResponsiveFlutter.of(context).scale(12), 0, 0, 0),
                child:
                  Text(
                    "We Welcomes You !",
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                          color: Colors.orange.shade400,
                          fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
                          letterSpacing: .5),
                    ),
                  ),
                ),
              
              bottom: TabBar(
                tabs: [
                 
                    Text(
                      'WELCOME\n',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  
                 
                    Text(
                      'STORES\n',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                
                ],
              ),
            ),
            body: TabBarView(children: [
              Welcome_details.length == 0
                  ? Image.asset("assets/login/loadingg1.gif")
                  : 
                      ListView.builder(
                          itemCount: Welcome_details.length,
                          itemBuilder: (ctx, index) {
                            return InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    // <-- SEE HERE
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25.0),
                                    ),
                                  ),
                                  builder: ((builder) => bottomSheet(
                                        Welcome_details[index]['content'],
                                        Welcome_details[index]['description'],
                                      )),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white,
                                        Colors.white,
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                  ),
                                  height: 400,
                                  child: Column(
                                    children: [
                                      Image.network(
                                        Welcome_details[index]['image'],
                                        width: 600.0,
                                        height: 240.0,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 150, 0),
                                        child: Text(
                                          Welcome_details[index]['content'],
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                  
              Store_details.length == 0
                  ? Image.asset("assets/login/loadingg1.gif")
                  : 
                      ListView.builder(
                          itemCount: Store_details.length,
                          itemBuilder: (ctx, index) {
                            return InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                    // <-- SEE HERE
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25.0),
                                    ),
                                  ),
                                  builder: ((builder) => bottomSheet(
                                      Store_details[index]['address'],
                                      Store_details[index]['description'])),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.white,
                                        Colors.white,
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                  ),
                                  height: 400,
                                  child: Column(
                                    children: [
                                      Image.network(
                                        Store_details[index]['image'],
                                        width: 600.0,
                                        height: 240.0,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 150, 0),
                                        child: Text(
                                          Store_details[index]['address'],
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      // Padding(
                                      //   padding:
                                      //       const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      //   child: Container(
                                      //     height: 60,
                                      //     child: ListView.builder(
                                      //       scrollDirection: Axis.horizontal,
                                      //       itemCount: color_list[index].length,
                                      //       itemBuilder: (context, index1) {
                                      //         return GestureDetector(
                                      //           onTap: () {},
                                      //           child: AnimatedContainer(
                                      //             duration:
                                      //                 Duration(milliseconds: 300),
                                      //             margin: EdgeInsets.only(right: 10),
                                      //             decoration: BoxDecoration(
                                      //                 color: color_list[index]
                                      //                     [index1],
                                      //                 shape: BoxShape.circle),
                                      //             width: 40,
                                      //             height: 40,
                                      //           ),
                                      //         );
                                      //       },
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    
            ])));
  }

  Widget bottomSheet(text_name, description) {
    return Container(
      height: 500,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              text_name,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(description)
          ],
        ),
      ),
    );
  }

//Welcome API...
  void Welcome(x, y) async {
    var headers = {
      'Authorization': 'token ' + x.toString() + ':' + y.toString(),
      'Content-Type': "application/json",
      'Accept': "*/*",
      'Connection': "keep-alive"
    };

    var request = http.Request(
        'GET',
        Uri.parse(
            'http://test_senbagam.aerele.in/api/method/senbagam_api.api.welcome'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 403)
{
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
        Welcome_details = Mapresponse['message']['content'];
      });

      // print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

//Stores API ....
  void Stores(x, y) async {
    var headers = {
      'Authorization': 'token ' + x.toString() + ':' + y.toString(),
      'Content-Type': "application/json",
      'Accept': "*/*",
      'Connection': "keep-alive"
    };

    var request = http.Request(
        'GET',
        Uri.parse(
            'http://test_senbagam.aerele.in/api/method/senbagam_api.api.store'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 403)
{
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
      var res_ = await response.stream.bytesToString();
      dataresponse = await json.decode(res_);
      Store_details = dataresponse['message']['content'];
      // print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
