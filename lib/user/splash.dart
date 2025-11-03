import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const Color mainRedColor = Color.fromRGBO(179, 21, 21, 1);
  static const String logoAssetPath = 'assets/dimsum_logo.jpg';

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainRedColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset(
                  logoAssetPath,
                  width: 100,
                  height: 100, 
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.fastfood,
                      color: mainRedColor, 
                      size: 60
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'SumTime',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}