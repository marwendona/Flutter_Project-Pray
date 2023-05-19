import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PriereDetailsPage extends StatefulWidget {
  @override
  _PriereDetailsPageState createState() => _PriereDetailsPageState();
}

class _PriereDetailsPageState extends State<PriereDetailsPage> {
  Map<String, dynamic>? priereData;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final String ville = ModalRoute.of(context)?.settings.arguments as String;
      getPriereData(ville);
    });
  }

  Future<void> getPriereData(String ville) async {
    final String url =
        'https://api.aladhan.com/v1/timingsByCity/04-05-2023?city=$ville&country=Tunisia';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          priereData = jsonData['data'];
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  Widget buildPrayerCard(String prayerName, String prayerTime) {
    return Card(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(prayerName, style: TextStyle(color: Colors.white)),
            Text(prayerTime, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget buildInfoCard(String title, String value) {
    return Card(
      color: Colors.blueGrey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              value,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la Prière'),
      ),
      body: Stack(
        children: [
          priereData != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      const SizedBox(height: 16.0),
                      const SizedBox(height: 16.0),
                      buildInfoCard('Les 5 prières ', 'sont : '),
                      const SizedBox(height: 8.0),
                      buildPrayerCard('Fajr', priereData!['timings']['Fajr']),
                      buildPrayerCard('Dhuhr', priereData!['timings']['Dhuhr']),
                      buildPrayerCard('Asr', priereData!['timings']['Asr']),
                      buildPrayerCard(
                          'Maghrib', priereData!['timings']['Maghrib']),
                      buildPrayerCard('Isha', priereData!['timings']['Isha']),
                      const SizedBox(height: 16.0),
                      buildInfoCard(
                        'Levé de soleil',
                        priereData!['timings']['Sunrise'],
                      ),
                      const SizedBox(height: 16.0),
                      buildInfoCard(
                        'Coucher de soleil',
                        priereData!['timings']['Sunset'],
                      ),
                      const SizedBox(height: 16.0),
                      buildInfoCard(
                        'Date en format Hijri',
                        priereData!['date']['hijri']['date'],
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ],
      ),
    );
  }
}
