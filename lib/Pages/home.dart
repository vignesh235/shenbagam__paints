import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shenbagam_paints/Pages/about.dart';
import 'package:shenbagam_paints/Pages/e_products.dart';
import 'package:shenbagam_paints/db/database_helper.dart';
import 'package:shenbagam_paints/Pages/edit_profile.dart';
import 'package:shenbagam_paints/Pages/explore_products.dart';
import 'package:shenbagam_paints/Pages/home_page.dart';
import 'package:shenbagam_paints/Pages/login_form.dart';
import 'package:shenbagam_paints/db/model/data.dart';
import 'package:shenbagam_paints/Pages/my_partners.dart';
import 'package:shenbagam_paints/Pages/profile.dart';
import 'package:shenbagam_paints/Pages/signup.dart';
import 'package:shenbagam_paints/animation/fadeanimation.dart';
import 'package:shenbagam_paints/Pages/wallet.dart';
import 'package:shenbagam_paints/utils/constants.dart';

class home extends StatefulWidget {
  static const String routeName = "/home";

  @override
  homeValidationState createState() => homeValidationState();
}

class homeValidationState extends State<home> {
  late PageController _pageController;
  int currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  late List<Note> details;
  bool isLoading = false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  get prefixIcon => null;
  TextEditingController feed = TextEditingController();
  Map Mapresponse_ = {};
  String dataResponse = '';
  Map about_response = {};
  String about_text = '';
  String company = '';
  bool form_active1 = true;
  String name = '';
  String email = '';
  List<Widget> _widgetOptions = <Widget>[
    Homepage(),
    ExplorePage(),
    wallet(),
    my_partners(),
    profile(),
  ];
  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    _pageController = PageController(initialPage: 0);
    super.initState();
    refreshNote();
  }

  Future refreshNote() async {
    this.details = await NotesDatabase.instance.readAllNotes();
    setState(() {
      name = details[details.length - 1].name;
      email = details[details.length - 1].email;
    });
    about_(details[details.length - 1].api_key,
        details[details.length - 1].api_secret);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black54),
        title: Text(
          "Senbagam Paints",
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
                color: Colors.black54,
                fontSize: ResponsiveFlutter.of(context).fontSize(3.5),
                letterSpacing: .5),
          ),
        ),
      ),
      body: _widgetOptions.elementAt(currentIndex),
      // controller: _pageController,
      // children: [
      //   Homepage(),
      //   ExplorePage(),
      //   wallet(),
      //   my_partners(),
      //   profile()
      // ],

      bottomNavigationBar: SalomonBottomBar(
        currentIndex: currentIndex,
        onTap: (i) => setState(() {
          currentIndex = i;
        }),
        // showElevation: false,
        // onItemSelected: (index) => _onItemTapped(index),
        items: [
          SalomonBottomBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 23,
              color: Colors.purple.shade500,
            ),
            title: Text(
              'Home',
              style: TextStyle(color: Colors.purple.shade500),
            ),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              Icons.production_quantity_limits_sharp,
              size: 23,
              color: Colors.purple.shade500,
            ),
            title: Text(
              'Products',
              style: TextStyle(color: Colors.purple.shade500),
            ),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              Icons.wallet_giftcard,
              size: 23,
              color: Colors.purple.shade500,
            ),
            title: Text(
              'Wallet',
              style: TextStyle(color: Colors.purple.shade500),
            ),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              Icons.person_add,
              size: 23,
              color: Colors.purple.shade500,
            ),
            title: Text(
              'Partners',
              style: TextStyle(color: Colors.purple.shade500),
            ),
          ),
          SalomonBottomBarItem(
            icon: Icon(
              Icons.settings,
              size: 23,
              color: Colors.purple.shade500,
            ),
            title: Text(
              'Profile',
              style: TextStyle(color: Colors.purple.shade500),
            ),
          ),
        ],
      ),
      drawer: Container(
          width: 250.0,
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: ListTile.divideTiles(context: context, tiles: [
              Container(
                decoration: BoxDecoration(color: Colors.blueGrey.shade50),
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.white),
                  accountName: Text(
                    name,
                    style: TextStyle(color: Colors.black),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50.0,
                    child: Image.asset("assets/login/usericonn.png"),
                  ),
                  accountEmail: Text(
                    email,
                    style: TextStyle(color: Colors.black),
                  ),
                  onDetailsPressed: () {
                    Navigator.of(context)
                        .pushNamed(edit.routeName)
                        .then((result) async {
                      print(result);
                    });
                  },
                ),
              ),
              Card(
                color: Colors.white,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                borderOnForeground: true,
                elevation: 0,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: ListTile(
                  leading: Icon(Icons.feedback_outlined),
                  title: const Text('Feedback'),
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
                  },
                ),
              ),
              Card(
                color: Colors.blueGrey.shade50,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                borderOnForeground: true,
                elevation: 0,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: ListTile(
                  leading: Icon(Icons.info_outline),
                  title: const Text('About Us'),
                  onTap: () {
                    Navigator.of(context).pushNamed(about.routeName,
                        arguments: {
                          'company': company,
                          'text': about_text
                        }).then((result) async {
                      print(result);
                    });
                  },
                ),
              ),
              Card(
                color: Colors.white,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                borderOnForeground: true,
                elevation: 0,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: const Text('Log Out'),
                  onTap: () {
                    Constants.prefs!.setBool("isLoggedIn", false);
                    logout(details[details.length - 1].api_key,
                        details[details.length - 1].api_secret);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginForm()));
                  },
                ),
              ),
            ]).toList(),
          )),
    );
  }

//Logout API...
  Future<void> logout(x, y) async {
    var headers = {
      'Authorization': 'token ' + x.toString() + ':' + y.toString(),
      'Content-Type': "application/json",
      'Accept': "*/*",
      'Connection': "keep-alive"
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://test_senbagam.aerele.in/api/method/senbagam_api.api.logout'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
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

  Future<void> about_(x, y) async {
    var headers = {
      'Authorization': 'token ' + x.toString() + ':' + y.toString(),
      'Content-Type': "application/json",
      'Accept': "*/*",
      'Connection': "keep-alive"
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://test_senbagam.aerele.in/api/method/senbagam_api.api.get_about'));

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
      var re = await response.stream.bytesToString();

      about_response = await json.decode(re);
      setState(() {
        about_text = about_response['message']['about'];
        company = about_response['message']['company'];
      });

      // print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
