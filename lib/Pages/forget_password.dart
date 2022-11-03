import 'dart:async';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:form_field_validator/form_field_validator.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:shenbagam_paints/animation/fadeanimation.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import 'package:shenbagam_paints/Pages/login_form.dart';

class Forgetpass extends StatefulWidget {
  static const String routeName = "/Forgetpass";

  @override
  ForgetpassValidationState createState() => ForgetpassValidationState();
}

class ForgetpassValidationState extends State<Forgetpass> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool _hasBeenPressed = true;

  get prefixIcon => null;
  var password = '';

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
  void initState() {
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  @override
  Map Mapresponse = {};
  Map dataResponse = {};

  TextEditingController Mobilenum = TextEditingController();
  TextEditingController Otp = TextEditingController();
  TextEditingController password_ = TextEditingController();
  TextEditingController password__ = TextEditingController();

  bool _passwordVisible = false;
  bool form_active = true;
  bool form_active1 = true;

  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            body: Container(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                      Row(
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
                            padding: EdgeInsets.fromLTRB(0,
                                ResponsiveFlutter.of(context).scale(50), 0, 0),
                            child: Text(
                              'Senbagam Paints',
                              style: GoogleFonts.raleway(
                                textStyle: TextStyle(
                                    color: Colors.black54,
                                    fontSize: ResponsiveFlutter.of(context)
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
                          'FORGET PASSWORD',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                letterSpacing: .5),
                          ),
                        ),
                      ),
                      Container(
                        child: SingleChildScrollView(
                          child: Card(
                            margin: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width / 13,
                                MediaQuery.of(context).size.width / 8,
                                MediaQuery.of(context).size.width / 13,
                                0),
                            clipBehavior: Clip.antiAlias,
                            child: Form(
                              autovalidateMode: AutovalidateMode.always,
                              key: formkey,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width / 15,
                                        0,
                                        MediaQuery.of(context).size.width / 15,
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
                                                labelText: 'Mobile Number',
                                                hintText:
                                                    'Enter your Mobile Number'),
                                            validator: MultiValidator([
                                              RequiredValidator(
                                                  errorText: "* Required"),
                                              MinLengthValidator(10,
                                                  errorText:
                                                      "Mobile Number should be 10 characters"),
                                            ]))
                                        : TextFormField(
                                            controller: Mobilenum,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                prefixIcon: prefixIcon ??
                                                    Icon(Icons.phone),
                                                border: UnderlineInputBorder(),
                                                contentPadding:
                                                    EdgeInsets.all(16),
                                                labelText: 'Mobile Number',
                                                hintText:
                                                    'Enter your Mobile Number'),
                                            validator: MultiValidator([
                                              RequiredValidator(
                                                  errorText: "* Required"),
                                              MinLengthValidator(10,
                                                  errorText:
                                                      "Mobile Number should be 10 characters"),
                                            ])),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    child: Text('SEND OTP'),
                                    onPressed: form_active
                                        ? () {
                                            if (formkey.currentState!
                                                .validate()) {
                                              send_otp(Mobilenum);
                                              setState(() {
                                                _hasBeenPressed = false;
                                                form_active = false;
                                              });
                                            }
                                            ;
                                          }
                                        : null,
                                    // disabledColor:
                                    //     Colors.black12,
                                    // disabledTextColor:
                                    //     Colors.blueGrey,
                                    // color: Colors
                                    //     .purple.shade200,
                                    // splashColoColor.fromARGB(255, 5, 20, 6)een,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Center(
                                      child: Container(
                                          width: 300,
                                          child: _hasBeenPressed
                                              ? getOTP()
                                              : getOTP()),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ])))
              ],
            ),
          ],
        ),
      ),
    )));
  }

  Widget getOTP() {
    if (_hasBeenPressed == false) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 15,
                0, MediaQuery.of(context).size.width / 15, 0),
            child: !form_active1
                ? TextFormField(
                    enabled: false,
                    controller: Otp,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        prefixIcon:
                            prefixIcon ?? Icon(Icons.format_list_numbered),
                        border: UnderlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                        labelText: 'Enter OTP',
                        hintText: 'Enter your Generated OTP'),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                      MinLengthValidator(4,
                          errorText: "OTP should be atleast 4 characters"),
                    ]))
                : TextFormField(
                    controller: Otp,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        prefixIcon:
                            prefixIcon ?? Icon(Icons.format_list_numbered),
                        border: UnderlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                        labelText: 'Enter OTP',
                        hintText: 'Enter your Generated OTP'),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                      MinLengthValidator(4,
                          errorText: "OTP should be atleast 4 characters"),
                    ])),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 15,
                0, MediaQuery.of(context).size.width / 15, 0),
            child: !form_active1
                ? TextFormField(
                    enabled: false,
                    controller: password_,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                        prefixIcon: prefixIcon ?? Icon(Icons.password_sharp),
                        border: UnderlineInputBorder(),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          child: Icon(_passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        contentPadding: EdgeInsets.all(16),
                        labelText: 'Password',
                        hintText: 'Enter secure password'),
                    validator: Validators.compose([
                      Validators.patternString(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                          'Ensure Password contains\nSpecialcharacters,Numbers and Letters'),
                      MultiValidator([
                        RequiredValidator(errorText: "* Required"),
                        MinLengthValidator(4,
                            errorText:
                                "Password should be atleast 6 characters"),
                        MaxLengthValidator(15,
                            errorText:
                                "Password should not be greater than 15 characters")
                      ])
                    ]),
                  )
                : TextFormField(
                    controller: password_,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                        prefixIcon: prefixIcon ?? Icon(Icons.password_sharp),
                        border: UnderlineInputBorder(),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          child: Icon(_passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        contentPadding: EdgeInsets.all(16),
                        labelText: 'New Password',
                        hintText: 'Enter secure password'),
                    onChanged: (val) => password = val,
                    validator: Validators.compose([
                      Validators.patternString(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                          'Ensure Password contains\nSpecialcharacters,Numbers and Letters'),
                      MultiValidator([
                        RequiredValidator(errorText: "* Required"),
                        MinLengthValidator(4,
                            errorText:
                                "Password should be atleast 6 characters"),
                        MaxLengthValidator(15,
                            errorText:
                                "Password should not be greater than 15 characters")
                      ])
                    ]),
                  ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 15,
                0, MediaQuery.of(context).size.width / 15, 0),
            child: !form_active1
                ? TextFormField(
                    enabled: false,
                    controller: password__,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                        prefixIcon: prefixIcon ?? Icon(Icons.password_sharp),
                        border: UnderlineInputBorder(),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          child: Icon(_passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        contentPadding: EdgeInsets.all(16),
                        labelText: 'Confirm Password',
                        hintText: 'Enter secure password again'),
                    validator: Validators.compose([
                      Validators.patternString(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                          'Ensure Password contains\nSpecialcharacters,Numbers and Letters'),
                      MultiValidator([
                        RequiredValidator(errorText: "* Required"),
                        MinLengthValidator(4,
                            errorText:
                                "Password should be atleast 6 characters"),
                        MaxLengthValidator(15,
                            errorText:
                                "Password should not be greater than 15 characters")
                      ])
                    ]),
                  )
                : TextFormField(
                    controller: password__,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                        prefixIcon: prefixIcon ?? Icon(Icons.password_sharp),
                        border: UnderlineInputBorder(),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                          child: Icon(_passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        contentPadding: EdgeInsets.all(16),
                        labelText: 'Confirm Password',
                        hintText: 'Enter secure password again'),
                    validator: (val) =>
                        MatchValidator(errorText: 'passwords do not match')
                            .validateMatch(val!, password),
                    //Validators.compose([
                    //     Validators.patternString(
                    //         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                    //         'Ensure Password contains\nSpecialcharacters,Numbers and Letters'),
                    //     MultiValidator([
                    //       RequiredValidator(
                    //           errorText: "* Required"),
                    //       MinLengthValidator(4,
                    //           errorText:
                    //               "Password should be atleast 6 characters"),
                    //       MaxLengthValidator(15,
                    //           errorText:
                    //               "Password should not be greater than 15 characters")
                    //     ])
                    //   ]),
                  ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            child: Text('RESET PASSWORD'),
            onPressed: form_active1
                ? () {
                    if (formkey.currentState!.validate()) {
                      setState(() {
                        form_active1 = false;
                      });
                      reset_pass(Otp, password_);
                    }
                    ;
                  }
                : null,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      );
    } else {
      return Center(
          child: Text(
        "Get OTP to Change your Password !",
        style: TextStyle(color: Colors.red),
      ));
    }
  }

//Send OTP API...
  void send_otp(mobile_no) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://test_senbagam.aerele.in/api/method/senbagam_api.api.send_otp'));
    request.body = json.encode({
      "args": {"mobile_no": mobile_no.text.toString().trim()}
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
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

// Reset password API...
  void reset_pass(otp, password) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://test_senbagam.aerele.in/api/method/senbagam_api.api.reset_password'));
    request.body = json.encode({
      "args": {
        "otp": otp.text.toString().trim(),
        "new_password": password.text.toString().trim()
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
      if (Mapresponse['message']['message'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.black26,
          content: Text(
            "Password has changed Successfully ",
            style: TextStyle(color: Colors.white),
          ),
        ));
        Navigator.pop(context);
      }
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
