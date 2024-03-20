import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:healthy_apps/main.dart';
import 'package:http/http.dart' as http;
import 'package:healthy_apps/model/model_pegawai.dart';

class PageInsertPegawai extends StatefulWidget {
  @override
  _PageInsertPegawaiState createState() => _PageInsertPegawaiState();
}

class _PageInsertPegawaiState extends State<PageInsertPegawai> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _noBpController = TextEditingController();
  final TextEditingController _noTelpController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  Future<void> _insertPegawai() async {
    try {
      if (_namaController.text.isEmpty ||
          _noBpController.text.isEmpty ||
          _noTelpController.text.isEmpty ||
          _emailController.text.isEmpty) {
        throw Exception('Please fill in all fields');
      }

      Datum newPegawai = Datum(
        id: '', // Atur id sesuai kebutuhan Anda
        nama: _namaController.text,
        noBp: _noBpController.text,
        noTelp: _noTelpController.text,
        email: _emailController.text,
        tglInput: _selectedDate,
      );

      http.Response response = await http.post(
        Uri.parse("http://192.168.100.9/healthyDb/insertPegawai.php"),
        body: {
          'nama': newPegawai.nama,
          'no_bp': newPegawai.noBp,
          'no_telp': newPegawai.noTelp,
          'email': newPegawai.email,
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['isSuccess'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Data pegawai berhasil ditambahkan'),
            ),
          );
          _namaController.clear();
          _noBpController.clear();
          _noTelpController.clear();
          _emailController.clear();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage(initialIndex: 2)),
          );
        } else {
          throw Exception(
              'Failed to insert pegawai: ${responseData['message']}');
        }
      } else {
        throw Exception('Failed to insert pegawai');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to insert pegawai: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Insert Pegawai",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green.shade400,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama'),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _noBpController,
                decoration: InputDecoration(labelText: 'NoBp'),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _noTelpController,
                decoration: InputDecoration(labelText: 'Nomor Telepon'),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _insertPegawai,
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
