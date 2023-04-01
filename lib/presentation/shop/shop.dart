// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thriftly/data/models/Item.dart';
import 'package:thriftly/presentation/shop/widgets/item_preview.dart';

class Shop extends StatelessWidget {
  final List<Item> items;
  const Shop({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 135,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 28, 178, 43),
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(157, 63, 0, 0),
                  child: Text("Shop",
                      style: GoogleFonts.beVietnamPro(
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 1,
                      )),
                ),
              ),
              SizedBox(height: 25),
              items.length > 0
                  ? Container(
                      height: 300,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return ItemPreview(
                            item: items[index],
                          );
                        },
                      ),
                    )
                  : Text("No Items Found"),
            ],
          ),
        ));
  }
}
