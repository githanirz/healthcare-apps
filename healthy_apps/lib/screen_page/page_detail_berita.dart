import 'package:flutter/material.dart';
import 'package:healthy_apps/model/model_berita.dart';
import 'package:intl/intl.dart';

class PageDetailBerita extends StatelessWidget {
  final Datum? data;

  const PageDetailBerita(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Detail Berita",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
        backgroundColor: Colors.green.shade400,
      ),
      body: ListView(
        children: [
          Padding(
              padding: EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  "http://192.168.100.9/healthyDb/gambar/${data?.gambar}",
                  fit: BoxFit.fill,
                ),
              )),
          ListTile(
            title: Text(
              data?.judul ?? "",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.green),
            ),
            subtitle: Text(
              DateFormat().format(data?.tglBerita ?? DateTime.now()),
            ),
            // trailing: const Icon(
            //   Icons.star,
            //   color: Colors.red,
            // ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 16, bottom: 16, left: 16),
            child: Text(
              data?.konten ?? "",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
