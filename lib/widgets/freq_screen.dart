import 'package:flutter/material.dart';
import 'package:system_monitor/style/styles.dart';

class InfoFreqScreen extends StatefulWidget {
  final String name;
  final String frequence;

  const InfoFreqScreen({
    super.key,
    required this.name,
    required this.frequence,
  });

  @override
  State<InfoFreqScreen> createState() => _InfoFreqScreenState();
}

class _InfoFreqScreenState extends State<InfoFreqScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        width: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [boxShadow],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.name, style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                fontWeight: FontWeight.w600
              ),
            ),
            Text(
              widget.frequence, style: TextStyle(
                color: Colors.grey[600]
              ),
            ),
          ],
        ),
      );
  }
}
