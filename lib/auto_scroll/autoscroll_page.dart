import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AutoScrollPage extends StatefulWidget {
  const AutoScrollPage({super.key});

  @override
  State<AutoScrollPage> createState() => _AutoScrollPageState();
}

class _AutoScrollPageState extends State<AutoScrollPage> {
  ScrollController scrollController = ScrollController();

  List<String> assets = [
    'assets/posters/poster-01.png',
    'assets/posters/poster-02.png',
    'assets/posters/poster-03.png',
    'assets/posters/poster-04.png',
    'assets/posters/poster-05.png',
    'assets/posters/poster-06.png',
    'assets/posters/poster-07.png',
    'assets/posters/poster-08.png',
    'assets/posters/poster-09.png',
  ];

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(seconds: assets.length * 2), curve: Curves.linear);
    });

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            SizedBox(
              width: size.width,
              height: size.height,
              child: StaggeredGridView.countBuilder(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                crossAxisCount: 4,
                itemCount: assets.length,
                itemBuilder: (BuildContext context, int index) {
                  return Image(
                    image: AssetImage(assets[index]),
                    fit: BoxFit.cover,
                  );
                },
                staggeredTileBuilder: (int index) =>
                    StaggeredTile.count(2, index.isEven ? 4 : 2),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0),
                      Colors.black.withOpacity(0),
                      Colors.black.withOpacity(0),
                      Colors.black.withOpacity(0.9),
                      Colors.black.withOpacity(1),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.02),
                      child: FadeInUp(
                        child: Text(
                          "The 30 Most Stunning Movie\nPosters of 2019",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.actor(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(height: size.height * 0.025),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.pushReplacement(
                    //       context,
                    //       CupertinoPageRoute(
                    //         builder: (ctx) => const HomePage(),
                    //       ),
                    //     );
                    //   },
                    //   child: FadeInUp(
                    //     delay: const Duration(milliseconds: 500),
                    //     child: const CircleAvatar(
                    //       radius: 40,
                    //       backgroundImage: AssetImage("asset/100.jpg"),
                    //     ),
                    //   ),
                    // ),
                    // FadeInUp(
                    //   delay: const Duration(milliseconds: 700),
                    //   child: Text(
                    //     "Zack Sharf",
                    //     style: GoogleFonts.actor(
                    //         color: Colors.white, fontSize: 17),
                    //   ),
                    // ),
                    // FadeInUp(
                    //   delay: const Duration(milliseconds: 900),
                    //   child: Text(
                    //     "Dec 12, 2019 11:00 am",
                    //     style: GoogleFonts.actor(
                    //         color: Colors.grey[300], fontSize: 15),
                    //   ),
                    // ),
                    // FadeInUp(
                    //   delay: const Duration(milliseconds: 1000),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       const Icon(
                    //         Icons.person,
                    //         color: Colors.grey,
                    //       ),
                    //       Text(
                    //         "@zsharf",
                    //         style: GoogleFonts.actor(
                    //             color: Colors.grey, fontSize: 15),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(height: size.height * 0.03),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
