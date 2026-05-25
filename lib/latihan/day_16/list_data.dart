import 'package:flutter/material.dart';

class ListData extends StatefulWidget {
  const ListData({super.key});

  @override
  State<ListData> createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  final List<String> namaBuah = ["Apel", "Nanas", "Anggur", "Durian", "Kiwi"];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: namaBuah.length,
          itemBuilder: (BuildContext context, int index) {
            print(index);
            return Text(namaBuah[index]);
          },
        ),
      ],
    );
  }
}
