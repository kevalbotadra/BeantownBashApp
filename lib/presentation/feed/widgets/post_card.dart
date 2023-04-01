import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:thriftly/data/models/outfit_inspo.dart';

class PostCard extends StatelessWidget {
  final OutfitInspo outfitInspo;
  const PostCard({Key? key, required this.outfitInspo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(13),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          outfitInspo.creator.pfpUrl),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(outfitInspo.creator.name,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black,
                        )),
                  ],
                ),
                Icon(
                  Icons.more_horiz_outlined,
                  color: const Color(0xff0BA400),
                ),
              ]),
              SizedBox(
                height: 6,
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    outfitInspo.imageUrl,
                    // height: 300,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  )),
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(outfitInspo.caption,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black,
                      )),
                  Image.asset("assets/images/arrow-right-green.png",
                      height: 20, width: 20)
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                DateFormat('MMM dd, yyyy h:mm a')
                    .format(DateTime.parse(outfitInspo.createdAt)),
                style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                    color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
