import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:space_app/main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Uygulama logosu
                Image.asset('assets/logo.png'),
                SizedBox(height: 20.0),
                // E-posta metin girişi
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'E-posta Adresi',
                  ),
                ),
                SizedBox(height: 10.0),
                // Şifre metin girişi
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Şifre',
                  ),
                ),
                SizedBox(height: 20.0),
                // Giriş butonu
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      // Giriş başarılıysa ana sayfaya yönlendir
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                      );
                    } on FirebaseAuthException catch (e) {
                      _showErrorDialog(context, e.code);
                    }
                  },
                  child: Text('Giriş Yap'),
                ),
                SizedBox(height: 10.0),
                // Kayıt ol bağlantısı
                TextButton(
                  onPressed: () {
                    // Kayıt sayfasına yönlendir
                  },
                  child: Text('Kayıt Ol'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String errorCode) {
    String errorMessage;

    switch (errorCode) {
      case 'user-not-found':
        errorMessage = 'Kullanıcı bulunamadı.';
        break;
      case 'wrong-password':
        errorMessage = 'Hatalı şifre.';
        break;
      default:
        errorMessage = 'Bir hata oluştu.';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hata'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tamam'),
            ),
          ],
        );
      },
    );
  }
}
