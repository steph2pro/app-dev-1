import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

goTo(BuildContext context, String route,
    {bool pop = false, bool popAll = false}) {
  if (popAll) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(route, (Route<dynamic> route) => false);
  } else if (pop) {
    Navigator.of(context).pushReplacementNamed(route);
  } else
    Navigator.of(context).pushNamed(route);
}

String formatTimestamp(int timestamp) {
  final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  final now = DateTime.now();
  final difference = now.difference(date);

  if (difference.inMinutes < 60) {
    // Moins d'une heure
    final minutes = difference.inMinutes;
    if (minutes <= 1) {
      return "il y a 1 min";
    }
    return "il y a $minutes min";
  } else if (difference.inHours < 24) {
    // Moins d'une journée
    final hours = difference.inHours;
    if (hours <= 1) {
      return "il y a 1 h";
    }
    return "il y a $hours h";
  } else {
    // Plus de 24h : on affiche la date
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }
}
