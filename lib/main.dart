import 'package:flutter/material.dart';

void main() {
  runApp(TempConversionApp());
}

class TempConversionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TempConverterScreen(),
    );
  }
}

class TempConverterScreen extends StatefulWidget {
  @override
  _TempConverterScreenState createState() => _TempConverterScreenState();
}

class _TempConverterScreenState extends State<TempConverterScreen> {
  String _selectedConversion = 'F to C'; // Default conversion type
  TextEditingController _tempController = TextEditingController();
  String _result = '';
  List<String> _history = [];

  // Default background color
  Color _backgroundColor = Colors.white;

  // Conversion functions
  double _fahrenheitToCelsius(double f) {
    return (f - 32) * 5 / 9;
  }

  double _celsiusToFahrenheit(double c) {
    return (c * 9 / 5) + 32;
  }

  void _convertTemperature() {
    if (_tempController.text.isEmpty) {
      setState(() {
        _result = "Enter a temperature value.";
      });
      return;
    }

    double inputTemp = double.tryParse(_tempController.text) ?? 0;
    double convertedTemp;
    String conversionType;
    String historyEntry;

    if (_selectedConversion == 'F to C') {
      convertedTemp = _fahrenheitToCelsius(inputTemp);
      conversionType = 'F to C';
    } else {
      convertedTemp = _celsiusToFahrenheit(inputTemp);
      conversionType = 'C to F';
    }

    // Display result with 2 decimal places
    setState(() {
      _result = convertedTemp.toStringAsFixed(2);

      // Add to history
      historyEntry = '$conversionType: $inputTemp => ${_result}';
      _history.add(historyEntry);
    });
  }

  // Function to change background color
  void _changeBackgroundColor(Color color) {
    setState(() {
      _backgroundColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
      ),
      body: Container(
        color: _backgroundColor, // Apply the background color here
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown for selecting conversion
            DropdownButton<String>(
              value: _selectedConversion,
              items: <String>['F to C', 'C to F'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedConversion = newValue!;
                });
              },
            ),

            // Input field for temperature
            TextFormField(
              controller: _tempController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter temperature',
              ),
            ),

            SizedBox(height: 20),

            // Convert Button
            ElevatedButton(
              onPressed: _convertTemperature,
              child: Text('Convert'),
            ),

            SizedBox(height: 20),

            // Result display
            Text(
              'Converted Temperature: $_result',
              style: TextStyle(fontSize: 18),
            ),

            SizedBox(height: 20),

            // Dropdown for background color selection
            DropdownButton<Color>(
              value: _backgroundColor,
              items: <Color>[
                Colors.white,
                Colors.blue[100]!,
                Colors.green[100]!,
                Colors.yellow[100]!,
                Colors.pink[100]!,
              ].map((Color color) {
                return DropdownMenuItem<Color>(
                  value: color,
                  child: Container(
                    width: 100,
                    height: 20,
                    color: color,
                  ),
                );
              }).toList(),
              onChanged: (Color? newColor) {
                if (newColor != null) {
                  _changeBackgroundColor(newColor);
                }
              },
            ),

            SizedBox(height: 20),

            // History section
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_history[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
