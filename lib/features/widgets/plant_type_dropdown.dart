import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;


class PlantTypeDropdown extends StatefulWidget {
  final Function(String) onSelected;

  const PlantTypeDropdown({super.key, required this.onSelected});

  @override
  State<PlantTypeDropdown> createState() => _PlantTypeDropdownState();
}

class _PlantTypeDropdownState extends State<PlantTypeDropdown> {
  List<String> _options = [];
  String? _selected;

  @override
  void initState() {
    super.initState();
    _loadData();
  }


  Future<void> _loadData() async {
    final String jsonString = await rootBundle.loadString('assets/plant_types.json');
    final Map<String, dynamic> data = json.decode(jsonString);

    final dayanikli = (data['sukulentKaktus'] as List).cast<String>();
    final cicekli = (data['genisYaprakli'] as List).cast<String>();
    final sarmasik = (data['cicekli'] as List).cast<String>();
    final diger = (data['diger'] as List).cast<String>();


    final allTypes = <String>[...dayanikli, ...cicekli, ...sarmasik, ...diger];

    setState(() {
      _options = allTypes;

      _selected = allTypes.isNotEmpty ? allTypes.first : null;
    });
  }

  @override
  Widget build(BuildContext context) {
  
    if (_options.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(labelText: 'Bitki Türü'),
      value: _selected,
      items:
          _options.map((type) {
            return DropdownMenuItem(value: type, child: Text(type, style: Theme.of(context).textTheme.bodyLarge));
          }).toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _selected = value;
          });
          widget.onSelected(value);
        }
      },
    );
  }
}
