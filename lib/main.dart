import 'package:flutter/material.dart';
import 'Priere-details.page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulaire de Prière',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PrayerForm(),
      routes: {
        '/priere-details': (context) => PriereDetailsPage(),
      },
    );
  }
}

class PrayerForm extends StatefulWidget {
  @override
  _PrayerFormState createState() => _PrayerFormState();
}

class _PrayerFormState extends State<PrayerForm> {
  final TextEditingController _paysController = TextEditingController();
  final TextEditingController _villeController = TextEditingController();

  @override
  void dispose() {
    _paysController.dispose();
    _villeController.dispose();
    super.dispose();
  }

  void _onGetPriereDetails() {
    String ville = _villeController.text;
    // Navigate to Priere-details page and pass the ville as a parameter
    Navigator.pushNamed(context, '/priere-details', arguments: ville);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulaire de Prière'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _paysController,
              decoration: const InputDecoration(
                labelText: 'Pays :',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _villeController,
              decoration: const InputDecoration(
                labelText: 'Ville :',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _onGetPriereDetails,
              child: const Text('Chercher'),
            ),
          ],
        ),
      ),
    );
  }
}
