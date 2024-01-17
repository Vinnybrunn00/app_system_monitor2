import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:system_monitor/style/styles.dart';

class MemoriaRam extends StatefulWidget {
  final int total;
  final String free;
  final String used;
  final double percent;

  const MemoriaRam({
    super.key,
    required this.total,
    required this.free,
    required this.used,
    required this.percent,
  });

  @override
  State<MemoriaRam> createState() => _MemoriaRamState();
}

class _MemoriaRamState extends State<MemoriaRam> {
  double perc = 3;
  @override
  Widget build(BuildContext context) {
    double widthSized = MediaQuery.of(context).size.width;
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, top: 8, right: 8.0, bottom: 10),
      child: Container(
        width: widthSized,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [boxShadow],
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Memória RAM',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.cyan,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Usados: ${widget.used} MB',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Column(
                    children: [
                      CircularPercentIndicator(
                        radius: 55,
                        lineWidth: 8,
                        percent: (widget.percent / 100),
                        progressColor: Colors.cyan,
                        backgroundColor: Colors.cyan.shade100,
                        center: Text(
                          '${(widget.percent.toInt())} %',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.cyan,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Total: ${widget.total} GB',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Livre: ${widget.free} MB',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
