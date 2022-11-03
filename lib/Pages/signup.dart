import 'dart:async';
import 'package:flutter/services.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:shenbagam_paints/Pages/login_form.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:form_field_validator/form_field_validator.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shenbagam_paints/animation/fadeanimation.dart';

import 'dart:convert';

class SignUp extends StatefulWidget {
  static const String routeName = "/Signup";

  @override
  SignupValidationState createState() => SignupValidationState();
}

class SignupValidationState extends State<SignUp> {
  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  get prefixIcon => null;
  get suffixIcon => null;

  String? validatePassword(String value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\&*~]).{8,}$');
    if (value.isEmpty) {
      return "* Required";
    } else if (value.length < 4) {
      return "Password should be atleast 6 characters";
    } else if (value.length > 15) {
      return "Password should not be greater than 15 characters";
    } else if (value.isEmpty) {
      return 'Please enter password';
    } else if (!regex.hasMatch(value)) {
      return 'Password should contains Special characters,numbers and letters.';
    } else
      return null;
  }

  @override
  bool button_active = true;
  bool form_active = true;
  bool mobile_ref = true;
  Map Mapresponse_ref = {};
  Map Mapresponse = {};
  List dataResponse = [];
  var password = '';

  TextEditingController username_ = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController Mobilenum = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController City = TextEditingController();
  TextEditingController District = TextEditingController();
  TextEditingController Pincode = TextEditingController();
  TextEditingController password_ = TextEditingController();
  TextEditingController password__ = TextEditingController();
  TextEditingController gstn = TextEditingController();
  TextEditingController _controller = TextEditingController();

  bool _passwordVisible = false;
  bool isPressed = false;

  var items = ["Click ✓ in Mobile Number"];
  var referred_by_cus = [];

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: SingleChildScrollView(
                    child: Column(
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
                            'SIGN UP',
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: ResponsiveFlutter.of(context)
                                      .fontSize(3.5),
                                  letterSpacing: .5),
                            ),
                          ),
                        ),
                        Form(
                          key: formkey,
                          autovalidateMode: AutovalidateMode.always,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width / 10,
                                    MediaQuery.of(context).size.width / 15,
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
                                            contentPadding: EdgeInsets.all(16),
                                            labelText: 'Name',
                                            hintText: 'Enter your Name'),
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "* Required"),
                                          MinLengthValidator(4,
                                              errorText:
                                                  "Username should be atleast 4 characters"),
                                        ]))
                                    : TextFormField(
                                        controller: username_,
                                        decoration: InputDecoration(
                                            prefixIcon: prefixIcon ??
                                                Icon(Icons.person),
                                            border: UnderlineInputBorder(),
                                            contentPadding: EdgeInsets.all(16),
                                            labelText: 'Name',
                                            hintText: 'Enter your Name'),
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "* Required"),
                                          MinLengthValidator(4,
                                              errorText:
                                                  "Username should be atleast 4 characters"),
                                        ])),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width / 10,
                                      MediaQuery.of(context).size.width / 10,
                                      MediaQuery.of(context).size.width / 10,
                                      0),
                                  child: !form_active
                                      ? TextFormField(
                                          enabled: false,
                                          controller: dateinput,
                                          decoration: InputDecoration(
                                              prefixIcon: prefixIcon ??
                                                  Icon(Icons.calendar_today),
                                              border: UnderlineInputBorder(),
                                              contentPadding:
                                                  EdgeInsets.all(16),
                                              labelText: 'DOB',
                                              hintText:
                                                  'Enter your DOB'), //set it true, so that user will not able to edit text
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(
                                                        1950), //DateTime.now() - not to allow to choose before today.
                                                    lastDate: DateTime.now());

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
                                          validator: MultiValidator([
                                            RequiredValidator(
                                                errorText: "* Required"),
                                          ]),
                                        )
                                      : TextFormField(
                                          controller: dateinput,
                                          decoration: InputDecoration(
                                              prefixIcon: prefixIcon ??
                                                  Icon(Icons.calendar_today),
                                              border: UnderlineInputBorder(),
                                              contentPadding:
                                                  EdgeInsets.all(16),
                                              labelText: 'DOB',
                                              hintText:
                                                  'Enter your DOB'), //set it true, so that user will not able to edit text
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(
                                                        1950), //DateTime.now() - not to allow to choose before today.
                                                    lastDate: DateTime.now());

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
                                          validator: MultiValidator([
                                            RequiredValidator(
                                                errorText: "* Required"),
                                          ]),
                                        )),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width / 10,
                                    MediaQuery.of(context).size.width / 15,
                                    MediaQuery.of(context).size.width / 10,
                                    0),
                                child: !form_active
                                    ? TextFormField(
                                        enabled: false,
                                        controller: Mobilenum,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            prefixIcon:
                                                prefixIcon ?? Icon(Icons.phone),
                                            border: UnderlineInputBorder(),
                                            contentPadding: EdgeInsets.all(16),
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
                                            prefixIcon:
                                                prefixIcon ?? Icon(Icons.phone),
                                            border: UnderlineInputBorder(),
                                            contentPadding: EdgeInsets.all(16),
                                            labelText: 'Mobile Number',
                                            hintText:
                                                'Enter your Mobile Number'),
                                        onChanged: (text) {
                                          setState(() {
                                            mobile_ref = false;
                                          });
                                        },
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "* Required"),
                                          MinLengthValidator(10,
                                              errorText:
                                                  "Mobile Number should be 10 characters"),
                                        ])),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width / 10,
                                    MediaQuery.of(context).size.width / 15,
                                    MediaQuery.of(context).size.width / 10,
                                    0),
                                child: !form_active
                                    ? TextFormField(
                                        enabled: false,
                                        controller: email,
                                        decoration: InputDecoration(
                                            prefixIcon:
                                                prefixIcon ?? Icon(Icons.email),
                                            border: UnderlineInputBorder(),
                                            contentPadding: EdgeInsets.all(16),
                                            labelText: 'Email',
                                            hintText: 'Enter your Email ID'),
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "* Required"),
                                        ]))
                                    : TextFormField(
                                        controller: email,
                                        decoration: InputDecoration(
                                            prefixIcon:
                                                prefixIcon ?? Icon(Icons.email),
                                            border: UnderlineInputBorder(),
                                            contentPadding: EdgeInsets.all(16),
                                            labelText: 'Email',
                                            hintText: 'Enter your Email ID'),
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "* Required"),
                                        ])),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width / 10,
                                    MediaQuery.of(context).size.width / 15,
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
                                            contentPadding: EdgeInsets.all(16),
                                            labelText: 'Address',
                                            hintText: 'Enter your Address'),
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "* Required"),
                                          MinLengthValidator(4,
                                              errorText:
                                                  "Username should be atleast 4 characters"),
                                        ]))
                                    : TextFormField(
                                        controller: Address,
                                        maxLines: 2,
                                        decoration: InputDecoration(
                                            prefixIcon: prefixIcon ??
                                                Icon(Icons.landscape),
                                            border: UnderlineInputBorder(),
                                            contentPadding: EdgeInsets.all(16),
                                            labelText: 'Address',
                                            hintText: 'Enter your Address'),
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "* Required"),
                                          MinLengthValidator(4,
                                              errorText:
                                                  "Address should be atleast 4 characters"),
                                        ])),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width / 10,
                                    MediaQuery.of(context).size.width / 15,
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
                                            contentPadding: EdgeInsets.all(16),
                                            labelText: 'City',
                                            hintText: 'Enter your City'),
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "* Required"),
                                          MinLengthValidator(4,
                                              errorText:
                                                  "Username should be atleast 4 characters"),
                                        ]))
                                    : TextFormField(
                                        controller: City,
                                        decoration: InputDecoration(
                                            prefixIcon: prefixIcon ??
                                                Icon(Icons.location_city),
                                            border: UnderlineInputBorder(),
                                            contentPadding: EdgeInsets.all(16),
                                            labelText: 'City',
                                            hintText: 'Enter your City'),
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "* Required"),
                                          MinLengthValidator(4,
                                              errorText:
                                                  "City should be atleast 4 characters"),
                                        ])),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width / 10,
                                    MediaQuery.of(context).size.width / 15,
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
                                            contentPadding: EdgeInsets.all(16),
                                            labelText: 'District',
                                            hintText: 'Enter your District'),
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "* Required"),
                                          MinLengthValidator(4,
                                              errorText:
                                                  "Username should be atleast 4 characters"),
                                        ]))
                                    : TextFormField(
                                        controller: District,
                                        decoration: InputDecoration(
                                            prefixIcon: prefixIcon ??
                                                Icon(Icons.pin_drop),
                                            border: UnderlineInputBorder(),
                                            contentPadding: EdgeInsets.all(16),
                                            labelText: 'District',
                                            hintText: 'Enter your District'),
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "* Required"),
                                          MinLengthValidator(4,
                                              errorText:
                                                  "District should be atleast 4 characters"),
                                        ])),
                              ),
                              mobile_ref == false
                                  ? Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          MediaQuery.of(context).size.width /
                                              10,
                                          MediaQuery.of(context).size.width /
                                              15,
                                          MediaQuery.of(context).size.width /
                                              10,
                                          0),
                                      child: ElevatedButton(
                                        // disabledColor: Colors.black12,
                                        // disabledTextColor: Colors.blueGrey,
                                        // color: Colors.purple.shade100,
                                        child: Text(
                                          'Get Referrals',
                                          style: TextStyle(
                                            //fontSize: 18,
                                            color: Colors.black,
                                            wordSpacing: 4,
                                          ),
                                        ),
                                        onPressed: button_active
                                            ? () {
                                                items.clear();
                                                dataResponse.clear();
                                                Referral(Mobilenum);
                                                setState(() {
                                                  button_active = false;
                                                });
                                              }
                                            : null,
                                        // textColor: Colors.blueGrey,
                                      ),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          MediaQuery.of(context).size.width /
                                              10,
                                          MediaQuery.of(context).size.width /
                                              15,
                                          MediaQuery.of(context).size.width /
                                              10,
                                          0),
                                      child: ElevatedButton(
                                        // disabledColor: Colors.black12,
                                        // disabledTextColor: Colors.blueGrey,
                                        // color: Colors.purple.shade100,
                                        child: Text(
                                          'Get Referrals',
                                          style: TextStyle(
                                            //fontSize: 18,
                                            color: Colors.black,
                                            wordSpacing: 4,
                                          ),
                                        ),
                                        onPressed: null,
                                        // textColor: Colors.blueGrey,
                                      ),
                                    ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width / 10,
                                      MediaQuery.of(context).size.width / 10,
                                      MediaQuery.of(context).size.width / 10,
                                      0),
                                  child: button_active
                                      ? TextFormField(
                                          enabled: false,
                                          controller: _controller,
                                          decoration: InputDecoration(
                                            prefixIcon: prefixIcon ??
                                                Icon(Icons.person),
                                            labelText: 'Referred by ',
                                            suffixIcon: PopupMenuButton<String>(
                                              icon: const Icon(
                                                  Icons.arrow_drop_down),
                                              onSelected: (String value) {
                                                _controller.text = value;
                                              },
                                              itemBuilder:
                                                  (BuildContext context) {
                                                return items
                                                    .map<PopupMenuItem<String>>(
                                                        (String value) {
                                                  return new PopupMenuItem(
                                                      child: new Text(value),
                                                      value: value);
                                                }).toList();
                                              },
                                            ),
                                          ),
                                        )
                                      : !form_active
                                          ? TextFormField(
                                              enabled: false,
                                              controller: _controller,
                                              decoration: InputDecoration(
                                                prefixIcon: prefixIcon ??
                                                    Icon(Icons.person),
                                                labelText: 'Referred by ',
                                                suffixIcon:
                                                    PopupMenuButton<String>(
                                                  icon: const Icon(
                                                      Icons.arrow_drop_down),
                                                  onSelected: (String value) {
                                                    _controller.text = value;
                                                  },
                                                  itemBuilder:
                                                      (BuildContext context) {
                                                    return items.map<
                                                            PopupMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return new PopupMenuItem(
                                                          child:
                                                              new Text(value),
                                                          value: value);
                                                    }).toList();
                                                  },
                                                ),
                                              ),
                                              validator: MultiValidator([
                                                RequiredValidator(
                                                    errorText: "* Required"),
                                              ]))
                                          : TextFormField(
                                              controller: _controller,
                                              decoration: InputDecoration(
                                                prefixIcon: prefixIcon ??
                                                    Icon(Icons.person),
                                                labelText: 'Referred by ',
                                                suffixIcon:
                                                    PopupMenuButton<String>(
                                                  icon: const Icon(
                                                      Icons.arrow_drop_down),
                                                  onSelected: (String value) {
                                                    _controller.text = value;
                                                  },
                                                  itemBuilder:
                                                      (BuildContext context) {
                                                    return items.map<
                                                            PopupMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return new PopupMenuItem(
                                                          child:
                                                              new Text(value),
                                                          value: value);
                                                    }).toList();
                                                  },
                                                ),
                                              ),
                                              validator: MultiValidator([
                                                RequiredValidator(
                                                    errorText: "* Required"),
                                                MinLengthValidator(4,
                                                    errorText:
                                                        "District should be atleast 4 characters"),
                                              ]))),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width / 10,
                                    MediaQuery.of(context).size.width / 15,
                                    MediaQuery.of(context).size.width / 10,
                                    0),
                                child: !form_active
                                    ? TextFormField(
                                        enabled: false,
                                        controller: gstn,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            prefixIcon: prefixIcon ??
                                                Icon(Icons.confirmation_number),
                                            border: UnderlineInputBorder(),
                                            contentPadding: EdgeInsets.all(16),
                                            labelText: 'GSTIN',
                                            hintText: 'Enter your GSTIN'),
                                      )
                                    : TextFormField(
                                        controller: gstn,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            prefixIcon: prefixIcon ??
                                                Icon(Icons.confirmation_number),
                                            border: UnderlineInputBorder(),
                                            contentPadding: EdgeInsets.all(16),
                                            labelText: 'GSTIN',
                                            hintText: 'Enter your GSTIN'),
                                      ),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width / 10,
                                      MediaQuery.of(context).size.width / 10,
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
                                              labelText: 'Pincode',
                                              hintText: 'Enter your Pincode'),
                                          validator: MultiValidator([
                                            RequiredValidator(
                                                errorText: "* Required"),
                                            MinLengthValidator(6,
                                                errorText:
                                                    "Username should be atleast 6 characters"),
                                          ]))
                                      : TextFormField(
                                          controller: Pincode,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              prefixIcon: prefixIcon ??
                                                  Icon(Icons.code),
                                              border: UnderlineInputBorder(),
                                              contentPadding:
                                                  EdgeInsets.all(16),
                                              labelText: 'Pincode',
                                              hintText: 'Enter your Pincode'),
                                          validator: MultiValidator([
                                            RequiredValidator(
                                                errorText: "* Required"),
                                            MinLengthValidator(6,
                                                errorText:
                                                    "Pincode should be atleast 6 characters"),
                                          ]))),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width / 10,
                                    MediaQuery.of(context).size.width / 15,
                                    MediaQuery.of(context).size.width / 10,
                                    0),
                                child: !form_active
                                    ? TextFormField(
                                        enabled: false,
                                        controller: password_,
                                        obscureText: !_passwordVisible,
                                        decoration: InputDecoration(
                                            prefixIcon: prefixIcon ??
                                                Icon(Icons.password_sharp),
                                            border: UnderlineInputBorder(),
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _passwordVisible =
                                                      !_passwordVisible;
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
                                            RequiredValidator(
                                                errorText: "* Required"),
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
                                            prefixIcon: prefixIcon ??
                                                Icon(Icons.password_sharp),
                                            border: UnderlineInputBorder(),
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _passwordVisible =
                                                      !_passwordVisible;
                                                });
                                              },
                                              child: Icon(_passwordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off),
                                            ),
                                            contentPadding: EdgeInsets.all(16),
                                            labelText: 'Password',
                                            hintText: 'Enter secure password'),
                                        onChanged: (val) => password = val,
                                        validator: Validators.compose([
                                          Validators.patternString(
                                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                                              'Ensure Password contains\nSpecialcharacters,Numbers and Letters'),
                                          MultiValidator([
                                            RequiredValidator(
                                                errorText: "* Required"),
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
                                padding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width / 10,
                                    MediaQuery.of(context).size.width / 15,
                                    MediaQuery.of(context).size.width / 10,
                                    0),
                                child: !form_active
                                    ? TextFormField(
                                        enabled: false,
                                        controller: password__,
                                        obscureText: !_passwordVisible,
                                        decoration: InputDecoration(
                                            prefixIcon: prefixIcon ??
                                                Icon(Icons.password_sharp),
                                            border: UnderlineInputBorder(),
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _passwordVisible =
                                                      !_passwordVisible;
                                                });
                                              },
                                              child: Icon(_passwordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off),
                                            ),
                                            contentPadding: EdgeInsets.all(16),
                                            labelText: 'Confirm Password',
                                            hintText:
                                                'Enter secure password again'),
                                        validator: Validators.compose([
                                          Validators.patternString(
                                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                                              'Ensure Password contains\nSpecialcharacters,Numbers and Letters'),
                                          MultiValidator([
                                            RequiredValidator(
                                                errorText: "* Required"),
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
                                            prefixIcon: prefixIcon ??
                                                Icon(Icons.password_sharp),
                                            border: UnderlineInputBorder(),
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _passwordVisible =
                                                      !_passwordVisible;
                                                });
                                              },
                                              child: Icon(_passwordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off),
                                            ),
                                            contentPadding: EdgeInsets.all(16),
                                            labelText: 'Confirm Password',
                                            hintText:
                                                'Enter secure password again'),
                                        validator: (val) => MatchValidator(
                                                errorText:
                                                    'passwords do not match')
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
                                height: 20,
                              ),
                              !form_active
                                  ? ElevatedButton(
                                      // minWidth: MediaQuery.of(context)
                                      //         .size
                                      //         .width /
                                      //     2,
                                      child: Text('SIGN UP'),
                                      onPressed: null,
                                      // color: Colors.purple.shade200,
                                      // splashColor: Colors.green,
                                    )
                                  : ElevatedButton(
                                      // minWidth: MediaQuery.of(context)
                                      //         .size
                                      //         .width /
                                      //     2,
                                      child: Text('SIGN UP'),
                                      onPressed: form_active
                                          ? () {
                                              if (formkey.currentState!
                                                  .validate()) {
                                                setState(() {
                                                  form_active = false;
                                                });
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  backgroundColor:
                                                      Colors.black26,
                                                  duration: const Duration(
                                                      seconds: 10),
                                                  content: Text(
                                                    "Please Wait while Loading .....",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ));
                                                Signup123(
                                                    username_,
                                                    dateinput,
                                                    Mobilenum,
                                                    email,
                                                    Address,
                                                    City,
                                                    District,
                                                    _controller,
                                                    gstn,
                                                    Pincode,
                                                    password_);
                                              }
                                            }
                                          : null,
                                      // disabledColor: Colors.black12,
                                      // disabledTextColor:
                                      //     Colors.blueGrey,
                                      // color: Colors.purple.shade200,
                                      // splashColor: Colors.green,
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

