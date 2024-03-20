import 'package:flutter/material.dart';
import 'package:healthy_apps/model/model_edit_user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PageEditProfile extends StatefulWidget {
  const PageEditProfile({Key? key}) : super(key: key);

  @override
  State<PageEditProfile> createState() => _PageEditProfileState();
}

class _PageEditProfileState extends State<PageEditProfile> {
  TextEditingController txtUsername = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  bool isLoading = false;
  String? id, username;

  @override
  void initState() {
    super.initState();
    getSession();
  }

  Future<void> getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id");
      username = pref.getString("username");
      txtUsername.text = username ?? '';
    });
  }

  Future<ModelEditUser?> updateUsername(String newUsername) async {
    try {
      setState(() {
        isLoading = true;
      });

      final response = await http.post(
        Uri.parse('http://192.168.100.9/healthyDb/updateUser.php'),
        body: {
          "id": id!,
          "username": newUsername,
        },
      );

      ModelEditUser data = modelEditUserFromJson(response.body);

      if (data.value == 1) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${data.message}'),
        ));
        Navigator.pop(context, newUsername);
      } else if (data.value == 2) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${data.message}'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit User',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Form(
            key: keyForm,
            child: Column(
              children: [
                TextFormField(
                  controller: txtUsername,
                  validator: (val) {
                    return val!.isEmpty ? "Tidak boleh kosong" : null;
                  },
                  decoration: InputDecoration(
                    labelText: "Username",
                    hintText: "Masukkan username baru",
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Colors.blue.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                MaterialButton(
                  onPressed: () {
                    if (keyForm.currentState?.validate() == true) {
                      final newUsername = txtUsername.text.trim();
                      updateUsername(newUsername);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Silakan isi data terlebih dahulu"),
                      ));
                    }
                  },
                  color: Colors.green,
                  textColor: Colors.white,
                  height: 50,
                  child: const Text("Update"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
