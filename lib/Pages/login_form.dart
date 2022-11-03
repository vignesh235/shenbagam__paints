import 'dart:async';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:form_field_validator/form_field_validator.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shenbagam_paints/db/database_helper.dart';
import 'package:shenbagam_paints/Pages/forget_password.dart';
import 'package:shenbagam_paints/Pages/home.dart';
import 'package:shenbagam_paints/db/model/data.dart';
import 'package:shenbagam_paints/Pages/signup.dart';
import 'package:shenbagam_paints/utils/constants.dart';
import 'package:shenbagam_paints/animation/fadeanimation.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class LoginForm extends StatefulWidget {
  final Note? note;
  const LoginForm({
    Key? key,
    this.note,
  }) : super(key: key);
  static const String routeName = "/login";

  @override
  LoginFormValidationState createState() => LoginFormValidationState();
}

class LoginFormValidationState extends State<LoginForm> {
  bool form_active = true;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
//for database fields..
  get prefixIcon => null;
  late bool isImportant;
  late bool logged_in;
  late String api_key;
  late String api_secret;
  late String name;
  late String dob;
  late String mobile;
  late String email;
  late String address;
  late String city;
  late String district;
  late String referred_by;
  late String gstin;
  late String pincode;

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
    //for database fields...
    isImportant = widget.note?.isImportant ?? false;
    logged_in = widget.note?.logged_in ?? false;
    api_key = widget.note?.api_key ?? '';
    api_secret = widget.note?.api_secret ?? '';
    name = widget.note?.name ?? '';
    dob = widget.note?.dob ?? '';
    mobile = widget.note?.mobile ?? '';
    email = widget.note?.email ?? '';
    address = widget.note?.address ?? '';
    city = widget.note?.city ?? '';
    district = widget.note?.district ?? '';
    referred_by = widget.note?.referred_by ?? '';
    gstin = widget.note?.gstin ?? '';
    pincode = widget.note?.pincode ?? '';
  }

  String stringResponse = '0';
  Map Mapresponse = {};
  Map dataResponse = {};
  List Welcome = [];
  List store = [];
  TextEditingController mobilenum = TextEditingController();

  TextEditingController password_ = TextEditingController();
  bool _passwordVisible = false;
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            body: Container(
      width: ResponsiveFlutter.of(context).scale(double.infinity),
      height: ResponsiveFlutter.of(context).scale(double.infinity),
      child: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width / 10,
                              ResponsiveFlutter.of(context).scale(120),
                              0,
                              0),
                          child: Text(
                            'Senbagam Paints',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                  color: Colors.black54,
                                  fontSize: ResponsiveFlutter.of(context)
                                      .fontSize(4.5),
                                  letterSpacing: .5),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width / 10,
                              ResponsiveFlutter.of(context).scale(15),
                              0,
                              0),
                          child: Text(
                            'LOGIN',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: ResponsiveFlutter.of(context)
                                      .fontSize(3.5),
                                  letterSpacing: .5),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 6,
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
                        Form(
                            autovalidateMode: AutovalidateMode.always,
                            key: formkey,
                            child: Column(children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.width / 10,
                                    MediaQuery.of(context).size.width / 10,
                                    MediaQuery.of(context).size.width / 10,
                                    0),
                                child: !form_active
                                    ? TextFormField(
                                        enabled: false,
                                        controller: mobilenum,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            prefixIcon: prefixIcon ??
                                                Icon(
                                                  Icons.person,
                                                  color: Colors.purple.shade200,
                                                ),
                                            border: UnderlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Colors.red)),
                                            labelText: 'Mobile Number',
                                            contentPadding: EdgeInsets.all(16),
                                            hintText:
                                                'Enter your Mobile Number'),
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "* Required"),
                                          MinLengthValidator(10,
                                              errorText:
                                                  "Mobile Number should be 10 characters"),
                                        ]),
                                      )
                                    : TextFormField(
                                        controller: mobilenum,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            prefixIcon: prefixIcon ??
                                                Icon(
                                                  Icons.person,
                                                  color: Colors.purple.shade200,
                                                ),
                                            border: UnderlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Colors.red)),
                                            labelText: 'Mobile Number',
                                            contentPadding: EdgeInsets.all(16),
                                            hintText:
                                                'Enter your Mobile Number'),
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "* Required"),
                                          MinLengthValidator(10,
                                              errorText:
                                                  "Mobile Number should be 10 characters"),
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
                                        controller: password_,
                                        obscureText: !_passwordVisible,
                                        decoration: InputDecoration(
                                            prefixIcon: prefixIcon ??
                                                Icon(
                                                  Icons.password_sharp,
                                                  color: Colors.purple.shade200,
                                                ),
                                            border: UnderlineInputBorder(),
                                            labelText: 'Password',
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _passwordVisible =
                                                      !_passwordVisible;
                                                });
                                              },
                                              child: Icon(
                                                _passwordVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Colors.purple.shade200,
                                              ),
                                            ),
                                            contentPadding: EdgeInsets.all(16),
                                            fillColor: Colors.black12,
                                            hintText: 'Enter secure password'),
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "* Required"),
                                          MinLengthValidator(4,
                                              errorText:
                                                  "Password should be atleast 6 characters"),
                                          MaxLengthValidator(15,
                                              errorText:
                                                  "Password should not be greater than 15 characters")
                                        ]))
                                    : TextFormField(
                                        controller: password_,
                                        obscureText: !_passwordVisible,
                                        decoration: InputDecoration(
                                            prefixIcon: prefixIcon ??
                                                Icon(
                                                  Icons.password_sharp,
                                                  color: Colors.purple.shade200,
                                                ),
                                            border: UnderlineInputBorder(),
                                            labelText: 'Password',
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _passwordVisible =
                                                      !_passwordVisible;
                                                });
                                              },
                                              child: Icon(
                                                _passwordVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Colors.purple.shade200,
                                              ),
                                            ),
                                            contentPadding: EdgeInsets.all(16),
                                            fillColor: Colors.black12,
                                            hintText: 'Enter secure password'),
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "* Required"),
                                          MinLengthValidator(4,
                                              errorText:
                                                  "Password should be atleast 6 characters"),
                                          MaxLengthValidator(15,
                                              errorText:
                                                  "Password should not be greater than 15 characters")
                                        ])),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: Container(
                                    child: ElevatedButton(
                                  child: Text('Forget Password ?'),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(Forgetpass.routeName)
                                        .then((result) async {
                                      print(result);
                                    });
                                  },
                                  // textColor: Colors.blueAccent,
                                )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                // minWidth:
                                //     MediaQuery.of(context).size.width / 2,
                                child: Text('LOGIN'),
                                onPressed: form_active
                                    ? () {
                                        if (formkey.currentState!.validate()) {
                                          setState(() {
                                            form_active = false;
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.black26,
                                            duration:
                                                const Duration(seconds: 10),
                                            content: Text(
                                              "Please Wait while Loading .....",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ));
                                          loginup(mobilenum, password_);
                                        }
                                      }
                                    : null,
                                // disabledColor: Colors.black12,
                                // disabledTextColor: Colors.blueGrey,
                                // color: Colors.purple.shade200,
                                // splashColor: Colors.green,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  child: ElevatedButton(
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.blueGrey,
                                    wordSpacing: 4,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(SignUp.routeName)
                                      .then((result) async {
                                    print(result);
                                  });
                                },
                                // textColor: Colors.blueGrey,
                              )),
                            ])),
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

