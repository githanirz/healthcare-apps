import 'package:flutter/material.dart';
import 'package:healthy_apps/model/model_berita.dart';
import 'package:healthy_apps/screen_page/page_detail_berita.dart';
import 'package:healthy_apps/screen_page/page_profile.dart';
import 'package:http/http.dart' as http;

class PageListBerita extends StatefulWidget {
  const PageListBerita({Key? key}) : super(key: key);

  @override
  State<PageListBerita> createState() => _PageListBeritaState();
}

class _PageListBeritaState extends State<PageListBerita> {
  String? id, username;
  late Future<List<Datum>?> _futureHealthy;
  late List<Datum> _healthyData = [];
  late List<Datum> _searchResult = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _futureHealthy = getBerita();
    _futureHealthy.then((value) {
      if (value != null) {
        setState(() {
          _healthyData = value;
        });
      }
    });
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

  void _filterSearchResults(String query) {
    List<Datum> searchResults = [];
    if (query.isNotEmpty) {
      _healthyData.forEach((datum) {
        if (datum.judul.toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(datum);
        }
      });
    }
    setState(() {
      _searchResult = searchResults;
    });
  }

  void _navigateToDetail(Datum data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PageDetailBerita(data),
      ),
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
                Icons.account_circle, // Ikona pengguna bulat
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
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "gambar/doctor.png",
                  width: 120,
                  height: 120,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "How do you feel?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    SizedBox(
                      width: 250,
                      child: Text(
                        "Fill out your medical right now!",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              "Life Updates On Healthcare",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade300,
              ),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 500,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      _filterSearchResults(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search Berita..',
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: FutureBuilder(
              future: _futureHealthy,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Datum>?> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.green),
                  );
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: _searchResult.isNotEmpty
                        ? _searchResult.length
                        : _healthyData.length,
                    itemBuilder: (context, index) {
                      Datum data = _searchResult.isNotEmpty
                          ? _searchResult[index]
                          : _healthyData[index];
                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            _navigateToDetail(data);
                          },
                          child: Card(
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: ClipRect(
                                    child: Image.network(
                                      "http://192.168.100.9/healthyDb/gambar/${data.gambar}",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    "${data.judul}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                  subtitle: Text(
                                    '${data.konten}',
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade900),
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
                    child: CircularProgressIndicator(color: Colors.green),
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
