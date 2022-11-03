import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shenbagam_paints/Pages/product_view.dart';
import 'package:shenbagam_paints/animation/fadeanimation.dart';
import 'package:shenbagam_paints/models/products.dart';

class explorePage extends StatefulWidget {
  static const String routeName = "/expo";

  @override
  explorePageState createState() => explorePageState();
}

class explorePageState extends State<explorePage>
    with TickerProviderStateMixin {
  List<dynamic> productList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverAppBar(
        floating: false,
        pinned: true,
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black54,
        title: 
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: 
                
                  Text(
                    "All Products",
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 23,
                          letterSpacing: .5),
                    ),
                  ),
                ),
              
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: 
                   
                    InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Icon(Icons.check_outlined),
                          Text("Get Quotation"),
                        ],
                      ),
                    )),
              
            ],
          ),
        ),
    
      SliverList(delegate:
          SliverChildBuilderDelegate((BuildContext context, int index) {
        if (index > 2) return null;
        return Container(
            color: Colors.white,
            padding: EdgeInsets.only(
              top: 20,
              left: MediaQuery.of(context).size.width / 20,
              right: MediaQuery.of(context).size.width / 20,
            ),
            height: 330,
            child: Column(children: [
             
                Text(
                  "EZHIL",
                  style: TextStyle(fontSize: 19),
                ),
              
              SizedBox(
                height: 5,
              ),
              Text("This is a Nice Paint"),
             
                Divider(
                  // thickness of the line
                  indent: 40, // empty space to the leading edge of divider.
                  endIndent: 40,
                  color: Colors.black45,
                ),
            
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Container(
                  height: 190,
                  child:
                    ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 15),
                                height: 100,
                                width: 100,
                                child: Image.network(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvVmaCIuus40EIkFJdltxAOODXGl_QPnm8tA&usqp=CAU",
                                    fit: BoxFit.cover),
                              ),
                              Text("Hi"),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              
            ]));
      }))
    ]);
  }

  productCart(Product product) {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child:
      
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductViewPage(
                            product: product,
                          )));
            },
            child: Container(
              margin: EdgeInsets.only(right: 20, bottom: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(5, 10),
                    blurRadius: 15,
                    color: Colors.grey.shade200,
                  )
                ],
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 150,
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(product.imageURL,
                                  fit: BoxFit.cover)),
                        ),
                        // Add to cart button
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    product.name,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontSize: 18,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "\₹ " + product.price.toString() + '.00',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                        fontSize: 18,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
