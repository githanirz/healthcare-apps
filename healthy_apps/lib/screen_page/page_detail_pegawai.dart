import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import package untuk format tanggal
import 'package:healthy_apps/model/model_pegawai.dart';

class PageDetailPegawai extends StatelessWidget {
  final Datum? data;

  const PageDetailPegawai(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Detail Pegawai",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.green.shade400,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width *
              0.8, // Lebar container 80% dari lebar layar
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade200, // Warna latar belakang container
            borderRadius:
                BorderRadius.circular(15.0), // Sudut container dibulatkan
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                leading: Icon(
                  Icons.account_circle,
                  color: Colors.green,
                  size: 40,
                ),
                title: Text(
                  "Nama: ${data?.nama ?? ""}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                subtitle: Text(
                  "NoBp: ${data?.noBp ?? ""}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              ListTile(
                title: Text(
                  "Nomor Telepon: ${data?.noTelp ?? ""}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                subtitle: Text(
                  "Email: ${data?.email ?? ""}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              ListTile(
                title: Text(
                  "Tanggal Input: ${DateFormat('dd/MM/yyyy').format(data?.tglInput ?? DateTime.now())}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
