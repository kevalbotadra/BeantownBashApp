import 'package:flutter/material.dart';
import 'package:thriftly/data/models/Item.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemPreview extends StatelessWidget {
  final Item item;

  const ItemPreview({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0.0),
              fixedSize: const Size(190, 290),
              primary: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)))),
          onPressed: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  width: 200,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0)),
                    child: Image.network(
                        fit: BoxFit.cover,
                        item.imageUrl),
                  )),
              const SizedBox(height: 10.0),
              Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(children: <Widget>[
                    Text(
                      item.title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.beVietnamPro(
                        color: Colors.black,
                        letterSpacing: 1.0,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "Size: " + item.size,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.beVietnamPro(
                        color: Colors.grey[600],
                        letterSpacing: 1.0,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      r"Price: $" + item.price,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.beVietnamPro(
                        color: Color.fromARGB(255, 28, 178, 43),
                        letterSpacing: 1.0,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ])),
            ],
          )),
    );
  }
}
