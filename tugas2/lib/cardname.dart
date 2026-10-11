import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardName extends StatelessWidget {
    const CardName({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Digital Card Name',
            home: Scaffold(
                backgroundColor: const Color.fromARGB(255, 216, 227, 240),
                body: SafeArea(
                    child: Center(
                        child: Column(
                            mainAxisAlignment: .center,
                            children: [
                                CircleAvatar(
                                    radius: 80.0,
                                    backgroundImage: AssetImage('assets/images/home.PNG'),
                                    backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                                ),
                                SizedBox(height: 20.0),
                                Text(
                                    'Jay',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 25,
                                        fontWeight: .bold,
                                        color: Colors.brown,
                                        letterSpacing: -1,
                                    ),
                                ),
                                Text(
                                  'Digital Illustrator',
                                  style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        color: const Color.fromARGB(255, 147, 111, 98),
                                        letterSpacing: -1,
                                    ),
                                ),
                                SizedBox(
                                  height: 25.0,
                                  width: 250.0,
                                  child: Divider(
                                    color: Colors.brown,
                                    thickness: 1,
                                  ),
                                ),
                                Card(
                                  margin: EdgeInsets.symmetric(horizontal: 90.0, vertical: 10.0),
                                  color: Colors.white,
                                  child: ListTile(
                                    leading: Icon(Icons.phone, color: Colors.brown,),
                                    title: Text(
                                      '+62 878 4649 0041',
                                      style: TextStyle(
                                        color: Colors.brown,
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  margin: EdgeInsets.symmetric(horizontal: 90.0, vertical: 10.0),
                                  color: Colors.white,
                                  child: ListTile(
                                    leading: Icon(Icons.email, color: Colors.brown,),
                                    title: Text(
                                      'octopusquidy@gmail.com',
                                      style: TextStyle(
                                        color: Colors.brown,
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  margin: EdgeInsets.symmetric(horizontal: 90.0, vertical: 10.0),
                                  color: Colors.white,
                                  child: ListTile(
                                    leading: Icon(Icons.camera_alt, color: Colors.brown,),
                                    title: Text(
                                      '@jematara on Instagram',
                                      style: TextStyle(
                                        color: Colors.brown,
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  margin: EdgeInsets.symmetric(horizontal: 90.0, vertical: 10.0),
                                  color: Colors.white,
                                  child: ListTile(
                                    leading: Icon(Icons.play_circle, color: Colors.brown,),
                                    title: Text(
                                      '@jematara on YouTube',
                                      style: TextStyle(
                                        color: Colors.brown,
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  margin: EdgeInsets.symmetric(horizontal: 90.0, vertical: 10.0),
                                  color: Colors.white,
                                  child: ListTile(
                                    leading: Icon(Icons.book, color: Colors.brown,),
                                    title: Text(
                                      'Digital Art Course',
                                      style: TextStyle(
                                        color: Colors.brown,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                        ),
                    ),
                ),
            ),
        );
    }
}