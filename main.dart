// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Robot Arm Control',
      home: const RobotControlPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RobotControlPage extends StatefulWidget {
  const RobotControlPage({super.key});

  @override
  State<RobotControlPage> createState() => _RobotControlPageState();
}

class _RobotControlPageState extends State<RobotControlPage> {
  double motor1 = 0;
  double motor2 = 0;
  double motor3 = 0;
  double motor4 = 0;

  List<Map<String, int>> savedPoses = [];

  final String server = "http://10.0.2.2/my_project"; // ← عدّل حسب المسار في XAMPP

  @override
  void initState() {
    super.initState();
    fetchSavedPoses();
  }

  Future<void> fetchSavedPoses() async {
    final url = Uri.parse('$server/get_poses.php');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          savedPoses = data.map((pose) {
            return {
              'motor1': int.parse(pose['motor1']),
              'motor2': int.parse(pose['motor2']),
              'motor3': int.parse(pose['motor3']),
              'motor4': int.parse(pose['motor4']),
            };
          }).toList();
        });
      } else {
        print("Failed to load poses: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> savePose() async {
    final url = Uri.parse('http://192.168.8.110/my_project/php_api/save_pose.php'); // لا تستخدم localhost
    try {
      await http.post(url, body: {
        'motor1': motor1.toInt().toString(),
        'motor2': motor2.toInt().toString(),
        'motor3': motor3.toInt().toString(),
        'motor4': motor4.toInt().toString(),
      });

      

      setState(() {
        savedPoses.insert(0, {
          'motor1': motor1.toInt(),
          'motor2': motor2.toInt(),
          'motor3': motor3.toInt(),
          'motor4': motor4.toInt(),
        });
      });
    } catch (e) {
      print("Save error: $e");
    }
  }

  Future<void> runPose(int index) async {
    final pose = savedPoses[index];
    final url = Uri.parse('$server/run_pose.php');
    await http.post(url, body: {
      'motor1': pose['motor1'].toString(),
      'motor2': pose['motor2'].toString(),
      'motor3': pose['motor3'].toString(),
      'motor4': pose['motor4'].toString(),
    });
  }

  void resetValues() {
    setState(() {
      motor1 = 0;
      motor2 = 0;
      motor3 = 0;
      motor4 = 0;
      savedPoses.clear(); // لا يحذف من قاعدة البيانات
    });
  }

  Widget slider(String label, double value, ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label: ${value.toInt()}"),
        Slider(
          value: value,
          min: 0,
          max: 180,
          divisions: 180,
          label: value.toInt().toString(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Robot Arm Control Panel')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            slider("Motor 1", motor1, (val) => setState(() => motor1 = val)),
            slider("Motor 2", motor2, (val) => setState(() => motor2 = val)),
            slider("Motor 3", motor3, (val) => setState(() => motor3 = val)),
            slider("Motor 4", motor4, (val) => setState(() => motor4 = val)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: savePose,
                  child: const Text("Save Pose"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (savedPoses.isNotEmpty) {
                      runPose(0); // تشغيل أحدث حركة
                    }
                  },
                  child: const Text("Run Last"),
                ),
                ElevatedButton(
                  onPressed: resetValues,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("Reset", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              "Saved Poses:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            if (savedPoses.isEmpty)
              const Text("No poses saved yet.")
            else
              Column(
                children: savedPoses.asMap().entries.map((entry) {
                  int index = entry.key;
                  var pose = entry.value;
                  return Card(
                    child: ListTile(
                      title: Text(
                          "Pose ${index + 1}: M1=${pose['motor1']}, M2=${pose['motor2']}, M3=${pose['motor3']}, M4=${pose['motor4']}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.play_arrow),
                        onPressed: () => runPose(index),
                      ),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
