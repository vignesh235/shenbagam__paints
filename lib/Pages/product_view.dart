//Sample product view page..... Not yet Implemented...

import 'package:flutter/material.dart';
import 'package:shenbagam_paints/models/products.dart';

class ProductViewPage extends StatefulWidget {
  final Product product;
  const ProductViewPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductViewPageState createState() => _ProductViewPageState();
}

class _ProductViewPageState extends State<ProductViewPage> {
  List<dynamic> productList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: MediaQuery.of(context).size.height * 0.6,
          elevation: 0,
          snap: true,
          floating: true,
          stretch: true,
          backgroundColor: Colors.grey.shade50,
          flexibleSpace: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.zoomBackground,
              ],
              background: Image.network(
                widget.product.imageURL,
                fit: BoxFit.cover,
              )),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: Transform.translate(
                offset: Offset(0, 1),
                child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Center(
                      child: Container(
                    width: 50,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )),
                ),
              )),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Container(
              height: MediaQuery.of(context).size.height * 0.1,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.product.brand,
                            style: TextStyle(
                              color: Colors.orange.shade400,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\₹ " + widget.product.price.toString() + '.00',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                  Text("Lorem Ipsum is simply dummy text of the printing"),
                ],
              ))
        ])),
      ]),
    );
  }
}
