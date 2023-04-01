import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:thriftly/data/models/item_listing.dart';
import 'package:thriftly/data/providers/item_listing_provider.dart';
import 'package:thriftly/data/repositories/item_listing_repository.dart';
import 'package:thriftly/logic/item_listing/item_listing_bloc.dart';
import 'package:thriftly/logic/item_listing/item_listing_state.dart';

class ItemListingDetailRedirect extends StatelessWidget {
  final ItemListing itemListing;
  const ItemListingDetailRedirect({Key? key, required this.itemListing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ItemListingBloc(new ItemListingRepository(new ItemListingProvider())),
      child: PostDetailPage(itemListing: itemListing),
    );
  }
}

class PostDetailPage extends StatelessWidget {
  final ItemListing itemListing;
  const PostDetailPage({
    Key? key,
    required this.itemListing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ItemListingBloc, ItemListingState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ItemListingDetail(itemListing: itemListing);
      },
    );
  }
}

class ItemListingDetail extends StatelessWidget {
  final ItemListing itemListing;
  const ItemListingDetail({Key? key, required this.itemListing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _onBackButtonPressed() {
      Navigator.pop(context);
    }

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 10.0, top: 40),
              child: Row(
                children: [
                  SizedBox(
                    height: 35.0,
                    width: 35.0,
                    child: FittedBox(
                      child: FloatingActionButton(
                        backgroundColor: const Color(0xff0BA400),
                        child: Icon(Icons.arrow_back),
                        onPressed: _onBackButtonPressed,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Listing Page",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                itemListing.title,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 15.0, top: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image.network(itemListing.imageUrl),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            DateFormat('MMM dd, yyyy')
                                .format(DateTime.parse(itemListing.createdAt)),
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Item Description: ",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: const Color(0xff0BA400),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3),
                      child: Text(
                        itemListing.description,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      "Contact Seller: ",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: const Color(0xff0BA400),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(itemListing.creator.pfpUrl),
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
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}
