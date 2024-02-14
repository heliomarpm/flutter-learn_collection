import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:learn_collection/clock/home_page.dart' as clock;

class Tiles extends StatelessWidget {
  Tiles({super.key});

  Tile item1 = Tile(
    title: "Clock",
    subtitle: "Analog Clock ",
    event: "Interface",
    image: "assets/icons/clock.png",
    page: const clock.HomePage(),
  );

  Tile item2 = Tile(
    title: "Movies",
    subtitle: "Auto Scroll",
    event: "Design",
    image: "assets/icons/movies.png",
    page: null,
  );
  Tile item3 = Tile(
    title: "Locations",
    subtitle: "Lucy Mao going to Office",
    event: "",
    image: "assets/icons/map.png",
    page: null,
  );
  Tile item4 = Tile(
    title: "Activity",
    subtitle: "Rose favirited your Post",
    event: "",
    image: "assets/icons/festival.png",
    page: null,
  );
  Tile item5 = Tile(
    title: "To do",
    subtitle: "Homework, Design",
    event: "4 Items",
    image: "assets/icons/todo.png",
    page: null,
  );
  Tile item6 = Tile(
    title: "Settings",
    subtitle: "",
    event: "2 Items",
    image: "assets/icons/setting.png",
    page: null,
  );

  @override
  Widget build(BuildContext context) {
    List<Tile> tiles = [item1, item2, item3, item4, item5, item6];

    var color = 0xff453658;

    return Flexible(
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        childAspectRatio: 1.0,
        padding: const EdgeInsets.only(left: 16, right: 16),
        children: tiles.map((tile) {
          return Container(
            // tile container
            decoration: BoxDecoration(
                color: Color(color), borderRadius: BorderRadius.circular(10)),
            // tile content
            child: GestureDetector(
              onTap: () {
                // Navegue para a página associada ao tile
                if (tile.page != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => tile.page!),
                  );
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(tile.image, width: 42),
                  const SizedBox(height: 14),
                  Text(
                    tile.title,
                    style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // const SizedBox(height: 5),
                  Text(
                    tile.subtitle,
                    style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                            color: Colors.white38,
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                  // const SizedBox(height: 8),
                  // Text(
                  //   tile.event,
                  //   style: GoogleFonts.openSans(
                  //       textStyle: const TextStyle(
                  //           color: Colors.white70,
                  //           fontSize: 11,
                  //           fontWeight: FontWeight.w600)),
                  // ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget? _getPage(String title) {
    // Mapeie o nome da classe da página para a instância correspondente
    switch (title) {
      case 'Clock':
        return const clock.HomePage();
      // Adicione mais casos conforme necessário para outras páginas
      default:
        return null;
    }
  }
}


class Tile {
  String title;
  String subtitle;
  String event;
  String image;
  // TilePage page;
  Widget? page;

  Tile({
    required this.title,
    required this.subtitle,
    required this.event,
    required this.image,
    this.page,
  });
}