import 'dart:convert';
import 'package:allplant/core/cubit/addplant/add_plant_cubit.dart';
import 'package:allplant/core/cubit/addplant/add_plant_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

//dropdown widget for selecting the plant type on add plant section

class PlantTypeDropdown extends StatefulWidget {

  const PlantTypeDropdown({required this.onSelected, super.key});
  final Function(String) onSelected;

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
    final  jsonString = await rootBundle.loadString('assets/data/plant_types.json');
    final data = json.decode(jsonString) as Map<String, dynamic>;

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

    return BlocBuilder<AddPlantCubit, AddPlantState>(
      buildWhen: (previous, current) => previous.plantType != current.plantType,
      builder: (context, state) {
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
             context.read<AddPlantCubit>().updatePlantType(value);
            }
          },
        );
      },
    );
  }
}
