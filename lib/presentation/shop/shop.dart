// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thriftly/data/models/item_listing.dart';
import 'package:thriftly/data/providers/item_listing_provider.dart';
import 'package:thriftly/data/repositories/item_listing_repository.dart';
import 'package:thriftly/logic/item_listing/item_listing_bloc.dart';
import 'package:thriftly/logic/item_listing/item_listing_event.dart';
import 'package:thriftly/logic/item_listing/item_listing_state.dart';
import 'package:thriftly/presentation/detail/item_listing.dart';
import 'package:thriftly/presentation/shop/widgets/itemCard.dart';

class ShopRedirect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final itemListingRepository =
        new ItemListingRepository(new ItemListingProvider());

    return Container(
      alignment: Alignment.center,
      child: BlocProvider<ItemListingBloc>(
        create: (context) =>
            ItemListingBloc(itemListingRepository)..add(GetItems()),
        child: ShopPage(),
      ),
    );
  }
}

class ShopPage extends StatelessWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ItemListingBloc, ItemListingState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ItemListingsObtained) {
          return Shop(
            itemListings: state.itemListings,
          );
        }

        if (state is RedirectToItemListingDetail) {
          return ItemListingDetailRedirect(
            itemListing: state.itemListing,
          );
        }
        return Container(
          child: Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}

class Shop extends StatelessWidget {
  final List<ItemListing> itemListings;
  const Shop({super.key, required this.itemListings});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            color: const Color(0xff0BA400),
            child: Padding(
              padding: const EdgeInsets.only(top: 85.0, left: 30),
              child: Text(
                "Shop",
                style: GoogleFonts.poppins(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
              child: CardSwiper(
            isVerticalSwipingEnabled: false,
            isHorizontalSwipingEnabled: true,
            cardsCount: itemListings.length,
            cardBuilder: (context, index) =>
                ItemCard(itemListing: itemListings[index]),
          )),
        ]));
  }
}
