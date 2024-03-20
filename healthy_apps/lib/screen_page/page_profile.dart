import 'package:flutter/material.dart';
import 'package:healthy_apps/screen_page/login_screen.dart';
import 'package:healthy_apps/screen_page/page_edit_profile.dart';
import 'package:healthy_apps/utils/cek_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  String? id, username, email;

  @override
  void initState() {
    super.initState();
    getSession();
  }

  @override
  void didUpdateWidget(ProfilScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    getSession();
  }

  Future<void> getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id");
      username = pref.getString("username");
      email = pref.getString("email");
      print(id);
      print(username);
      print(email);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    'gambar/doctor.png'), // Ganti dengan gambar avatar pengguna
              ),
              SizedBox(height: 20),
              Text(
                '$username', //$username
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '$email',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final newUsername = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PageEditProfile()));
                  if (newUsername != null) {
                    // Data berhasil diupdate, perbarui data profil
                    session.updateUsername(newUsername);
                    getSession(); // Perbarui data profil di halaman ProfilScreen
                  }
                },
                child: Text('Edit Profile'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    session.clearSession();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false);
                  });
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
