import 'package:flutter/material.dart';
import 'package:healthy_apps/screen_page/page_gallery_foto.dart';
import 'package:healthy_apps/screen_page/page_list_berita.dart';
import 'package:healthy_apps/screen_page/page_list_pegawai.dart';
import 'package:healthy_apps/screen_page/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HealthCare_apps',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade300),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  final int initialIndex; // Tambahkan initialIndex
  const HomePage({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> body = const [
    Icon(Icons.home_filled),
    Icon(Icons.menu_open),
    Icon(Icons.person_2),
  ];

  final screen = [
    const PageListBerita(),
    const PageGalleryFoto(),
    const PageListPegawai()
  ];
  @override
  void initState() {
    super.initState();
    _currentIndex = widget
        .initialIndex; // Atur _currentIndex dengan initialIndex dari widget
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: " Home "),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt_rounded), label: " Gallery "),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: " Employee "),
        ],
      ),
    );
  }
}
