import 'package:flutter/material.dart';

void main() {
  runApp(const FitnessApp());
}

class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Workout App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WorkoutEntryScreen(),
    );
  }
}

class WorkoutEntryScreen extends StatefulWidget {
  const WorkoutEntryScreen({super.key});

  @override
  State<WorkoutEntryScreen> createState() => _WorkoutEntryScreenState();
}

class _WorkoutEntryScreenState extends State<WorkoutEntryScreen> {
  final TextEditingController _calorieGoalController = TextEditingController();
  final TextEditingController _workoutDurationController =
      TextEditingController();
  bool _isHighIntensity = false;
  bool _usedEquipment = false;

  void _submitWorkout() {
    // Parse input values
    final double calorieGoal =
        double.tryParse(_calorieGoalController.text) ?? 0;
    final int workoutDuration =
        int.tryParse(_workoutDurationController.text) ?? 0;

    // Calculate total calories burned
    double totalCalories = workoutDuration * 11.4;
    if (_usedEquipment) {
      totalCalories += 50;
    }
    if (_isHighIntensity) {
      totalCalories *= 1.2;
    }

    // Navigate to the summary screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SummaryScreen(
          calorieGoal: calorieGoal,
          workoutDuration: workoutDuration,
          isHighIntensity: _isHighIntensity,
          usedEquipment: _usedEquipment,
          totalCalories: totalCalories,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _calorieGoalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Calorie Goal',
              ),
            ),
            TextField(
              controller: _workoutDurationController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Workout Duration (minutes)',
              ),
            ),
            SwitchListTile(
              title: const Text('High Intensity Workout?'),
              value: _isHighIntensity,
              onChanged: (value) {
                setState(() {
                  _isHighIntensity = value;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Equipment Used?'),
              value: _usedEquipment,
              onChanged: (value) {
                setState(() {
                  _usedEquipment = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _submitWorkout,
                child: const Text('Submit Workout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SummaryScreen extends StatelessWidget {
  final double calorieGoal;
  final int workoutDuration;
  final bool isHighIntensity;
  final bool usedEquipment;
  final double totalCalories;

  const SummaryScreen({
    super.key,
    required this.calorieGoal,
    required this.workoutDuration,
    required this.isHighIntensity,
    required this.usedEquipment,
    required this.totalCalories,
  });

  @override
  Widget build(BuildContext context) {
    final bool metGoal = totalCalories >= calorieGoal;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Workout Summary',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text('Workout Duration: $workoutDuration minutes'),
            Text('High Intensity: ${isHighIntensity ? "Yes" : "No"}'),
            Text('Used Equipment: ${usedEquipment ? "Yes" : "No"}'),
            Text('Total Calories Burned: ${totalCalories.toStringAsFixed(2)}'),
            const SizedBox(height: 20),
            Text(
              metGoal ? 'You met your calorie goal! ' : 'Keep pushing! ',
              style: TextStyle(
                fontSize: 18,
                color: metGoal ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back to Entry Screen'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
