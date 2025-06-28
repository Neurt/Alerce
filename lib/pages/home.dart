import 'package:flutter/material.dart';
import 'package:alerce1/colour.dart';
import 'package:alerce1/pages/emergency.dart';
import 'package:alerce1/pages/reminder.dart';
import 'package:alerce1/pages/water.dart';  // Make sure to import WaterReminder
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  final String username;
  final String sickness;
  final String age;

  const HomePage({
    Key? key,
    required this.username,
    required this.sickness,
    required this.age,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    String username = widget.username;
    String sickness = widget.sickness;
    String age = widget.age;
    return Scaffold(
      backgroundColor: mainPeach,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Alerce",
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: GoogleFonts.cookie().fontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 10,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: mainBlue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Good Afternoon, $username",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Age: $age",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Illness: $sickness",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.only(bottom: 100),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WaterReminder(),
                                ),
                              );
                            },
                            child: Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width - 50,
                              padding: const EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                color: mainGreen,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    child: Lottie.asset('assets/animation/GlassWater.json'),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Drink water',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: GoogleFonts.cookie().fontFamily
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context,
                              MaterialPageRoute(builder: (context)=> ReminderPage()),
                              );
                            },
                            child: Container(
                              height: 240,
                              width: 190,
                              padding: const EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 130, 145, 255),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Lottie.asset('assets/animation/ReminderIcon.json'),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20,),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EmergencyPage(),
                                ),
                              );
                            },
                            child: Container(
                              height: 240,
                              width: 190,
                              padding: const EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 82, 82),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Lottie.asset('assets/animation/emergencyButton.json'),
                              ),
                            ),
                          ),
                        ]
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}