import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:form_field_validator/form_field_validator.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:shenbagam_paints/db/database_helper.dart';
import 'package:shenbagam_paints/db/model/data.dart';
import 'package:shenbagam_paints/animation/fadeanimation.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

import 'package:wc_form_validators/wc_form_validators.dart';

import 'package:shenbagam_paints/Pages/login_form.dart';

class edit extends StatefulWidget {
  static const String routeName = "/edit";

  @override
  editValidationState createState() => editValidationState();
}

class editValidationState extends State<edit> {
  late List<Note> details;
  bool isLoading = false;

  @override
  void initState() {
    dateinput.text = "";
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    refreshNote();
  }

  Future refreshNote() async {
    this.details = await NotesDatabase.instance.readAllNotes();

    get_profile(details[details.length - 1].api_key,
        details[details.length - 1].api_secret);
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  Map Mapresponse = {};
  bool form_active = true;
  bool form_active_ = true;
  late PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  get prefixIcon => null;
  String name1 = '';
  String dob1 = '';
  String mobile1 = '';
  String email1 = '';
  String address1 = '';
  String city1 = '';
  String district1 = '';
  String referred_by1 = '';
  String gstin1 = '';
  String pincode1 = '';

  String name1_a = '';
  String dob1_a = '';
  String mobile1_a = '';
  String email1_a = '';
  String address1_a = '';
  String city1_a = '';
  String district1_a = '';
  String referred_by1_a = '';
  String gstin1_a = '';
  String pincode1_a = '';
  Map profileres = {};
  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "* Required";
    } else if (value.length < 4) {
      return "Password should be atleast 6 characters";
    } else if (value.length > 15) {
      return "Password should not be greater than 15 characters";
    } else
      return null;
  }

  @override
  TextEditingController username_ = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController _controller = TextEditingController();
  TextEditingController Mobilenum = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController City = TextEditingController();
  TextEditingController District = TextEditingController();
  TextEditingController Pincode = TextEditingController();
  TextEditingController password_ = TextEditingController();
  TextEditingController gstn = TextEditingController();
  bool _passwordVisible = false;
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            body: Container(
      width: double.infinity,
      height: double.infinity,
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage("assets/login/SignUpBG.jpg"),
      //     fit: BoxFit.cover,
      //     colorFilter: ColorFilter.mode(
      //         Colors.black.withOpacity(0.6), BlendMode.dstATop),
      //   ),
      // ),
      child: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: SingleChildScrollView(
                    child: 
                    
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0,
                                        ResponsiveFlutter.of(context).scale(50),
                                        0,
                                        0),
                                    child: new IconButton(
                                      icon: new Icon(Icons.arrow_back),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      0,
                                      ResponsiveFlutter.of(context).scale(50),
                                      0,
                                      0),
                                  child: Text(
                                    'Senbagam Paints',
                                    style: GoogleFonts.raleway(
                                      textStyle: TextStyle(
                                          color: Colors.black54,
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(3.5),
                                          letterSpacing: .5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                       
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.width / 10,
                                  ResponsiveFlutter.of(context).scale(15),
                                  0,
                                  0),
                              child: Text(
                                'EDIT PROFILE',
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      letterSpacing: .5),
                                ),
                              ),
                            ),
                        
                          
                           
                            Form(
                              autovalidateMode: AutovalidateMode.always,
                              key: formkey,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    child: 
                                    
                                      Container(
                                        alignment: Alignment(0.0, 2.5),
                                        width: double.infinity,
                                        height: 100,
                                        child: Stack(children: <Widget>[
                                          CircleAvatar(
                                              radius: 80.0,
                                              backgroundColor: Colors.white,
                                              backgroundImage: AssetImage(
                                                  "assets/login/usericonn.png")

                                              //  backgroundImage: (_imageFile != null) ? FileImage(File(_imageFile!.path)) as ImageProvider : AssetImage("assets/login/usericonn.png")

                                              // backgroundImage: _imageFile == null ? AssetImage("assets/login/usericonn.png") : FileImage(File(_imageFile.path )
                                              // ),
                                              ),
                                          // Positioned(
                                          //   bottom: 20.0,
                                          //   right: 20.0,
                                          //   child: InkWell(
                                          //     onTap: () {
                                          //       showModalBottomSheet(
                                          //         context: context,
                                          //         builder: ((builder) =>
                                          //             bottomSheet()),
                                          //       );
                                          //     },
                                          //     child: Icon(
                                          //       Icons.camera_alt,
                                          //       color: Colors.teal,
                                          //       size: 28.0,
                                          //     ),
                                          //   ),
                                          // ),
                                        ]),
                                      ),
                                    ),
                                 
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width / 10,
                                        MediaQuery.of(context).size.width / 25,
                                        MediaQuery.of(context).size.width / 10,
                                        0),
                                    child: !form_active
                                        ? TextFormField(
                                            enabled: false,
                                            controller: username_,
                                            decoration: InputDecoration(
                                                prefixIcon: prefixIcon ??
                                                    Icon(Icons.person),
                                                border: UnderlineInputBorder(),
                                                contentPadding:
                                                    EdgeInsets.all(16),
                                                labelText: name1_a == ''
                                                    ? name1
                                                    : name1_a,
                                                hintText: 'Enter your Name'),
                                          )
                                        : TextFormField(
                                            controller: username_,
                                            decoration: InputDecoration(
                                                prefixIcon: prefixIcon ??
                                                    Icon(Icons.person),
                                                border: UnderlineInputBorder(),
                                                contentPadding:
                                                    EdgeInsets.all(16),
                                                labelText: name1_a == ''
                                                    ? name1
                                                    : name1_a,
                                                hintText: 'Enter your Name'),
                                            onChanged: (value) {
                                              setState(() {
                                                form_active_ = false;
                                              });
                                            },
                                            onFieldSubmitted: (value) {
                                              setState(() {
                                                name1 = username_.text
                                                    .toString()
                                                    .trim();
                                              });
                                            }),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          MediaQuery.of(context).size.width /
                                              10,
                                          MediaQuery.of(context).size.width /
                                              20,
                                          MediaQuery.of(context).size.width /
                                              10,
                                          0),
                                      child: !form_active
                                          ? TextFormField(
                                              enabled: false,
                                              controller: dateinput,
                                              decoration: InputDecoration(
                                                  prefixIcon: prefixIcon ??
                                                      Icon(
                                                          Icons.calendar_today),
                                                  border:
                                                      UnderlineInputBorder(),
                                                  contentPadding:
                                                      EdgeInsets.all(16),
                                                  labelText: dob1_a == ''
                                                      ? dob1
                                                      : dob1_a,
                                                  hintText:
                                                      'Enter your DOB'), //set it true, so that user will not able to edit text
                                              onTap: () async {
                                                DateTime? pickedDate =
                                                    await showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate: DateTime(
                                                            1950), //DateTime.now() - not to allow to choose before today.
                                                        lastDate:
                                                            DateTime.now());

                                                if (pickedDate != null) {
                                                  print(
                                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                  String formattedDate =
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(pickedDate);
                                                  print(
                                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                                  //you can implement different kind of Date Format here according to your requirement

                                                  setState(() {
                                                    dateinput.text =
                                                        formattedDate; //set output date to TextField value.
                                                  });
                                                } else {
                                                  print("Date is not selected");
                                                }
                                              },
                                            )
                                          : TextFormField(
                                              enabled: false,
                                              controller: dateinput,
                                              decoration: InputDecoration(
                                                  prefixIcon: prefixIcon ??
                                                      Icon(
                                                          Icons.calendar_today),
                                                  border:
                                                      UnderlineInputBorder(),
                                                  contentPadding:
                                                      EdgeInsets.all(16),
                                                  labelText: dob1_a == ''
                                                      ? dob1
                                                      : dob1_a,
                                                  hintText: 'Enter your DOB'),
                                              onChanged: (value) {
                                                setState(() {
                                                  form_active_ = false;
                                                });
                                              },
                                              onFieldSubmitted: (value) {
                                                setState(() {
                                                  dob1 = dateinput.text
                                                      .toString()
                                                      .trim();
                                                });
                                              }, //set it true, so that user will not able to edit text
                                              onTap: () async {
                                                DateTime? pickedDate =
                                                    await showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate: DateTime(
                                                            1950), //DateTime.now() - not to allow to choose before today.
                                                        lastDate:
                                                            DateTime.now());

                                                if (pickedDate != null) {
                                                  print(
                                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                  String formattedDate =
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(pickedDate);
                                                  print(
                                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                                  //you can implement different kind of Date Format here according to your requirement

                                                  setState(() {
                                                    dateinput.text =
                                                        formattedDate; //set output date to TextField value.
                                                  });
                                                } else {
                                                  print("Date is not selected");
                                                }
                                              },
                                            )),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width / 10,
                                        MediaQuery.of(context).size.width / 25,
                                        MediaQuery.of(context).size.width / 10,
                                        0),
                                    child: !form_active
                                        ? TextFormField(
                                            enabled: false,
                                            controller: Mobilenum,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                prefixIcon: prefixIcon ??
                                                    Icon(Icons.phone),
                                                border: UnderlineInputBorder(),
                                                contentPadding:
                                                    EdgeInsets.all(16),
                                                labelText: mobile1_a == ''
                                                    ? mobile1
                                                    : mobile1_a,
                                                hintText:
                                                    'Enter your Mobile Number'),
                                          )
                                        : TextFormField(
                                            controller: Mobilenum,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                prefixIcon: prefixIcon ??
                                                    Icon(Icons.phone),
                                                border: UnderlineInputBorder(),
                                                contentPadding:
                                                    EdgeInsets.all(16),
                                                labelText: mobile1_a == ''
                                                    ? mobile1
                                                    : mobile1_a,
                                                hintText:
                                                    'Enter your Mobile Number'),
                                            onChanged: (value) {
                                              setState(() {
                                                form_active_ = false;
                                              });
                                            },
                                            onFieldSubmitted: (value) {
                                              setState(() {
                                                mobile1 = Mobilenum.text
                                                    .toString()
                                                    .trim();
                                              });
                                            }),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width / 10,
                                        MediaQuery.of(context).size.width / 25,
                                        MediaQuery.of(context).size.width / 10,
                                        0),
                                    child: !form_active
                                        ? TextFormField(
                                            enabled: false,
                                            controller: email,
                                            decoration: InputDecoration(
                                                prefixIcon: prefixIcon ??
                                                    Icon(Icons.email),
                                                border: UnderlineInputBorder(),
                                                contentPadding:
                                                    EdgeInsets.all(16),
                                                labelText: email1_a == ''
                                                    ? email1
                                                    : email1_a,
                                                hintText:
                                                    'Enter your Email ID'),
                                          )
                                        : TextFormField(
                                            enabled: false,
                                            controller: email,
                                            decoration: InputDecoration(
                                                prefixIcon: prefixIcon ??
                                                    Icon(Icons.email),
                                                border: UnderlineInputBorder(),
                                                contentPadding:
                                                    EdgeInsets.all(16),
                                                labelText: email1_a == ''
                                                    ? email1
                                                    : email1_a,
                                                hintText:
                                                    'Enter your Email ID'),
                                            onChanged: (value) {
                                              setState(() {
                                                form_active_ = false;
                                              });
                                            },
                                          ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width / 10,
                                        MediaQuery.of(context).size.width / 25,
                                        MediaQuery.of(context).size.width / 10,
                                        0),
                                    child: !form_active
                                        ? TextFormField(
                                            enabled: false,
                                            controller: Address,
                                            maxLines: 2,
                                            decoration: InputDecoration(
                                                prefixIcon: prefixIcon ??
                                                    Icon(Icons.landscape),
                                                border: UnderlineInputBorder(),
                                                contentPadding:
                                                    EdgeInsets.all(16),
                                                labelText: address1_a == ''
                                                    ? address1
                                                    : address1_a,
                                                hintText: 'Enter your Address'),
                                          )
                                        : TextFormField(
                                            controller: Address,
                                            maxLines: 2,
                                            decoration: InputDecoration(
                                                prefixIcon: prefixIcon ??
                                                    Icon(Icons.landscape),
                                                border: UnderlineInputBorder(),
                                                contentPadding:
                                                    EdgeInsets.all(16),
                                                labelText: address1_a == ''
                                                    ? address1
                                                    : address1_a,
                                                hintText: 'Enter your Address'),
                                            onChanged: (value) {
                                              setState(() {
                                                form_active_ = false;
                                              });
                                            },
                                            onFieldSubmitted: (value) {
                                              setState(() {
                                                address1 = Address.text
                                                    .toString()
                                                    .trim();
                                              });
                                            }),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width / 10,
                                        MediaQuery.of(context).size.width / 25,
                                        MediaQuery.of(context).size.width / 10,
                                        0),
                                    child: !form_active
                                        ? TextFormField(
                                            enabled: false,
                                            controller: City,
                                            decoration: InputDecoration(
                                                prefixIcon: prefixIcon ??
                                                    Icon(Icons.location_city),
                                                border: UnderlineInputBorder(),
                                                contentPadding:
                                                    EdgeInsets.all(16),
                                                labelText: city1_a == ''
                                                    ? city1
                                                    : city1_a,
                                                hintText: 'Enter your City'),
                                          )
                                        : TextFormField(
                                            controller: City,
                                            decoration: InputDecoration(
                                                prefixIcon: prefixIcon ??
                                                    Icon(Icons.location_city),
                                                border: UnderlineInputBorder(),
                                                contentPadding:
                                                    EdgeInsets.all(16),
                                                labelText: city1_a == ''
                                                    ? city1
                                                    : city1_a,
                                                hintText: 'Enter your City'),
                                            onChanged: (value) {
                                              setState(() {
                                                form_active_ = false;
                                              });
                                            },
                                            onFieldSubmitted: (value) {
                                              setState(() {
                                                city1 =
                                                    City.text.toString().trim();
                                              });
                                            }),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width / 10,
                                        MediaQuery.of(context).size.width / 25,
                                        MediaQuery.of(context).size.width / 10,
                                        0),
                                    child: !form_active
                                        ? TextFormField(
                                            enabled: false,
                                            controller: District,
                                            decoration: InputDecoration(
                                                prefixIcon: prefixIcon ??
                                                    Icon(Icons.pin_drop),
                                                border: UnderlineInputBorder(),
                                                contentPadding:
                                                    EdgeInsets.all(16),
                                                labelText: district1_a == ''
                                                    ? district1
                                                    : district1_a,
                                                hintText:
                                                    'Enter your District'),
                                          )
                                        : TextFormField(
                                            controller: District,
                                            decoration: InputDecoration(
                                                prefixIcon: prefixIcon ??
                                                    Icon(Icons.pin_drop),
                                                border: UnderlineInputBorder(),
                                                contentPadding:
                                                    EdgeInsets.all(16),
                                                labelText: district1_a == ''
                                                    ? district1
                                                    : district1_a,
                                                hintText:
                                                    'Enter your District'),
                                            onChanged: (value) {
                                              setState(() {
                                                form_active_ = false;
                                              });
                                            },
                                            onFieldSubmitted: (value) {
                                              setState(() {
                                                district1 = District.text
                                                    .toString()
                                                    .trim();
                                              });
                                            }),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width / 10,
                                        MediaQuery.of(context).size.width / 25,
                                        MediaQuery.of(context).size.width / 10,
                                        0),
                                    child: TextField(
                                      enabled: false,
                                      controller: _controller,
                                      decoration: InputDecoration(
                                        prefixIcon:
                                            prefixIcon ?? Icon(Icons.person),
                                        labelText: referred_by1_a == ''
                                            ? referred_by1
                                            : referred_by1_a,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width / 10,
                                        MediaQuery.of(context).size.width / 25,
                                        MediaQuery.of(context).size.width / 10,
                                        0),
                                    child: !form_active
                                        ? TextFormField(
                                            enabled: false,
                                            controller: gstn,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                prefixIcon: prefixIcon ??
                                                    Icon(Icons
                                                        .confirmation_number),
                                                border: UnderlineInputBorder(),
                                                contentPadding:
                                                    EdgeInsets.all(16),
                                                labelText: gstin1_a == ''
                                                    ? gstin1
                                                    : gstin1_a,
                                                hintText: 'Enter your GSTIN'),
                                          )
                                        : TextFormField(
                                            controller: gstn,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                prefixIcon: prefixIcon ??
                                                    Icon(Icons
                                                        .confirmation_number),
                                                border: UnderlineInputBorder(),
                                                contentPadding:
                                                    EdgeInsets.all(16),
                                                labelText: gstin1_a == ''
                                                    ? gstin1
                                                    : gstin1_a,
                                                hintText: 'Enter your GSTIN'),
                                            onChanged: (value) {
                                              setState(() {
                                                form_active_ = false;
                                              });
                                            },
                                            onFieldSubmitted: (value) {
                                              setState(() {
                                                gstin1 =
                                                    gstn.text.toString().trim();
                                              });
                                            }),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width / 10,
                                        MediaQuery.of(context).size.width / 25,
                                        MediaQuery.of(context).size.width / 10,
                                        0),
                                    child: !form_active
                                        ? TextFormField(
                                            enabled: false,
                                            controller: Pincode,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                prefixIcon: prefixIcon ??
                                                    Icon(Icons.code),
                                                border: UnderlineInputBorder(),
                                                contentPadding:
                                                    EdgeInsets.all(16),
                                                labelText: pincode1_a == ''
                                                    ? pincode1
                                                    : pincode1_a,
                                                hintText: 'Enter your Pincode'),
                                          )
                                        : TextFormField(
                                            controller: Pincode,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                prefixIcon: prefixIcon ??
                                                    Icon(Icons.code),
                                                border: UnderlineInputBorder(),
                                                contentPadding:
                                                    EdgeInsets.all(16),
                                                labelText: pincode1_a == ''
                                                    ? pincode1
                                                    : pincode1_a,
                                                hintText: 'Enter your Pincode'),
                                            onChanged: (value) {
                                              setState(() {
                                                form_active_ = false;
                                              });
                                            },
                                            onFieldSubmitted: (value) {
                                              setState(() {
                                                pincode1 = Pincode.text
                                                    .toString()
                                                    .trim();
                                              });
                                            }),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                 
                                      ElevatedButton(
                                      
                                        child: Text('SAVE'),
                                        onPressed: form_active_
                                            ? null
                                            : () {
                                                if (formkey.currentState!
                                                    .validate()) {
                                                  setState(() {
                                                    form_active = false;
                                                    form_active_ = true;
                                                  });
                                                  edit_profile(
                                                      details[details.length -
                                                              1]
                                                          .api_key,
                                                      details[details.length -
                                                              1]
                                                          .api_secret,
                                                      name1,
                                                      dob1,
                                                      mobile1,
                                                      address1,
                                                      city1,
                                                      district1,
                                                      gstin1,
                                                      pincode1);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    backgroundColor:
                                                        Colors.black26,
                                                    duration: const Duration(
                                                        seconds: 6),
                                                    content: Text(
                                                      "Please Wait while Loading .....",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ));
                                                }
                                              },
                                      
                                      ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                        
                        ],
                      ),
                    ),
                  ),
                
              ],
            ),
          ],
        ),
      ),
    )));
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            ElevatedButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                print("object");
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                print("hello");
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    print(pickedFile!.path);
    setState(() {
      _imageFile = PickedFile as PickedFile;
      // List<int> imageBytes =
      //                   _imageFile.readAsBytesSync();
      // String base64Image = base64Encode(
      //                   _imageFile);
    });
  }

  Future<void> edit_profile(x, y, name11, dob11, mobile11, address11, city11,
      district11, gstin11, pincode11) async {
    var headers = {
      'Authorization': 'token ' + x.toString() + ':' + y.toString(),
      'Content-Type': "application/json",
      'Accept': "*/*",
      'Connection': "keep-alive"
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://test_senbagam.aerele.in/api/method/senbagam_api.api.update_profile'));
    request.body = json.encode({
      "args": {
        "name": name11,
        "dob": dob11,
        "mobile_no": mobile11,
        "address": address11,
        "city": city11,
        "district": district11,
        "gstin": gstin11,
        "pincode": pincode11
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

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.black26,
        duration: const Duration(seconds: 6),
        content: Text(
          Mapresponse['message']['message'],
          style: TextStyle(color: Colors.white),
        ),
      ));
      Navigator.pop(context);

      //print(await response.stream.bytesToString());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.black26,
        duration: const Duration(seconds: 6),
        content: Text(
          "Try again later .....",
          style: TextStyle(color: Colors.white),
        ),
      ));
      Navigator.pop(context);
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
        name1_a = profileres['message']['name'];
        dob1_a = profileres['message']['dob'];
        mobile1_a = profileres['message']['mobile_no'];
        email1_a = profileres['message']['email'];
        address1_a = profileres['message']['address'];
        city1_a = profileres['message']['city'];
        district1_a = profileres['message']['district'];
        referred_by1_a = profileres['message']['referes_by'];
        gstin1_a = profileres['message']['gstin'];
        pincode1_a = profileres['message']['pincode'];
      });
      // print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
      setState(() {
        name1 = details[details.length - 1].name;
        dob1 = details[details.length - 1].dob;
        mobile1 = details[details.length - 1].mobile;
        email1 = details[details.length - 1].email;
        address1 = details[details.length - 1].address;
        city1 = details[details.length - 1].city;
        district1 = details[details.length - 1].district;
        referred_by1 = details[details.length - 1].referred_by;
        gstin1 = details[details.length - 1].gstin;
        pincode1 = details[details.length - 1].pincode;
      });
    }
  }
}
