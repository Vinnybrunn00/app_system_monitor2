import 'dart:async';
import 'package:device_info_null_safety/device_info_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:system_monitor/widgets/info_sensors.dart';

class InfoSensors extends StatefulWidget {
  const InfoSensors({super.key});

  @override
  State<InfoSensors> createState() => _InfoSensorsState();
}

class _InfoSensorsState extends State<InfoSensors> {
  int? _sensorCount;

  late List<Map<String, dynamic>> listSensors;

  @override
  void initState() {
    super.initState();
    getSensors();
  }

  final DeviceInfoNullSafety _deviceInfoNullSafety = DeviceInfoNullSafety();

  Future<void> getSensors() async {
    List<Map<String, dynamic>> sensorInfo =
        await _deviceInfoNullSafety.sensorInfo;

    if (!mounted) return;

    setState(() {
      // teste
      _sensorCount = sensorInfo.length;

      listSensors = sensorInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthSized = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.cyan,
        title: Text(
          'System Monitor',
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
              height: 40,
              width: widthSized,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    color: Colors.black.withOpacity(
                      .2,
                    ),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: Text(
                  '$_sensorCount sensores estão disponíveis no seu aparelho',
                  style: TextStyle(color: Colors.cyan[600]),
                ),
              ),
            ),
            for (var sensors in listSensors)
              ShowInfoSensors(
                title: sensors['name'].toString(),
                name: sensors['name'].toString(),
                vendor: sensors['vendor'].toString(),
                power: '${sensors['power'].toStringAsFixed(3)} mhz',
                version: sensors['version'].toString(),
              ),
            const Text('')
          ],
        ),
      ),
    );
  }
}
