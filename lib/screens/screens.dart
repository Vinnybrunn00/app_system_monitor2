import 'dart:async';
import 'package:app_analysis/app_analysis.dart';
import 'package:device_info_null_safety/device_info_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:jfullinfo/jFullInfo.dart';
import 'package:open_settings/open_settings.dart';
import 'package:system_monitor/screens/info_battery.dart';
import 'package:system_monitor/screens/info_sensors.dart';
import 'package:system_monitor/style/styles.dart';
import 'package:system_monitor/widgets/freq_screen.dart';
import 'package:system_monitor/widgets/loading.dart';
import 'package:system_monitor/widgets/memoria_ram.dart';

class ScreenPage extends StatefulWidget {
  const ScreenPage({super.key});

  @override
  State<ScreenPage> createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {
  double? percentUsed;

  String? memoryFree;
  int? memoryTotal, _sensorCount, _countCores;
  String? memoryUsed;

  String? _getfreqMax0,
      _getfreqMax1,
      _getfreqMax2,
      _getfreqMax3,
      _getfreqMax4,
      _getfreqMax5,
      _getfreqMax6,
      _getfreqMax7;

  String? _getManufacturer,
      _getModel,
      _getAndroid,
      _batteryTemp,
      _batteryVolt,
      _getfreqMedia,
      _orientation,
      _screenSize,
      _refreshRate,
      _resolution,
      _getSpeed;

  //String? _teste;

  bool _getState = true;

  int _batteryPerc = 16;
  bool _isCharging = false;

  late Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(seconds: 2),
      (Timer t) async {
        final info = await RamInfoProvider().info;
        setState(
          () {
            memoryFree = info.available.inMB.toInt().toString();
            memoryTotal = info.total.inGB.round();
            memoryUsed = info.used.inMB.toInt().toString();
          },
        );
        getInfo();
      },
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  final _jFullInfo = JFullInfo();

  CpuInfoProvider infoCpu = CpuInfoProvider();

  final DeviceInfoNullSafety _deviceInfoNullSafety = DeviceInfoNullSafety();

  Future<void> getInfo() async {
    final getHardware = await _jFullInfo.getHardwareInformation();
    final getAndroid = await _jFullInfo.getAndroidInformation();

    final info2 = await RamInfoProvider().info;
    final percent = info2.percentUsed.toDouble() * 90;

    Map<int, double> cpuInfo1 = await infoCpu.currentFrequency;
    double cpuInfo2 = await infoCpu.averageCurrentFrequency;

    Map<String, dynamic> batteryInfo = await _deviceInfoNullSafety.batteryInfo;
    List<Map<String, dynamic>> sensorInfo =
        await _deviceInfoNullSafety.sensorInfo;

    Map<String, dynamic> displayInfo = await _deviceInfoNullSafety.displayInfo;

    Map<String, dynamic> networkInfo = await _deviceInfoNullSafety.networkInfo;
    if (!mounted) return;

    setState(() {
      _resolution = displayInfo['resolution'].toString();
      _orientation = 'Retrato';
      _screenSize = displayInfo['physicalSize'].toString().substring(0, 3);
      _refreshRate = displayInfo['refreshRate'].toString();

      _countCores = cpuInfo1.length;

      percentUsed = percent.toDouble();

      _getState = networkInfo['isWifiEnabled'];
      _getSpeed = networkInfo['wifiLinkSpeed'];

      _getModel = getHardware.model;

      _getfreqMax0 = cpuInfo1[0].toString();
      _getfreqMax1 = cpuInfo1[1].toString();
      _getfreqMax2 = cpuInfo1[2].toString();
      _getfreqMax3 = cpuInfo1[3].toString();
      _getfreqMax4 = cpuInfo1[4].toString();
      _getfreqMax5 = cpuInfo1[5].toString();
      _getfreqMax6 = cpuInfo1[6].toString();
      _getfreqMax7 = cpuInfo1[7].toString();

      _sensorCount = sensorInfo.length;
      _getManufacturer = getHardware.manufacturer;

      _getAndroid = getAndroid.release;

      _getfreqMedia = cpuInfo2.toStringAsFixed(1);

      _batteryTemp =
          batteryInfo['batteryTemperature'].toString().substring(0, 4);
      _batteryVolt = batteryInfo['batteryVoltage'].toString().substring(0, 1);
      _batteryPerc = batteryInfo['batteryPercentage'] ?? 0;
      _isCharging = batteryInfo['isDeviceCharging'];
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthSized = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 85,
                    width: widthSized / 2.2,
                    decoration: BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [boxShadow]),
                    child: _getAndroid != null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image(
                                color: Colors.white.withOpacity(.9),
                                height: 33,
                                image: const AssetImage(
                                  'assets/images/android.png',
                                ),
                              ),
                              Text(
                                'ANDROID $_getAndroid',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(.9),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                CircularProgressIndicator(
                                  color: Colors.white.withOpacity(.9),
                                ),
                              ],
                            ),
                          ),
                  ),
                  Container(
                    height: 85,
                    width: widthSized / 2.2,
                    decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [boxShadow],
                    ),
                    child: _getManufacturer != null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image(
                                color: Colors.white.withOpacity(.9),
                                height: 31,
                                image: const AssetImage(
                                  'assets/images/device.png',
                                ),
                              ),
                              Text(
                                '$_getManufacturer',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(.9),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                CircularProgressIndicator(
                                  color: Colors.white.withOpacity(.9),
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),
            _getModel != null ? Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
              child: Container(
                width: widthSized / 1,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [boxShadow],
                  ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$_getModel',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ) : const Text(''),
            MemoriaRam(
              total: memoryTotal ?? 0,
              free: memoryFree ?? '0',
              used: memoryUsed ?? '0',
              percent: percentUsed ?? 0,
            ),
            Container(
                padding: const EdgeInsets.only(top: 10, bottom: 5),
                width: widthSized / 1.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [boxShadow],
                ),
                child: _getfreqMedia != null
                    ? Column(
                        children: [
                          Text(
                            'Frequência Média',
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '$_getfreqMedia',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          )
                        ],
                      )
                    : const Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Column(
                          children: [
                            CircularProgressIndicator(
                              color: Colors.cyan,
                            )
                          ],
                        ),
                      )),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _getfreqMax0 != null
                          ? InfoFreqScreen(
                              name: 'Núcleo 1',
                              frequence: '$_getfreqMax0',
                            )
                          : const LoadingView(),
                      _getfreqMax1 != null
                          ? InfoFreqScreen(
                              name: 'Núcleo 2',
                              frequence: '$_getfreqMax1',
                            )
                          : const LoadingView(),
                      _getfreqMax2 != null
                          ? InfoFreqScreen(
                              name: 'Núcleo 3',
                              frequence: '$_getfreqMax2',
                            )
                          : const LoadingView(),
                      _getfreqMax3 != null
                          ? InfoFreqScreen(
                              name: 'Núcleo 4',
                              frequence: '$_getfreqMax3',
                            )
                          : const LoadingView(),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _getfreqMax4 != null
                          ? InfoFreqScreen(
                              name: 'Núcleo 5',
                              frequence: '$_getfreqMax4',
                            )
                          : const LoadingView(),
                      _getfreqMax5 != null
                          ? InfoFreqScreen(
                              name: 'Núcleo 6',
                              frequence: '$_getfreqMax5',
                            )
                          : const LoadingView(),
                      _getfreqMax6 != null
                          ? InfoFreqScreen(
                              name: 'Núcleo 7',
                              frequence: '$_getfreqMax6',
                            )
                          : const LoadingView(),
                      _getfreqMax7 != null
                          ? InfoFreqScreen(
                              name: 'Núcleo 8',
                              frequence: '$_getfreqMax7',
                            )
                          : const LoadingView(),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: widthSized,
              margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const InfoBattery(),
                    ),
                  );
                },
                child: Ink(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [boxShadow]),
                  child: Row(
                    children: [
                      _batteryPerc >= 15
                          ? const SizedBox(
                              height: 70,
                              width: 60,
                              child: Image(
                                color: Colors.cyan,
                                image: AssetImage(
                                  'assets/images/battery_main.png',
                                ),
                              ),
                            )
                          : const SizedBox(
                              height: 70,
                              width: 60,
                              child: Image(
                                image: AssetImage(
                                  'assets/images/battery_low.png',
                                ),
                              ),
                            ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: widthSized * .8,
                            padding: const EdgeInsets.only(left: 5),
                            child: Row(
                              children: [
                                _isCharging
                                    ? Expanded(
                                        child: Text(
                                          'Bateria (Carregando...)',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      )
                                    : Expanded(
                                        child: Text(
                                          'Bateria (Descarregando...)',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                IconButton(
                                  onPressed: () async {
                                    OpenSettings.openBatterySaverSetting();
                                  },
                                  icon: Icon(
                                    Icons.settings,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 1),
                            child: Row(
                              children: [
                                Container(
                                  color: Colors.cyan,
                                  height: 5,
                                  width: widthSized * .7,
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Container(
                                    color: Colors.cyan.shade100,
                                    height: 5,
                                    margin: EdgeInsets.fromLTRB(
                                      widthSized * .7 * .01 * _batteryPerc,
                                      0,
                                      0,
                                      0,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 7),
                                Text(
                                  '$_batteryPerc%',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4, bottom: 5),
                            child: Row(
                              children: [
                                _batteryVolt != null
                                    ? Text(
                                        'Voltagem: $_batteryVolt V',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    : Text(
                                        'Voltagem: 0 V',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                const SizedBox(width: 20),
                                _batteryTemp != null
                                    ? Text(
                                        'Temperatura: $_batteryTempºC',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    : Text(
                                        'Temperatura: 00.0 C',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        height: 85,
                        width: widthSized / 2.2,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [boxShadow]),
                        child: _getSpeed != null
                            ? Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'WiFi',
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          _getState
                                              ? const Image(
                                                  color: Colors.cyan,
                                                  height: 55,
                                                  image: AssetImage(
                                                    'assets/images/wifi.png',
                                                  ),
                                                )
                                              : Image(
                                                  color: Colors.red[600],
                                                  height: 55,
                                                  image: const AssetImage(
                                                    'assets/images/wifi_desconected.png',
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 25),
                                        child: Row(
                                          children: [
                                            Text(
                                              '$_getSpeed',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, bottom: 10),
                                        child: Row(
                                          children: [
                                            _getState
                                                ? Text(
                                                    'Conectado',
                                                    style: TextStyle(
                                                      color: Colors.cyan[600],
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )
                                                : Text(
                                                    'Desconectado',
                                                    style: TextStyle(
                                                      color: Colors.red[600],
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : const Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Column(
                                  children: [
                                    CircularProgressIndicator(
                                      color: Colors.cyan,
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        height: 85,
                        width: widthSized / 2.2,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [boxShadow]),
                        child: _screenSize != null
                            ? Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                              'Tela $_screenSize',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          const Image(
                                            color: Colors.cyan,
                                            height: 55,
                                            image: AssetImage(
                                              'assets/images/screen1.png',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 25),
                                        child: Row(
                                          children: [
                                            Text(
                                              '$_resolution',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              '$_refreshRate Hz',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          children: [
                                            _orientation != 'Portrait'
                                                ? Text(
                                                    'Vertical',
                                                    style: TextStyle(
                                                      color: Colors.cyan[600],
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )
                                                : Text(
                                                    'Horizontal',
                                                    style: TextStyle(
                                                      color: Colors.cyan[600],
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : const Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Column(
                                  children: [
                                    CircularProgressIndicator(
                                      color: Colors.cyan,
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 3, bottom: 8),
                  child: Row(
                    children: [
                      Container(
                        height: 85,
                        width: widthSized / 2.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const InfoSensors(),
                              ),
                            );
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                12,
                              ),
                              boxShadow: [
                                boxShadow,
                              ],
                            ),
                            child: _sensorCount != null
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, top: 15, right: 10),
                                        child: Image(
                                          color: Colors.cyan,
                                          height: 55,
                                          image: AssetImage(
                                              'assets/images/sensors.png'),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '$_sensorCount',
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 30),
                                          ),
                                          Text(
                                            'Sensores',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                : const Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Column(
                                      children: [
                                        CircularProgressIndicator(
                                          color: Colors.cyan,
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 3, bottom: 8),
                  child: Row(
                    children: [
                      Container(
                        height: 85,
                        width: widthSized / 2.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {},
                          child: Ink(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                12,
                              ),
                              boxShadow: [
                                boxShadow,
                              ],
                            ),
                            child: _sensorCount != null
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, top: 15, right: 10),
                                        child: Image(
                                          color: Colors.cyan,
                                          height: 55,
                                          image: AssetImage(
                                              'assets/images/sensors.png'),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '$_countCores',
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 30),
                                          ),
                                          Text(
                                            'Núcleos',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                : const Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Column(
                                      children: [
                                        CircularProgressIndicator(
                                          color: Colors.cyan,
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