//Login API....
  loginup(mobilenum, password_) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://test_senbagam.aerele.in/api/method/senbagam_api.api.login'));
    request.body = json.encode({
      "args": {
        "username": mobilenum.text.toString().trim(),
        "password": password_.text.toString().trim()
      }
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Constants.prefs!.setBool("isLoggedIn", true);
      var res = await response.stream.bytesToString();
      Mapresponse = await json.decode(res);
      dataResponse = Mapresponse['message'];
      api_key = dataResponse['api_key'].toString();
      api_secret = dataResponse['api_secret'].toString();
      name = dataResponse['name'];
      dob = dataResponse['dob'];
      mobile = dataResponse['mobile_no'];
      email = dataResponse['email'];
      address = dataResponse['address'];
      city = dataResponse['city'];
      district = dataResponse['district'];
      referred_by = dataResponse['refered_by'];
      gstin = dataResponse['gstin'];
      pincode = dataResponse['pincode'];
      if (Mapresponse['message']['message'] == 'Success') {
        Navigator.of(context)
            .pushReplacementNamed(home.routeName)
            .then((result) async {
          print(result);
        });
        addOrUpdateNote();
      } else {
        setState(() {
          form_active = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.black26,
          duration: const Duration(seconds: 6),
          content: Text(
            "Invalid Data",
            style: TextStyle(color: Colors.white),
          ),
        ));
      }
      //print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

//Database function...
  void addOrUpdateNote() async {
    final isUpdating = widget.note != null;

    if (isUpdating) {
      await updateNote();
    } else {
      await addNote();
    }
  }

  Future updateNote() async {
    final note = widget.note!.copy(
      isImportant: isImportant,
      logged_in: logged_in,
      api_key: api_key,
      api_secret: api_secret,
      name: name,
      dob: dob,
      mobile: mobile,
      email: email,
      address: address,
      city: city,
      district: district,
      referred_by: referred_by,
      gstin: gstin,
      pincode: pincode,
    );

    await NotesDatabase.instance.update(note);
  }

  Future addNote() async {
    print("Added To Database");
    final note = Note(
      isImportant: true,
      logged_in: true,
      api_key: api_key,
      api_secret: api_secret,
      name: name,
      dob: dob,
      mobile: mobile,
      email: email,
      address: address,
      city: city,
      district: district,
      referred_by: referred_by,
      gstin: gstin,
      pincode: pincode,
      createdTime: DateTime.now(),
    );

    await NotesDatabase.instance.create(note);
  }
}
