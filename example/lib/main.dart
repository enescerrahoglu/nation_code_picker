import 'package:flutter/material.dart';
import 'package:nation_code_picker/nation_code_picker.dart';
import 'package:nation_code_picker/nation_codes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Nation Code Picker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NationCode _selectedNationCode = NationCode.tr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            NationCodePicker(
              color: Colors.deepPurple,
              defaultNationCode: _selectedNationCode,
              onNationSelected: (p0) {
                setState(() {
                  _selectedNationCode = p0;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Selected nation data:"),
                  ListTile(
                    leading: Text(_selectedNationCode.code, style: const TextStyle(fontSize: 20)),
                    title: Text(_selectedNationCode.name, style: const TextStyle(fontSize: 20)),
                    trailing: Text(_selectedNationCode.dialCode, style: const TextStyle(fontSize: 20)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
