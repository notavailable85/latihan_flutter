import 'package:flutter/material.dart';
import 'package:latihan_flutter/constant/hiragana_datawithmodel.dart';

class ListWithModelData extends StatefulWidget {
  const ListWithModelData({super.key});

  @override
  State<ListWithModelData> createState() => _ListWithModelDataState();
}

class _ListWithModelDataState extends State<ListWithModelData> {
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
            itemCount: hiraganaListWithModel.length,
            itemBuilder: (BuildContext context, int index) {
              final data = hiraganaListWithModel[index];
              return Container(
                color: index % 2 == 0 ? Colors.blue : Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data.character,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      data.romaji,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      data.pronunciation,
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
