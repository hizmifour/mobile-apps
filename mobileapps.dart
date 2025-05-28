import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Charging Station',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const DashboardScreen(),
    );
  }
}

// Step 1: Make it Stateful
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final Battery _battery = Battery(); // Step 4a: Create battery instance
  int _batteryLevel = 0; // Step 4b: Variable to store battery level

  final List<Map<String, dynamic>> items = [
    {"title": "Battery Percentage", "icon": Icons.battery_full},
    {"title": "Power Usage", "icon": Icons.bolt},
    {"title": "Papers", "icon": Icons.description},
    {"title": "yyy", "icon": Icons.picture_as_pdf},
    {"title": "xxx", "icon": Icons.work},
    {"title": "zzz", "icon": Icons.info_outline},
  ];

  // Step 4c: Function to get battery level
  void _getBatteryLevel() async {
    final level = await _battery.batteryLevel;

    setState(() {
      _batteryLevel = level;
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Battery Level'),
        content: Text('Battery is at $_batteryLevel%'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 185, 237),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 38, 45, 84),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.menu, color: Colors.white),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Charging Station',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Last Update: 7 Aug 2023',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: InkWell(
                      onTap: () {
                        if (items[index]['title'] == "Battery Percentage") {
                          _getBatteryLevel(); // Step 5: Show battery level
                        } else {
                          // Handle other items
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${items[index]['title']} tapped")),
                          );
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            items[index]['icon'],
                            size: 40,
                            color: Colors.indigo,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            items[index]['title'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
