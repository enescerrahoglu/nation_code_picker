import 'package:flutter/material.dart';
import 'package:nation_code_picker/flag_component.dart';
import 'package:nation_code_picker/nation_code_picker.dart';
import 'package:nation_code_picker/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // themeMode: ThemeMode.light,
      theme: lightTheme,
      darkTheme: darkTheme,
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
  NationCodes _selectedNationCode = NationCodes.tr;

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
              flagScale: 0.6,
              defaultNationCode: _selectedNationCode,
              dialCodeColor: Colors.deepPurple,
              dialCodeFontWeight: FontWeight.bold,
              dialCodeFontFamily: 'Ubuntu',
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
                    leading: Text(_selectedNationCode.code,
                        style: const TextStyle(fontSize: 20)),
                    title: Text(_selectedNationCode.name,
                        style: const TextStyle(fontSize: 20)),
                    trailing: Text(_selectedNationCode.dialCode,
                        style: const TextStyle(fontSize: 20)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('FlagComponent'),
                FlagComponent(nation: _selectedNationCode),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
