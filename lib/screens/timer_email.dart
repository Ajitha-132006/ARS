import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import 'hospital.dart'; // Import the HOS page


class TimerPage extends StatefulWidget {
  final LatLng? coordinates;

  const TimerPage({super.key, this.coordinates});

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int _counter = 10;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        timer.cancel();
        _navigateToInformingContactsPage();
      }
    });
  }

  void _navigateToInformingContactsPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HOS()),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> sendEmailRequest() async {
    const url =
 ARS-shashank
        'http://ars-server-eight.vercel.app/send-email'; // Replace with your Flask API URL

        'https://ars-server-eight.vercel.app/send-email'; // works for anyone
 main
    const receiverEmail =
        'shashanksunilrao@gmail.com'; //replace with receiver email
    const name = 'John Doe';
    final coordinates = {
      'latitude': widget.coordinates?.latitude.toString(),
      'longitude': widget.coordinates?.longitude.toString(),
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'receiver_email': receiverEmail,
        'name': name,
        'coordinates': coordinates,
      }),
    );

    if (response.statusCode == 200) {
      print('Email sent successfully');
    } else {
      print('Failed to send email');
    }
  }

  void navigateToHospitalMailPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) => const HOS()), // Ensure this import is correct
    );
  }

  
  @override
    Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
                      'assets/images/alert.png',
                      width: 124,
                      height: 111,
                    ),
            const SizedBox(height: 40.0),
            Text(
              'An Accident has been detected!',
              style: GoogleFonts.hammersmithOne(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 40.0),
            Text(
              '$_counter',
              style: const TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // This takes you back to the previous page
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                textStyle: const TextStyle(
                  fontSize: 18.0,
                ),
              ),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
