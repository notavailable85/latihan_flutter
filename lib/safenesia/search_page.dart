import 'package:flutter/material.dart';

class SnSearchPage extends StatefulWidget {
  final String keyword;
  const SnSearchPage({super.key, required this.keyword});

  @override
  State<SnSearchPage> createState() => _SnSearchPageState();
}

class _SnSearchPageState extends State<SnSearchPage> {
  final TextEditingController searchController = TextEditingController();

  List trainingList = [
    {
      "title": "Pelatihan K3 Umum",
      "category": "Kemnaker RI",
      "date": "10 Juni 2026",
    },
    {
      "title": "Pelatihan Fire Safety",
      "category": "Safety Training",
      "date": "15 Juni 2026",
    },
    {
      "title": "Pelatihan Ahli K3 Listrik",
      "category": "Kemnaker RI",
      "date": "20 Juni 2026",
    },
    {
      "title": "Pelatihan First Aid",
      "category": "Medical Training",
      "date": "25 Juni 2026",
    },
    {
      "title": "Pelatihan Operator Forklift",
      "category": "Operator Training",
      "date": "30 Juni 2026",
    },
  ];

  List filteredList = [];

  @override
  void initState() {
    super.initState();
    searchController.text = widget.keyword;
    searchTraining(widget.keyword);

    filteredList = trainingList;
  }

  void searchTraining(String keyword) {
    final results = trainingList.where((item) {
      final title = item["title"].toString().toLowerCase();

      final category = item["category"].toString().toLowerCase();

      final input = keyword.toLowerCase();

      return title.contains(input) || category.contains(input);
    }).toList();

    setState(() {
      filteredList = results;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("Search"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Column(
        children: [
          /// SEARCH FIELD
          Padding(
            padding: const EdgeInsets.all(16),

            child: TextField(
              controller: searchController,

              onChanged: searchTraining,

              decoration: InputDecoration(
                hintText: "Cari pelatihan...",
                prefixIcon: const Icon(Icons.search),

                suffixIcon: IconButton(
                  onPressed: () {
                    searchController.clear();

                    searchTraining("");
                  },

                  icon: const Icon(Icons.close),
                ),

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),

                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          /// RESULT
          Expanded(
            child: filteredList.isEmpty
                ? const Center(
                    child: Text(
                      "Pelatihan tidak ditemukan",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredList.length,

                    itemBuilder: (context, index) {
                      final item = filteredList[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),

                        child: Card(
                          elevation: 2,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),

                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(10),

                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,

                                borderRadius: BorderRadius.circular(10),
                              ),

                              child: const Icon(
                                Icons.school,
                                color: Colors.blue,
                              ),
                            ),

                            title: Text(
                              item["title"],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                const SizedBox(height: 5),

                                Text(item["category"]),

                                const SizedBox(height: 5),

                                Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_today,
                                      size: 16,
                                      color: Colors.blue,
                                    ),

                                    const SizedBox(width: 5),

                                    Text(item["date"]),
                                  ],
                                ),
                              ],
                            ),

                            trailing: ElevatedButton(
                              onPressed: () {},

                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),

                              child: const Text(
                                "Daftar",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
