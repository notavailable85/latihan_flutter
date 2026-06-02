import 'package:flutter/material.dart';
import 'package:latihan_flutter/safenesia/screens/detail_page.dart';

class SnCatalogPage extends StatefulWidget {
  const SnCatalogPage({super.key});

  @override
  State<SnCatalogPage> createState() => _SnCatalogPageState();
}

class _SnCatalogPageState extends State<SnCatalogPage> {
  final TextEditingController searchController = TextEditingController();

  List categoryList = ["Semua", "K3", "Safety", "Operator", "Medical"];

  int selectedCategory = 0;

  List trainingList = [
    {
      "title": "Pelatihan K3 Umum",
      "category": "K3",
      "price": "Rp 2.500.000",
      "date": "10 Juni 2026",
    },
    {
      "title": "Pelatihan Fire Safety",
      "category": "Safety",
      "price": "Rp 1.500.000",
      "date": "15 Juni 2026",
    },
    {
      "title": "Pelatihan Operator Forklift",
      "category": "Operator",
      "price": "Rp 3.000.000",
      "date": "20 Juni 2026",
    },
    {
      "title": "Pelatihan First Aid",
      "category": "Medical",
      "price": "Rp 1.200.000",
      "date": "25 Juni 2026",
    },
  ];

  List filteredList = [];

  @override
  void initState() {
    super.initState();

    filteredList = trainingList;
  }

  void filterTraining(String keyword) {
    List results = trainingList;

    /// FILTER CATEGORY
    if (selectedCategory != 0) {
      results = results.where((item) {
        return item["category"] == categoryList[selectedCategory];
      }).toList();
    }

    /// FILTER SEARCH
    if (keyword.isNotEmpty) {
      results = results.where((item) {
        final title = item["title"].toString().toLowerCase();

        return title.contains(keyword.toLowerCase());
      }).toList();
    }

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
        title: const Text("Katalog Pelatihan"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Column(
        children: [
          /// SEARCH
          Padding(
            padding: const EdgeInsets.all(16),

            child: TextField(
              controller: searchController,

              onChanged: filterTraining,

              decoration: InputDecoration(
                hintText: "Cari pelatihan...",

                prefixIcon: const Icon(Icons.search),

                suffixIcon: IconButton(
                  onPressed: () {
                    searchController.clear();

                    filterTraining("");
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

          /// CATEGORY
          SizedBox(
            height: 50,

            child: ListView.builder(
              scrollDirection: Axis.horizontal,

              itemCount: categoryList.length,

              itemBuilder: (context, index) {
                final isSelected = selectedCategory == index;

                return Padding(
                  padding: const EdgeInsets.only(left: 16),

                  child: ChoiceChip(
                    label: Text(categoryList[index]),

                    selected: isSelected,

                    onSelected: (value) {
                      setState(() {
                        selectedCategory = index;
                      });

                      filterTraining(searchController.text);
                    },

                    selectedColor: Colors.blue,

                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          /// LIST
          Expanded(
            child: filteredList.isEmpty
                ? const Center(child: Text("Pelatihan tidak ditemukan"))
                : ListView.builder(
                    itemCount: filteredList.length,

                    itemBuilder: (context, index) {
                      final item = filteredList[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),

                        child: Container(
                          padding: const EdgeInsets.all(16),

                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.circular(18),

                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                color: Colors.grey.shade300,
                              ),
                            ],
                          ),

                          child: Row(
                            children: [
                              /// IMAGE
                              Container(
                                height: 80,
                                width: 80,

                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,

                                  borderRadius: BorderRadius.circular(15),
                                ),

                                child: const Icon(
                                  Icons.school,
                                  size: 40,
                                  color: Colors.blue,
                                ),
                              ),

                              const SizedBox(width: 15),

                              /// CONTENT
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text(
                                      item["title"],

                                      style: const TextStyle(
                                        fontSize: 18,

                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 5),

                                    Text(
                                      item["category"],

                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),

                                    const SizedBox(height: 10),

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

                                    const SizedBox(height: 10),

                                    Text(
                                      item["price"],

                                      style: const TextStyle(
                                        color: Colors.blue,

                                        fontWeight: FontWeight.bold,

                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              /// BUTTON
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SnDetailPage(
                                        title: "Pelatihan K3 Umum",
                                        category: "K3",
                                        price: "Rp 2.500.000",
                                        date: "10 Juni 2026",
                                      ),
                                    ),
                                  );
                                },

                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),

                                child: const Text(
                                  "Daftar",

                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
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
