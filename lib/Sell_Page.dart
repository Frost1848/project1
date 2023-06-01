import 'package:flutter/material.dart';

class SellPage extends StatefulWidget {
  @override
  _SellPageState createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  String? selectedItem;

  List<String> sellOptions = [
    'Mechanical parts',
    'Body Parts',
    'Cosmetic parts',
    'Lighting',
    'Accessories',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sell Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What would you like to sell?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedItem,
              onChanged: (value) {
                setState(() {
                  selectedItem = value;
                });
              },
              items: sellOptions.map((option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Select an option',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle sell button tap event
                if (selectedItem != null) {
                  // Perform action based on the selected item
                  print('User selected to sell: $selectedItem');
                } else {
                  // No option selected, display an error message or take appropriate action
                  print('Please select an option');
                }
              },
              child: Text('Sell'),
            ),
          ],
        ),
      ),
    );
  }
}
