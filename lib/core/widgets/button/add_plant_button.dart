import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddPlantButton extends StatelessWidget {
  final String route;  
  final String label;
  final IconData icon;

  const AddPlantButton({
    super.key,
    this.route = '/add-plant',  
    this.label = 'Bitki Ekle',  
    this.icon = Icons.add,     
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        context.go(route);
      },
      icon: Icon(icon),
      label: Text(label),
    );
  }
}
