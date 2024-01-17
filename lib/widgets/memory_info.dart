import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:system_monitor/style/styles.dart';

class MemoryInfo extends StatefulWidget {
  final int total;
  final String free;
  final String used;
  final double percent;

  const MemoryInfo({
    super.key,
    required this.total,
    required this.free,
    required this.used,
    required this.percent,
  });

  @override
  State<MemoryInfo> createState() => _MemoryInfoState();
}

class _MemoryInfoState extends State<MemoryInfo> {
  @override
  Widget build(BuildContext context) {
    double widthSized = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0, bottom: 10),
      child: Container(
        width: widthSized,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [boxShadow]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Memória Ram',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.cyan,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Usada: ${widget.used} MB',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 5, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircularPercentIndicator(
                        radius: 30,
                        lineWidth: 5,
                        percent: (widget.percent / 100),
                        progressColor: Colors.cyan,
                        backgroundColor: Colors.cyan.shade100,
                        center: Text(
                          '${(widget.percent.toInt())}%',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.cyan,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  Container(
                    height: 8,
                    width: widthSized * .7,
                    decoration: const BoxDecoration(color: Colors.cyan),
                    child: Container(
                      height: 10,
                      margin: EdgeInsets.fromLTRB(
                        widthSized * .7 * .01 * widget.percent,
                        0,
                        0,
                        0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                  Text(
                    '${widget.percent.toInt()}%',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 15, left: 10, right: 10, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