//Get Referral API....
  void Referral(mobile_no) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://test_senbagam.aerele.in/api/method/senbagam_api.api.get_referrals'));
    request.body = json.encode({
      "args": {
        "mobile_no": mobile_no.text.toString().trim(),
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
    // ignore: avoid_print

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();

      Mapresponse_ref = await json.decode(res);

      dataResponse = Mapresponse_ref['message']['refered_by'];
      print(dataResponse);
      setState(() {
        for (int i = 0; i < dataResponse.length; i++) {
          items.add(dataResponse[i].toString());
          referred_by_cus.add(dataResponse[i].toString());
        }
      });

      //print(json.decode(await response.stream.bytesToString()));
    } else {
      print(response.reasonPhrase);
    }
  }

//Sign UP API...
  Signup123(username_, dateinput, Mobilenum, email, Address, City, District,
      _controller, gstn, Pincode, password_) async {
    print(username_.text.toString().trim());
    print(dateinput.text.toString().trim());
    print(Mobilenum.text.toString().trim());
    print(email.text.toString().trim());
    print(Address.text.toString().trim());
    print(City.text.toString().trim());
    print(District.text.toString().trim());
    print(_controller.text.toString().trim());
    print(gstn.text.toString().trim());
    print(Pincode.text.toString().trim());
    print(password_.text.toString().trim());
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://test_senbagam.aerele.in/api/method/senbagam_api.api.signup'));
    request.body = json.encode({
      "args": {
        "name": username_.text.toString().trim(),
        "dob": dateinput.text.toString().trim(),
        "mobile_no": Mobilenum.text.toString().trim(),
        "email": email.text.toString().trim(),
        "address": Address.text.toString().trim(),
        "city": City.text.toString().trim(),
        "district": District.text.toString().trim(),
        "refered_by": _controller.text.toString().trim(),
        "gstin": gstn.text.toString().trim(),
        "pincode": Pincode.text.toString().trim(),
        "password": password_.text.toString().trim()
      }
    });
    var body = request.body;
    print(body);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      Mapresponse = await json.decode(res);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.black26,
        duration: const Duration(seconds: 12),
        content: Text(
          Mapresponse['message']['message'],
          style: TextStyle(color: Colors.white),
        ),
      ));
      if (Mapresponse['message']['message'] ==
          'Account Created, Please Login') {
        Navigator.pop(context);
      } else {
        setState(() {
          form_active = true;
        });
      }
    } else if (response.statusCode == 417) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.black26,
        duration: const Duration(seconds: 12),
        content: Text(
          "Password is not Strong..",
          style: TextStyle(color: Colors.white),
        ),
      ));
    } else {
      print(response.reasonPhrase);
    }
  }
}
