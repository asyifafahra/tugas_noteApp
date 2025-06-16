import 'package:flutter/material.dart';
import 'home_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul
              Container(
                padding: const EdgeInsets.only(top: 100, left: 20),
                child: const Text(
                  "Notely",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Deskripsi
              Container(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 100),
                child: const Text(
                  "Got a thought? Jot it down quickly. "
                  "Get reminders and stay on top of your ideas with Notely.",
                  style: TextStyle(
                    fontSize: 18,
                    ),
                ),
              ),

              const SizedBox(height: 40),

              // Gambar, ukuran tetap supaya terlihat
              Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Image.asset(
                    'assets/images/note.jpeg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Text('Image not found'));
                    },
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Tombol Let's Start, di bawah gambar dengan padding kiri
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const HomePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 234, 213, 153),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Let's Start",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40), // space bawah tombol
            ],
          ),
        ),
      ),
    );
  }
}
