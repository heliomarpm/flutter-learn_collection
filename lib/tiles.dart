import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'models/tile_modal.dart';
import 'repository/data_reader.dart';
import 'date_picker/datepicker_page.dart';
import 'circle_progress/progress_page.dart';
import 'auto_scroll/autoscroll_page.dart';
import 'clock/clock_page.dart';
import 'flatcalculator/flat_calculator.dart';

class Tiles extends StatefulWidget {
  const Tiles({super.key});

  @override
  State<Tiles> createState() => _TilesState();
}

class _TilesState extends State<Tiles> {
  List<Tile> _tiles = [];

  @override
  void initState() {
    getTiles();
    super.initState();
  }

  Future<void> getTiles() async {
    Map data = await DataReader.getJson();

    List<Tile> tiles = List<Map<String, dynamic>>.from(data['tiles'])
        .map((tileData) => Tile.fromMap(tileData))
        .toList();

    setState(() {
      _tiles = tiles;
    });
  }

  @override
  Widget build(BuildContext context) {
    var color = 0xff453658;

    return Flexible(
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        childAspectRatio: 1.0,
        padding: const EdgeInsets.only(left: 16, right: 16),
        children: _tiles.map((tile) {
          Widget? page = _getPage(tile.title);

          return GestureDetector(
            onTap: () {
              // Navegue para a página associada ao tile
              if (page != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => page),
                );
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Color(color),
                  borderRadius: BorderRadius.circular(10)),
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
                  //   tile.type,
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
        return const ClockPage();
      case 'Movies':
        return const AutoScrollPage();
      case 'Date Picker':
        return const DatePickerPage();
      case 'Progress':
        return const ProgressPage();
      case 'Calculator':
        return const FlatCalculatorPage();
      default:
        return null;
    }
  }
}
