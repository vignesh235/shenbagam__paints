import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shenbagam_paints/db/database_helper.dart';
import 'package:shenbagam_paints/db/model/data.dart';
import 'package:shenbagam_paints/Pages/profile.dart';

import 'package:shenbagam_paints/animation/fadeanimation.dart';

import 'package:shenbagam_paints/Pages/login_form.dart';

class wallet extends StatefulWidget {
  static const String routeName = "/wallet";

  @override
  walletValidationState createState() => walletValidationState();
}

class walletValidationState extends State<wallet> {
  late List<Note> details;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNote();
  }

  Future refreshNote() async {
    this.details = await NotesDatabase.instance.readAllNotes();

    wallet_call(details[details.length - 1].api_key,
        details[details.length - 1].api_secret);
  }

  TextEditingController? _textEditingController = TextEditingController();
  Map leger_response = {};
  List ledger_details = [];
  String balance = '';
  List order_details = [];
  List invoice_details = [];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black54,
          iconTheme: IconThemeData(color: Colors.black54),
          title: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Row(
              children: [
                Text(
                  "Wallet",
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                        color: Colors.black54, fontSize: 23, letterSpacing: .5),
                  ),
                ),
                balance == ''
                    ? Text(
                        "   -   " + "Balance = 0.0",
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 20,
                              letterSpacing: .5),
                        ),
                      )
                    : Text(
                        "   -   " + "Balance = " + balance.toString(),
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                              color: Colors.black54,
                              fontSize: 20,
                              letterSpacing: .5),
                        ),
                      ),
              ],
            ),
          ),
          bottom: TabBar(
            tabs: [
              Column(
                children: [
                  Icon(Icons.list, color: Colors.black54),
                  Text(
                    'Ledger',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
              Column(
                children: [
                  Icon(Icons.notes, color: Colors.black54),
                  Text(
                    'Orders',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
              Column(
                children: [
                  Icon(Icons.money_off_csred, color: Colors.black54),
                  Text(
                    'Invoices',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ledger_details.length == 0
                ? Image.asset("assets/login/loadingg1.gif")
                : ListView.builder(
                    itemCount: ledger_details.length,
                    itemBuilder: (ctx, index) {
                      return InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  scrollable: true,
                                  title: Center(
                                    child: Text(
                                      ledger_details[index]['voucher_no'],
                                      style: TextStyle(fontSize: 23),
                                    ),
                                  ),
                                  content: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Date : ',
                                            style: TextStyle(fontSize: 19),
                                          ),
                                          Text(
                                            ledger_details[index]['date'],
                                            style: TextStyle(fontSize: 17),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Amount : ',
                                            style: TextStyle(fontSize: 19),
                                          ),
                                          Text(
                                            ledger_details[index]['amount'],
                                            style: TextStyle(fontSize: 17),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Earning : ',
                                            style: TextStyle(fontSize: 19),
                                          ),
                                          Text(
                                            ledger_details[index]
                                                ['amount_earned'],
                                            style: TextStyle(fontSize: 17),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Credited : ',
                                            style: TextStyle(fontSize: 19),
                                          ),
                                          Text(
                                            ledger_details[index]
                                                ['credited_amount'],
                                            style: TextStyle(fontSize: 17),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Balance : ',
                                            style: TextStyle(fontSize: 19),
                                          ),
                                          Text(
                                            ledger_details[index]['balance'],
                                            style: TextStyle(fontSize: 17),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black12,
                                  Colors.black12,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            height: 80,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 20, 30, 0),
                                      child: Text(
                                          ledger_details[index]['voucher_no'],
                                          style: TextStyle(fontSize: 20)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 35, 0, 10),
                                      child: Text(
                                          ' -   ' +
                                              ledger_details[index]['date'],
                                          style: TextStyle(fontSize: 15)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
            order_details.length == 0
                ? Image.asset("assets/login/loadingg1.gif")
                : ListView.builder(
                    itemCount: order_details.length,
                    itemBuilder: (ctx, index) {
                      return InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  scrollable: true,
                                  title: Center(
                                    child: Text(
                                      order_details[index]['name'],
                                      style: TextStyle(fontSize: 23),
                                    ),
                                  ),
                                  content: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Date : ',
                                            style: TextStyle(fontSize: 19),
                                          ),
                                          Text(
                                            order_details[index]['date'],
                                            style: TextStyle(fontSize: 17),
                                          )
                                        ],
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            Text(
                                              'Item : ',
                                              style: TextStyle(fontSize: 19),
                                            ),
                                            Text(
                                              order_details[index]['item'],
                                              style: TextStyle(fontSize: 17),
                                            )
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Amount : ',
                                            style: TextStyle(fontSize: 19),
                                          ),
                                          Text(
                                            order_details[index]['amount'],
                                            style: TextStyle(fontSize: 17),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black12,
                                  Colors.black12,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            height: 80,
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 30, 0),
                                  child: Text(order_details[index]['name'],
                                      style: TextStyle(fontSize: 20)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Text(
                                      ' -   ' + order_details[index]['date'],
                                      style: TextStyle(fontSize: 15)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
            invoice_details.length == 0
                ? Image.asset("assets/login/loadingg1.gif")
                : ListView.builder(
                    itemCount: invoice_details.length,
                    itemBuilder: (ctx, index) {
                      return InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  scrollable: true,
                                  title: Center(
                                    child: Text(
                                      invoice_details[index]['name'],
                                      style: TextStyle(fontSize: 23),
                                    ),
                                  ),
                                  content: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Date : ',
                                            style: TextStyle(fontSize: 19),
                                          ),
                                          Text(
                                            invoice_details[index]['date'],
                                            style: TextStyle(fontSize: 17),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'amount : ',
                                            style: TextStyle(fontSize: 19),
                                          ),
                                          Text(
                                            invoice_details[index]['amount'],
                                            style: TextStyle(fontSize: 17),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Saving : ',
                                            style: TextStyle(fontSize: 19),
                                          ),
                                          Text(
                                            invoice_details[index]['saving'],
                                            style: TextStyle(fontSize: 17),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black12,
                                  Colors.black12,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            height: 90,
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 30, 0),
                                  child: Text(invoice_details[index]['name'],
                                      style: TextStyle(fontSize: 20)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 35, 0, 10),
                                  child: Text(
                                      ' -   ' + invoice_details[index]['date'],
                                      style: TextStyle(fontSize: 15)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
          ],
        ),
      ),
    );
  }

//Wallet API....
  void wallet_call(x, y) async {
    var headers = {
      'Authorization': 'token ' + x.toString() + ':' + y.toString(),
      'Content-Type': "application/json",
      'Accept': "*/*",
      'Connection': "keep-alive"
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://test_senbagam.aerele.in/api/method/senbagam_api.api.get_wallet'));

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
      leger_response = await json.decode(res);

      setState(() {
        ledger_details = leger_response['message']['ledger'];
        order_details = leger_response['message']['quotation'];
        invoice_details = leger_response['message']['sales_invoice'];
        balance = (leger_response['message']['balance']).toString();
      });

      // print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
