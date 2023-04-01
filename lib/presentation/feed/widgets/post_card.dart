import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  const PostCard({Key? key}) : super(key: key);

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
                      backgroundImage: NetworkImage("http://gossipsinside.com/wp-content/uploads/2022/12/Duke-Dennis-Bio-Age-Height-YouTube-Channels-Net-Worth-Girlfriends-Gossipsinside.com_.jpg"),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text("Keval Botadra",
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
                    "https://www.stylebysavina.com/wp-content/uploads/2022/12/classy-chic-outfits-500x500.png",
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
                  Text("My new beige pants!",
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
                "March 23, 2022",
                // DateFormat('MMM dd, yyyy h:mm a')
                //     .format(DateTime.parse(post.createdAt)),
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
