import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

void main() {
  runApp(const ZenCounterApp());
}

class ZenCounterApp extends StatelessWidget {
  const ZenCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zen Counter',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const ZenCounterPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ZenCounterPage extends StatefulWidget {
  const ZenCounterPage({super.key});

  @override
  State<ZenCounterPage> createState() => _ZenCounterPageState();
}

class _ZenCounterPageState extends State<ZenCounterPage> {
  int _count = 0;

  Future<void> _vibrate() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 50);
    }
  }

  void _incrementCounter() {
    setState(() {
      _count++;
    });
    _vibrate();
  }

  void _decrementCounter() {
    setState(() {
      if (_count > 0) _count--;
    });
    _vibrate();
  }

  void _resetCounter() {
    setState(() {
      _count = 0;
    });
    _vibrate();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _incrementCounter,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Text(
              //   '禅カウンター',
              //   style: Theme.of(context).textTheme.headlineSmall,
              // ),
              const SizedBox(height: 32),
              Text(
                '$_count',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _decrementCounter,
                    child: const Icon(Icons.remove),
                  ),
                  const SizedBox(width: 24),
                  ElevatedButton(
                    onPressed: _resetCounter,
                    child: const Icon(Icons.refresh),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}