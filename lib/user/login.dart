import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Untuk mengambil inputan
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isPasswordVisible = false; // kontrol tampil/sembunyi password

  // Helper function untuk mendapatkan warna dari kode hex
  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      // PERBAIKAN: Menggunakan String Interpolation
      hexColor = 'FF$hexColor'; 
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  void _validateLogin() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tolong lengkapi semua kolom")),
      );
      return;
    }

    if (!email.endsWith('@gmail.com')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gunakan email yang valid!")),
      );
      return;
    }

    // Jika valid, arahkan ke halaman home
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    // Warna tema: #DD0303
    final Color primaryColor = _getColorFromHex('DD0303');
    // Warna sekunder (untuk gradasi)
    final Color secondaryColor = _getColorFromHex('B00020'); 
    const Color onPrimaryColor = Colors.white; // Teks/Icon di latar belakang
    
    // Warna Kontras Tombol: Emas/Kuning untuk menonjol dari Card putih
    final Color highContrastButtonColor = Colors.amber.shade700; // Tombol Emas Gelap/Kuning
    const Color onButtonColor = Colors.black; // Teks tombol Hitam

    return Scaffold(
      body: Container(
        // Gradien Merah sebagai Latar Belakang
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor,
              secondaryColor,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // --- Judul dan Logo ---
                  const Icon(
                    Icons.lock_person,
                    size: 80,
                    color: onPrimaryColor,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "SELAMAT DATANG",
                    style: TextStyle(
                      fontSize: 14,
                      color: onPrimaryColor,
                    ),
                  ),
                  const Text(
                    "Silahkan Login",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: onPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 50),

                  // --- Input Field Email (Card Putih, ELEVATION RENDAH) ---
                  Card(
                    elevation: 5, // Bayangan dikurangi agar tidak menyaingi tombol
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.email, color: primaryColor),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- Input Field Password (Card Putih, ELEVATION RENDAH) ---
                  Card(
                    elevation: 5, // Bayangan dikurangi
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.lock, color: primaryColor),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: primaryColor,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // --- Tombol Masuk (Warna Emas Kontras, ELEVATION TINGGI) ---
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _validateLogin,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: highContrastButtonColor, // Emas/Kuning
                        elevation: 15, // Bayangan Ditingkatkan agar lebih menonjol
                      ),
                      child: const Text(
                        "Masuk",
                        style: TextStyle(
                          fontSize: 18,
                          color: onButtonColor, // Teks Hitam
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // --- Link Daftar ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Belum punya akun? ",
                        style: TextStyle(color: onPrimaryColor),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: const Text(
                          "Daftar disini",
                          style: TextStyle(
                            color: Colors.yellowAccent, 
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}