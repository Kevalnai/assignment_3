import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Tracking App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WorkOutEntryScreen(),
    );
  }
}

class WorkOutEntryScreen extends StatefulWidget {
  const WorkOutEntryScreen({super.key, required this.title});

  final String title;

  @override
  State<WorkOutEntryScreen> createState() => _WorkOutEntryScreen();
}

class _WorkOutEntryScreen extends State<WorkOutEntryScreen> {
  final TextEditingController _caloriesGoalController = TextEditingController();
  final TextEditingController _WorkOutEntryScreen = TextEditingController();
  bool _isHighIntensity = false;
  bool _usedEquipment = false;

  void _submitWorkout()
  {
    final double caloriesGoal = double.parse(_caloriesGoalController.text)?? 0;
    final int workoutDuration = int.parse(_WorkOutEntryScreen.text)?? 0;

    double totalCalories = workoutDuration * 11.4;
    if(_usedEquipment)
    {
      totalCalories += 50;
    }
    if(_isHighIntensity)
    {
      totalCalories *= 1.2; 
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SummaryScreen(
        caloriesGoal: caloriesGoal,
        workoutDuration: workoutDuration,
        isHighIntensity: _isHighIntensity,
        usedEquipment: _usedEquipment,
        totalcalories: totalCalories,
      ),
      ),
    );
  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
