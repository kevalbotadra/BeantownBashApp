import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thriftly/data/models/item_listing.dart';
import 'package:thriftly/data/models/outfit_inspo.dart';
import 'package:thriftly/data/providers/item_listing_provider.dart';
import 'package:thriftly/data/repositories/item_listing_repository.dart';
import 'package:thriftly/logic/item_listing/item_listing_bloc.dart';
import 'package:thriftly/logic/item_listing/item_listing_event.dart';
import 'package:thriftly/logic/item_listing/item_listing_state.dart';
import 'package:thriftly/presentation/feed/widgets/post_card.dart';

class FeedRedirect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final itemListingRepository =
        new ItemListingRepository(new ItemListingProvider());

    return Container(
      alignment: Alignment.center,
      child: BlocProvider<ItemListingBloc>(
        create: (context) =>
            ItemListingBloc(itemListingRepository)..add(GetOutfitInspos()),
        child: FeedPage(),
      ),
    );
  }
}

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ItemListingBloc, ItemListingState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is OutfitInsposObtained) {

          return Feed(
            outfitInspos: state.outfitInspos,
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

class Feed extends StatefulWidget {
  final List<OutfitInspo> outfitInspos;
  const Feed({super.key, required this.outfitInspos});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              color: const Color(0xff0BA400),
              child: Padding(
                padding: const EdgeInsets.only(top: 85.0, left: 30),
                child: Text(
                  "Feed",
                  style: GoogleFonts.poppins(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: widget.outfitInspos.length,
                itemBuilder: (context, index) {
                  return PostCard(
                    outfitInspo: widget.outfitInspos[index],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
