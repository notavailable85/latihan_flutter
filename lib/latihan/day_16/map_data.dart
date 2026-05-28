import 'package:flutter/material.dart';
import 'package:latihan_flutter/data/hiragana_list.dart';

class MapData extends StatefulWidget {
  const MapData({super.key});

  @override
  State<MapData> createState() => _MapDataState();
}

class _MapDataState extends State<MapData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Expanded(
        //   child: ListView.builder(
        //     shrinkWrap: true,
        //     itemCount: hiraganaList.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       print(index);
        //       return ListTile(
        //         title: Text(
        //           hiraganaList[index]["character"],
        //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        //         ),
        //       );
        //     },
        //   ),
        // ),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(8),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: hiraganaList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: index % 2 == 0 ? Colors.blue : Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      hiraganaList[index]["character"],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      hiraganaList[index]["romaji"],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      hiraganaList[index]["pronunciation"],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
