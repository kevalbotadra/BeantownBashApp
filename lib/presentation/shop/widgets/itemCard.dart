import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thriftly/data/models/item_listing.dart';
import 'package:thriftly/logic/item_listing/item_listing_bloc.dart';
import 'package:thriftly/logic/item_listing/item_listing_event.dart';
import 'package:thriftly/presentation/detail/item_listing.dart';

class ItemCard extends StatelessWidget {
  final ItemListing itemListing;
  const ItemCard({super.key, required this.itemListing});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ItemListingDetail(itemListing: itemListing)));
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  itemListing.imageUrl,
                  height: 500,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                )),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  itemListing.title + " (${itemListing.size})",
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  r"$" + "${itemListing.price}",
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 20,
                    color: Colors.green,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(itemListing.creator.pfpUrl),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      itemListing.creator.name,
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                Text(
                  itemListing.creator.phoneNumber.replaceAllMapped(
                      RegExp(r'(\d{3})(\d{3})(\d+)'),
                      (Match m) => "(${m[1]}) ${m[2]}-${m[3]}"),
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
