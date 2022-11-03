import 'dart:async';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shenbagam_paints/db/model/data.dart';

import 'package:shenbagam_paints/animation/fadeanimation.dart';
import 'package:shenbagam_paints/db/database_helper.dart';

class about extends StatefulWidget {
  static const String routeName = "/about";

  @override
  aboutValidationState createState() => aboutValidationState();
}

class aboutValidationState extends State<about> {
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
    final routes =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String textt = routes['text'];
    String Company = routes['company'];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black54,
          iconTheme: IconThemeData(color: Colors.black54),
          title: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Text(
              "About Us ",
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
              Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width / 10,
                    0,
                    MediaQuery.of(context).size.width / 10,
                    0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      Company,
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      textt,
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ]))));
  }
}
