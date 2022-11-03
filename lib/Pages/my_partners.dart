import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shenbagam_paints/Pages/login_form.dart';
import 'package:shenbagam_paints/db/database_helper.dart';
import 'package:shenbagam_paints/db/model/data.dart';
import 'package:shenbagam_paints/animation/fadeanimation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

import 'dart:convert';

class my_partners extends StatefulWidget {
  static const String routeName = "/my_partners";

  @override
  my_partnersValidationState createState() => my_partnersValidationState();
}

List<Entry> got = [];
List<Entry> not_got = [Entry("No Referral Found")];

class my_partnersValidationState extends State<my_partners> {
  Map partner_response = {};
  List parter_list = [];
  late List<Note> details;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNote();
  }

  Future refreshNote() async {
    this.details = await NotesDatabase.instance.readAllNotes();

    partners(details[details.length - 1].api_key,
        details[details.length - 1].api_secret);
  }

//Referal Tree API....
  Future<void> partners(x, y) async {
    var headers = {
      'Authorization': 'token ' + x.toString() + ':' + y.toString(),
      'Content-Type': "application/json",
      'Accept': "*/*",
      'Connection': "keep-alive"
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://test_senbagam.aerele.in/api/method/senbagam_api.api.get_referral_tree'));

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
      partner_response = await json.decode(res);

      setState(() {
        got = get_entry(partner_response['message'], "parent");
      });

      // print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

//Function for API response for ENTRY...
  List<Entry> get_entry(Map data, key) {
    if (!data.containsKey(key)) {
      return [Entry("null")];
    }
    List<Entry> ret_data = [];
    for (var i = 0; i < data[key].length; i++) {
      String temp_title = data[key][i];
      List<Entry> temp = get_entry(data, data[key][i]);
      if (temp.length != 0 && temp[0].title != "null") {
        ret_data.add(Entry(temp_title, temp));
      } else {
        ret_data.add(Entry(temp_title));
      }
    }
    return ret_data.length > 0 ? ret_data : [Entry("No Referral Found")];
  }

  parse_entry(data) {
    print(data.title);
    for (var i = 0; i < data.children.length; i++) {
      parse_entry(data.children[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 150, 0),
            child: Text(
              "My Partners",
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                    color: Colors.black54, fontSize: 23, letterSpacing: .5),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: got.length == 0
                ? ListView.builder(
                    itemCount: not_got.length,
                    itemBuilder: (BuildContext context, int index) => EntryItem(
                      not_got[index],
                    ),
                  )
                : ListView.builder(
                    itemCount: got.length,
                    itemBuilder: (BuildContext context, int index) => EntryItem(
                      got[index],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class Entry {
  final String title;
  final List<Entry> children;
  Entry(this.title, [this.children = const <Entry>[]]);
}

final List<Entry> data = got;

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);
  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) {
      return Container(
        decoration: BoxDecoration(color: Colors.white12),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: AssetImage("assets/login/usericonn.png"),
          ),
          title: Text(
            root.title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(color: Colors.white12),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: AssetImage("assets/login/usericonn.png"),
        ),
        key: PageStorageKey<Entry>(root),
        title: Text(
          root.title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        children: root.children.map<Widget>(_buildTiles).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
