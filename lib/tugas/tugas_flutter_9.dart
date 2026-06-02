import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// // =====================================
// // MAIN APP
// // =====================================
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'ATK Store',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const HomePage(),
//     );
//   }
// }

// =====================================
// HOME PAGE
// =====================================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kategori Alat Tulis Kantor'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Level 1'),
              Tab(text: 'Level 2'),
              Tab(text: 'Level 3'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [Level1Page(), Level2Page(), Level3Page()],
        ),
      ),
    );
  }
}

// =====================================
// LEVEL 1
// LIST<String>
// =====================================
class Level1Page extends StatelessWidget {
  const Level1Page({super.key});

  final List<String> categories = const [
    'Pulpen',
    'Pensil',
    'Penghapus',
    'Buku Tulis',
    'Spidol',
    'Map Folder',
    'Penggaris',
    'Stapler',
    'Kertas HVS',
    'Tip-X',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.edit),
          title: Text(categories[index]),
        );
      },
    );
  }
}

// =====================================
// LEVEL 2
// LIST<MAP>
// =====================================
class Level2Page extends StatelessWidget {
  const Level2Page({super.key});

  final List<Map<String, dynamic>> items = const [
    {'name': 'Pulpen', 'icon': Icons.edit},
    {'name': 'Pensil', 'icon': Icons.create},
    {'name': 'Penghapus', 'icon': Icons.auto_fix_normal},
    {'name': 'Buku Tulis', 'icon': Icons.book},
    {'name': 'Spidol', 'icon': Icons.brush},
    {'name': 'Map Folder', 'icon': Icons.folder},
    {'name': 'Penggaris', 'icon': Icons.straighten},
    {'name': 'Stapler', 'icon': Icons.build},
    {'name': 'Kertas HVS', 'icon': Icons.description},
    {'name': 'Tip-X', 'icon': Icons.cleaning_services},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            leading: Icon(items[index]['icon'], color: Colors.blue),
            title: Text(items[index]['name']),
          ),
        );
      },
    );
  }
}

// =====================================
// LEVEL 3
// MODEL CLASS + CUSTOM CARD
// =====================================

class Product {
  final String name;
  final String image;
  final String description;

  const Product({
    required this.name,
    required this.image,
    required this.description,
  });
}

class Level3Page extends StatelessWidget {
  const Level3Page({super.key});

  final List<Product> products = const [
    Product(
      name: 'Pulpen Premium',
      image:
          'https://i5.walmartimages.com/seo/Wordsworth-Black-Fountain-Pen-Fine-Point-Ink-Pens-Black-Gold-Refillable-Calligraphy_e3189d1c-7f82-4d60-8bd3-8c218a2eb87e.3dac867ab94847e4a55b18e7c91eb2ba.jpeg',
      description: 'Pulpen berkualitas tinggi untuk kebutuhan kantor.',
    ),
    Product(
      name: 'Pensil 2B',
      image:
          'https://philang.com/storage/products/joyko/8dcea743-86c9-4903-bb19-09da06ce23c0.jpg',
      description: 'Pensil nyaman digunakan untuk menulis dan menggambar.',
    ),
    Product(
      name: 'Buku Catatan',
      image:
          'https://down-id.img.susercontent.com/file/3bc67e04f5697b42a39866ef43192222',
      description: 'Buku catatan dengan kertas tebal dan berkualitas.',
    ),
    Product(
      name: 'Spidol Warna',
      image:
          'https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full//catalog-image/89/MTA-102093135/no-brand_80-pcs-spidol-gambar-warna-warni-1-set-lengkap-murah-lukis-art-anak_full05.jpg',
      description: 'Spidol warna cerah cocok untuk presentasi.',
    ),
    Product(
      name: 'Map Dokumen',
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXHZTYqw75XChuWexXfF5Rd4EpzEsuEs8mNw&s',
      description: 'Map folder untuk menyimpan dokumen penting.',
    ),
    Product(
      name: 'Stapler Mini',
      image:
          'https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full/catalog-image/99/MTA-181881252/brd-44261_staples-stapler-mini-kecil-set-unik-lucu-bonus-isi-atk-portable-alat-penjepret-kertas-mini-free-refill-1-baris-isi-ulang-no-10-10-1m-unik-lucu_full01-dbe61a16.jpg',
      description: 'Stapler kecil praktis untuk penggunaan sehari-hari.',
    ),
    Product(
      name: 'Kertas HVS A4',
      image:
          'https://www.oscarliving.co.id/cdn/shop/files/kertas-kertas-hvs-a4-paper-one-75gsm-1-rim-paper-one-shopname-8754171.jpg?v=1766529555&width=800',
      description: 'Kertas HVS putih berkualitas untuk printer.',
    ),
    Product(
      name: 'Penghapus Putih',
      image:
          'https://s.alicdn.com/@sc04/kf/Hb00808f7b9cd451ebcde4598c70194a3j/Rectangular-White-Rubber-Eraser-School-Stationery-Kids-Student-Soft-Small-2B-HB-Pencil-Erasers.jpg_300x300.jpg',
      description: 'Penghapus lembut tanpa merusak kertas.',
    ),
    Product(
      name: 'Penggaris 30cm',
      image:
          'https://down-id.img.susercontent.com/file/id-11134207-7r98y-lp4v1iqhfudqcb',
      description: 'Penggaris transparan akurat dan tahan lama.',
    ),
    Product(
      name: 'Tip-X Cair',
      image: 'https://parto.id/asset/foto_produk/kenko2.jpg',
      description: 'Koreksi tulisan dengan cepat dan rapi.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}

// =====================================
// CUSTOM WIDGET CARD
// =====================================

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                product.image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
