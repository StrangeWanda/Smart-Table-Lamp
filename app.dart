import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:vibration/vibration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
        sliderTheme: SliderThemeData(
          activeTrackColor: Colors.tealAccent,
          inactiveTrackColor: Colors.teal.withOpacity(0.5),
          thumbColor: Colors.tealAccent,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final databaseRef = FirebaseDatabase.instance.ref();
  int delay = 2;
  double high = 50;
  double low = 50;

  @override
  void initState() {
    super.initState();
    _fetchInitialValues();
  }

  void _fetchInitialValues() async {
    DataSnapshot snapshot = await databaseRef.get();
    Map<String, dynamic> values =
        Map<String, dynamic>.from(snapshot.value as Map);
    setState(() {
      delay = values['delay'] ?? 2;
      high = values['high'].toDouble() ?? 50;
      low = values['low'].toDouble() ?? 50;
    });
  }

  void _updateDatabase() {
    databaseRef.update({
      'delay': delay,
      'high': high.toInt(),
      'low': low.toInt(),
    }).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Settings successfully updated!'),
          backgroundColor: Colors.green,
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update settings: $error'),
          backgroundColor: Colors.red,
        ),
      );
    });
  }

  void _onVibrate() {
    if (Vibration.hasVibrator() != null) {
      Vibration.vibrate(duration: 50);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Bookshelf'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildCard(
              title: "Set Delay",
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  delay = int.tryParse(value) ?? delay;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter delay in seconds',
                  filled: true,
                  fillColor: Colors.black26,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildCard(
              title: "Set High Value: ${high.toInt()}%",
              child: Slider(
                value: high,
                min: 0,
                max: 100,
                divisions: 20,
                onChanged: (value) {
                  setState(() {
                    high = value;
                  });
                  _onVibrate();
                },
              ),
            ),
            const SizedBox(height: 20),
            _buildCard(
              title: "Set Low Value: ${low.toInt()}%",
              child: Slider(
                value: low,
                min: 0,
                max: 100,
                divisions: 20,
                onChanged: (value) {
                  setState(() {
                    low = value;
                  });
                  _onVibrate();
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateDatabase,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Card(
      color: Colors.black54,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}
