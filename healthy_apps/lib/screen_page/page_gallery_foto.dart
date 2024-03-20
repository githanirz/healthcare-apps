import 'package:flutter/material.dart';
import 'package:healthy_apps/model/model_berita.dart';
import 'package:healthy_apps/screen_page/page_profile.dart';
import 'package:http/http.dart' as http;

class PageGalleryFoto extends StatefulWidget {
  const PageGalleryFoto({super.key});

  @override
  State<PageGalleryFoto> createState() => _PageGalleryFotoState();
}

class _PageGalleryFotoState extends State<PageGalleryFoto> {
  String? id, username;

  @override
  void initState() {
    super.initState();
    getBerita();
  }

  Future<List<Datum>?> getBerita() async {
    try {
      http.Response res = await http
          .get(Uri.parse("http://192.168.100.9/healthyDb/getBerita.php"));
      return modelBeritaFromJson(res.body).data;
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
    return null;
  }

  // Fungsi untuk menampilkan dialog pop-up dengan gambar
  Future<void> _showImageDialog(String imageUrl) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        title: Row(
          children: [
            Text(
              "HealthCare",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 38,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.picture_in_picture_alt_rounded),
                  SizedBox(width: 10),
                  Text(
                    'Gallery Photos HealthCare',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.green.shade400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getBerita(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Datum>?> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      Datum? data = snapshot.data?[index];
                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            _showImageDialog(
                                "http://192.168.100.9/healthyDb/gambar/${data?.gambar}");
                          },
                          child: Card(
                            color: Colors.green.shade100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: ClipRect(
                                    child: Image.network(
                                      "http://192.168.100.9/healthyDb/gambar/${data?.gambar}",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
