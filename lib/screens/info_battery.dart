import 'dart:async';
import 'package:device_info_null_safety/device_info_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:open_settings/open_settings.dart';
import 'package:system_monitor/style/styles.dart';

class InfoBattery extends StatefulWidget {
  const InfoBattery({super.key});

  @override
  State<InfoBattery> createState() => _InfoBatteryState();
}

class _InfoBatteryState extends State<InfoBattery> {
  String? _batteryTemp, _batteryVolt, _batteryHeal, _batteryTech, _isSource;

  int? _batteryPerc;
  bool _isCharging = false;

  @override
  void initState() {
    super.initState();
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        getBattery();
      },
    );
  }

  final DeviceInfoNullSafety _deviceInfoNullSafety = DeviceInfoNullSafety();

  Future<void> getBattery() async {
    Map<String, dynamic> batteryInfo = await _deviceInfoNullSafety.batteryInfo;

    if (!mounted) return;

    setState(() {
      _batteryTemp =
          batteryInfo['batteryTemperature'].toString().substring(0, 4);
      _batteryVolt = batteryInfo['batteryVoltage'].toString().substring(0, 1);
      _batteryPerc = batteryInfo['batteryPercentage'];
      _batteryHeal = batteryInfo['batteryHealth'].toString();
      _batteryTech = batteryInfo['batteryTechnology'].toString();
      _isCharging = batteryInfo['isDeviceCharging'];
      _isSource = batteryInfo['chargingSource'];
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthSized = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              width: widthSized,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [boxShadow]),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _batteryPerc != null
                            ? Text(
                                '$_batteryPerc%',
                                style: const TextStyle(
                                    color: Colors.cyan, fontSize: 40),
                              )
                            : CircularProgressIndicator(
                                color: Colors.cyan.withOpacity(0.9),
                              ),
                        _batteryPerc == 100
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 15),
                                child: Text(
                                  'Bateria Cheia',
                                  style: TextStyle(
                                    color: Colors.cyan.withOpacity(0.9),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : const Text(''),
                        _isCharging
                            ? const Padding(
                                padding: EdgeInsets.only(left: 10, top: 15),
                                child: Icon(
                                  Icons.battery_charging_full,
                                  color: Colors.cyan,
                                ),
                              )
                            : const Text('')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _isCharging
                            ? const Text('Carregando...')
                            : const Text(''),
                        IconButton(
                          onPressed: () {
                            OpenSettings.openBatterySaverSetting();
                          },
                          icon: const Icon(
                            Icons.settings,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              width: widthSized,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  12,
                ),
                boxShadow: [boxShadow],
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'Temperatura',
                      style: TextStyle(
                        color: Colors.black.withOpacity(.6),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: _batteryTemp != null
                        ? Text(
                            '$_batteryTemp ºC',
                            style: TextStyle(
                              color: Colors.cyan.withOpacity(.7),
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : LinearProgressIndicator(
                            color: Colors.cyan.withOpacity(.7),
                            minHeight: 2.0,
                          ),
                  ),
                  ListTile(
                    title: Text(
                      'Tecnologia',
                      style: TextStyle(
                        color: Colors.black.withOpacity(.6),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: _batteryTech != null
                        ? Text(
                            '$_batteryTech',
                            style: TextStyle(
                              color: Colors.cyan.withOpacity(.7),
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : LinearProgressIndicator(
                            color: Colors.cyan.withOpacity(.7),
                            minHeight: 2.0,
                          ),
                  ),
                  ListTile(
                    title: Text(
                      'Voltagem',
                      style: TextStyle(
                        color: Colors.black.withOpacity(.6),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: _batteryVolt != null
                        ? Text(
                            '$_batteryVolt V',
                            style: TextStyle(
                              color: Colors.cyan.withOpacity(.7),
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : LinearProgressIndicator(
                            color: Colors.cyan.withOpacity(.7),
                            minHeight: 2.0,
                          ),
                  ),
                  ListTile(
                    title: Text(
                      'Saúde',
                      style: TextStyle(
                        color: Colors.black.withOpacity(.6),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: _batteryHeal != null
                        ? Text(
                            '$_batteryHeal',
                            style: TextStyle(
                              color: Colors.cyan.withOpacity(.7),
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : LinearProgressIndicator(
                            color: Colors.cyan.withOpacity(.7),
                            minHeight: 2.0,
                          ),
                  ),
                  _isSource != null
                      ? ListTile(
                          title: Text(
                            'Alimentação',
                            style: TextStyle(
                              color: Colors.black.withOpacity(.6),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: _isSource != null
                              ? Text(
                                  '$_isSource',
                                  style: TextStyle(
                                    color: Colors.cyan.withOpacity(.7),
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              : LinearProgressIndicator(
                                  color: Colors.cyan.withOpacity(.7),
                                  minHeight: 2.0,
                                ),
                        )
                      : ListTile(
                          title: Text(
                            'Alimentação',
                            style: TextStyle(
                              color: Colors.black.withOpacity(.6),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            'Bateria',
                            style: TextStyle(
                              color: Colors.cyan.withOpacity(.7),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
