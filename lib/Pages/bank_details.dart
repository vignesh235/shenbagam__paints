import 'dart:async';
import 'package:form_field_validator/form_field_validator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shenbagam_paints/db/model/data.dart';
import 'package:shenbagam_paints/Pages/my_partners.dart';
import 'package:shenbagam_paints/Pages/profile.dart';
import 'package:shenbagam_paints/animation/fadeanimation.dart';
import 'package:shenbagam_paints/db/database_helper.dart';

import 'package:shenbagam_paints/Pages/login_form.dart';

class bank extends StatefulWidget {
  static const String routeName = "/bank";

  @override
  bankValidationState createState() => bankValidationState();
}

class bankValidationState extends State<bank> {
  late PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  late List<Note> details;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNote();
  }

  Future refreshNote() async {
    this.details = await NotesDatabase.instance.readAllNotes();
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController? _textEditingController = TextEditingController();
  TextEditingController bank_name = TextEditingController();
  TextEditingController account_holder_name = TextEditingController();
  TextEditingController account_no = TextEditingController();
  TextEditingController re_account_no = TextEditingController();
  TextEditingController ifsc_code = TextEditingController();

  bool _hasBeenPressed_add = true;
  bool hasBeenPressed_view = true;

  String value = '';
  Map Mapresponse = {};
  List dataresponse = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black54,
          iconTheme: IconThemeData(color: Colors.black54),
          title: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Text(
              "Bank Details",
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                    color: Colors.black54, fontSize: 23, letterSpacing: .5),
              ),
            ),
          ),
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
                child: Stack(children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 150,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _hasBeenPressed_add = !_hasBeenPressed_add;
                              });
                            },
                            child: Card(
                              // margin: EdgeInsets.symmetric(
                              //     horizontal: 20.0, vertical: 5.0),
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Icon(
                                        Icons.add,
                                        size: 22,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    "Add Bank account",
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
                        Container(
                          height: 150,
                          child: InkWell(
                            onTap: () {
                              viewexist(details[details.length - 1].api_key,
                                  details[details.length - 1].api_secret);
                              dataresponse.length == 0
                                  ? null
                                  : setState(() {
                                      hasBeenPressed_view =
                                          !hasBeenPressed_view;
                                    });
                            },
                            child: Card(
                              color: Colors.white70,
                              // margin: EdgeInsets.symmetric(
                              //     horizontal: 0.0, vertical: 5.0),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                                      "View Existing\nAccount",
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
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Center(
                      child: Container(
                          width: 300,
                          child: _hasBeenPressed_add ? getView() : getAdd()),
                    ),
                  ),
                ],
              ),
            ]))));
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
                print("hellll");
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                print("hellooo");
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
    print(pickedFile);
    setState(() {
      _imageFile = PickedFile as PickedFile;
    });
  }

  Widget getAdd() {
    if (_hasBeenPressed_add == false) {
      return Form(
          autovalidateMode: AutovalidateMode.always,
          key: formkey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextFormField(
                    controller: bank_name,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: UnderlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                        labelText: 'Bank Name',
                        hintText: 'Enter your Bank Name'),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                      MinLengthValidator(2,
                          errorText: "Username should be atleast 2 characters"),
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextFormField(
                    controller: account_holder_name,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: UnderlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                        labelText: 'Account Holder Name',
                        hintText: 'Enter Account holder Name'),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                      MinLengthValidator(4,
                          errorText: "Username should be atleast 4 characters"),
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextFormField(
                    obscureText: true,
                    controller: account_no,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        border: UnderlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                        labelText: 'Account Number',
                        hintText: 'Enter your Account Number'),
                    onChanged: (val) => value = val,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                      // MinLengthValidator(16,
                      //     errorText: "Account Number should be 16 characters"),
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextFormField(
                  obscureText: true,
                  controller: re_account_no,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      border: UnderlineInputBorder(),
                      contentPadding: EdgeInsets.all(16),
                      labelText: 'ReEnter Account Number',
                      hintText: 'Enter your Account Number'),
                  validator: MultiValidator([
                    RequiredValidator(errorText: "* Required"),
                    // MinLengthValidator(16,
                    //     errorText: "Account Number should be 16 characters"),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: TextFormField(
                    controller: ifsc_code,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: UnderlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                        labelText: 'IFSC Code',
                        hintText: 'Enter your IFSC Code'),
                    validator: MultiValidator([
                      RequiredValidator(errorText: "* Required"),
                      MinLengthValidator(4,
                          errorText: "Username should be atleast 4 characters"),
                    ])),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    if (re_account_no.text.toString().isEmpty) {
                      errorText:
                      'Fill all the details';
                    } else {
                      setState(() {
                        _hasBeenPressed_add = !_hasBeenPressed_add;
                      });
                      submit(
                          details[details.length - 1].api_key,
                          details[details.length - 1].api_secret,
                          bank_name,
                          account_holder_name,
                          account_no,
                          re_account_no,
                          ifsc_code);
                    }
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text('Upload image'),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomSheet()),
                  );
                },
              ),
            ],
          ));
    } else {
      return Center(
          child: Text(
        "",
        style: TextStyle(color: Colors.red),
      ));
    }
  }

  Widget getView() {
    if (hasBeenPressed_view == false) {
      return Container(
        height: 170,
        child: InkWell(
          child: Card(
            elevation: 10,
            color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 15, 30, 4),
              child: dataresponse.length == 0
                  ? Image.asset("assets/login/loadingg1.gif")
                  : Column(
                      children: [
                        Text("Existing Account"),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Text("Bank : "),
                            Text(dataresponse[0]['bank'])
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text("Account Holder Name : "),
                            //  Text(dataresponse[0]['account_holder_name'])
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text("Account Number : "),
                            Text(dataresponse[0]['account_no'])
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text("IFSC Code : "),
                            Text(dataresponse[0]['ifsc_code'])
                          ],
                        )
                      ],
                    ),
            ),
          ),
        ),
      );
    } else {
      return Center(
          child: Text(
        "",
        style: TextStyle(color: Colors.red),
      ));
    }
    ;
  }

//Add Bank Account API....
  Future<void> submit(x, y, bank_name, account_holder_name, account_no,
      re_account_no, ifsc_code) async {
    var headers = {
      'Authorization': 'token ' + x.toString() + ':' + y.toString(),
      'Content-Type': "application/json",
      'Accept': "*/*",
      'Connection': "keep-alive"
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://test_senbagam.aerele.in/api/method/senbagam_api.api.add_bank'));
    request.body = json.encode({
      "args": {
        "bank_name": bank_name.text.toString().trim(),
        "account_holder_name": account_holder_name.text.toString().trim(),
        "account_no": account_no.text.toString().trim(),
        "ifsc_code": ifsc_code.text.toString().trim()
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
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

//View Existing API.....
  Future<void> viewexist(x, y) async {
    var headers = {
      'Authorization': 'token ' + x.toString() + ':' + y.toString(),
      'Content-Type': "application/json",
      'Accept': "*/*",
      'Connection': "keep-alive"
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://test_senbagam.aerele.in/api/method/senbagam_api.api.get_bank_details'));

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
      dataresponse = Mapresponse['message']['data'];
      // print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
