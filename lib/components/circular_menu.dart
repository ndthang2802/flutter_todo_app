import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';

Widget create_CircularMenu() {
  return CircularMenu(
    alignment: Alignment.bottomLeft,
    toggleButtonColor: Colors.lightBlue,
    items: [
      CircularMenuItem(
          icon: Icons.home,
          enableBadge: true,
          badgeLabel: '....',
          badgeTextColor: Colors.white,
          color: Colors.green,
          onTap: () {}),
      CircularMenuItem(icon: Icons.search, color: Colors.blue, onTap: () {}),
      CircularMenuItem(
          icon: Icons.settings, color: Colors.orange, onTap: () {}),
    ],
  );
}
