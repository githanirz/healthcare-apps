import 'package:flutter/material.dart';
import 'package:healthy_apps/main.dart';
import 'package:healthy_apps/model/model_login.dart';
import 'package:healthy_apps/screen_page/register_screen.dart';
import 'package:healthy_apps/utils/cek_session.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  bool isLoading = false;

  Future<ModelLogin?> loginAccount() async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response res = await http
          .post(Uri.parse("http://192.168.100.9/healthyDb/login.php"), body: {
        "username": username.text,
        "password": password.text,
      });
      ModelLogin data = modelLoginFromJson(res.body);

      if (data.value == 1) {
        setState(() {
          isLoading = false;

          session.saveSession(
              data.value ?? 0,
              data.id ?? "",
              data.username ?? "",
              data.email ?? ""); // Tambahkan pemanggilan saveSession di sini

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("${data.message}")));
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false);
        });
      } else if (data.value == 2) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("${data.message}")));
        });
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("${data.message}")));
        });
      }
      if (data.email != null) {
        session.saveSession(
          data.value ?? 0,
          data.id ?? "",
          data.username ?? "",
          data.email!,
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: keyForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    "gambar/healthy.png",
                    width: 150,
                    height: 150,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "Login To App HealthCare",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade300),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: username,
                  validator: (val) {
                    return val!.isEmpty ? "tidak boleh kosong" : null;
                  },
                  decoration: InputDecoration(
                      hintText: "USERNAME",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.greenAccent.withOpacity(0.2)),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  obscureText: true,
                  controller: password,
                  validator: (val) {
                    return val!.isEmpty ? "tidak boleh kosong" : null;
                  },
                  decoration: InputDecoration(
                      hintText: "PASSWORD",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.greenAccent.withOpacity(0.2)),
                ),
                const SizedBox(
                  height: 25,
                ),
                Center(
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : MaterialButton(
                            minWidth: 150,
                            height: 45,
                            color: Colors.green.shade400,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  30), // Atur nilai sesuai keinginan
                            ),
                            onPressed: () {
                              if (keyForm.currentState?.validate() == true) {
                                loginAccount();
                              }
                            },
                            child: Text("LOGIN"),
                          )),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: const BorderSide(width: 1, color: Colors.green)),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const RegisterScreen()),
                (route) => false);
          },
          child: const Text("Anda belum punya akun silahkan daftar"),
        ),
      ),
    );
  }
}
