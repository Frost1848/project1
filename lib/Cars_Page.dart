import 'package:akary/Buy_Page.dart';
import 'package:akary/Sell_Page.dart';
import 'package:flutter/material.dart';

class CarsPage extends StatelessWidget {
  final List<String> cars = [
    'Ritz',
    'Lamborghini',
    'Ciaz',
    'WagonR',
    '800',
    'Land Rover',
    'Suzuki',
    'Mitsubishi',
    'Car 9',
    'Car 10',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cars Page'),
        foregroundColor: Color.fromARGB(255, 240, 234, 234),
        backgroundColor: Color.fromARGB(255, 10, 2, 2),
      ),
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return Card(
            child: ListTile(
              title: Text(car),
              leading: Icon(Icons.directions_car),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle sell button tap event
                      // Add your logic here
                    },
                    style: ElevatedButton.styleFrom(
                      primary:
                          Color.fromARGB(255, 216, 2, 2), // Background color
                    ),
                    child: Text('BUY'),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SellPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary:
                          Color.fromARGB(255, 11, 11, 11), // Background color
                    ),
                    child: Text('SELL'),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BuyPage()),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
