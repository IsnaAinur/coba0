import 'package:flutter/material.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isPasswordVisible = false; // status untuk menampilkan/sembunyikan password

  // Helper function untuk mendapatkan warna dari kode hex
  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      // PERBAIKAN: Menggunakan String Interpolation untuk menghindari lint warning
      hexColor = 'FF$hexColor';
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  void _validateRegister() {
    String username = usernameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
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

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Pendaftaran Berhasil")),
    );

    // Jika semua valid, mengarah ke halaman Home
    // Menggunakan pushReplacement untuk konsistensi navigasi setelah pendaftaran
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    // Warna tema: #DD0303
    final Color primaryColor = _getColorFromHex('DD0303');
    // Warna sekunder (untuk gradasi)
    final Color secondaryColor = _getColorFromHex('B00020'); 
    const Color onPrimaryColor = Colors.white; // Teks/Icon di latar belakang
    
    // Warna Kontras Tombol: Emas/Kuning
    final Color highContrastButtonColor = Colors.amber.shade700; 
    const Color onButtonColor = Colors.black; // Teks tombol Hitam

    return Scaffold(
      // Container dengan Gradien Merah sebagai Latar Belakang
      body: Container(
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
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Tombol Kembali (Pengganti AppBar) ---
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: onPrimaryColor),
                    onPressed: () {
                      Navigator.pop(context); // Kembali ke halaman Login
                    },
                  ),
                  const SizedBox(height: 10),

                  // --- Judul dan Logo ---
                  const Center(
                    child: Icon(
                      Icons.person_add_alt_1, // Ikon pendaftaran
                      size: 80,
                      color: onPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      "Buat Akun Baru",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: onPrimaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),

                  // --- Input Field Username (Card Putih) ---
                  Card(
                    elevation: 5, 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          labelText: "Username",
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.person, color: primaryColor),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- Input Field Email (Card Putih) ---
                  Card(
                    elevation: 5, 
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

                  // --- Input Field Password (Card Putih) ---
                  Card(
                    elevation: 5, 
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
                  const SizedBox(height: 40),

                  // --- Tombol Daftar (Warna Emas Kontras Maksimal) ---
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _validateRegister,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: highContrastButtonColor, // Emas/Kuning
                        elevation: 15, // Bayangan ditingkatkan
                      ),
                      child: const Text(
                        "Daftar",
                        style: TextStyle(
                          fontSize: 18,
                          color: onButtonColor, // Teks Hitam
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  // Link ke Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Sudah punya akun? ",
                        style: TextStyle(color: onPrimaryColor),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // Kembali ke Login
                        },
                        child: const Text(
                          "Masuk disini",
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