import 'dart:async';
import 'package:app_analysis/app_analysis.dart';
import 'package:device_info_null_safety/device_info_null_safety.dart';
import 'package:device_information/device_information.dart';
import 'package:flutter/material.dart';
import 'package:jfullinfo/jFullInfo.dart';
import 'package:system_monitor/style/styles.dart';
import 'package:system_monitor/widgets/container_info.dart';

class DeviceScreen extends StatefulWidget {
  const DeviceScreen({super.key});

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  String? _getDevice,
      _getnumberVersion,
      _getsdkVersion,
      _getproduct,
      _getBootloader,
      _gethardware,
      _getBrand,
      _getBoard,
      _getManufacturer,
      _getModel,
      _getHost,
      _getUpdate,
      _getTypeDevice,
      algorithms,
      _getAndroidVersion,
      _getidAndroid,
      _hasSdCard,
      _dateFormat,
      _timeFormat,
      _upTime,
      _getCpuname,
      _supportedABI64,
      _fingerPrint,
      _getCodename;

  //String? _teste;
  bool? _isRooted;
  late Timer time;

  @override
  void initState() {
    super.initState();
    time = Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        Map<String, dynamic> getinfoDevice =
            await _deviceInfoNullSafety.configInfo;
        setState(() {
          _hasSdCard = getinfoDevice['hasSdCard'].toString();
          _dateFormat = getinfoDevice['formattedDate'].toString();
          _timeFormat = getinfoDevice['formattedTime'].toString();
          _upTime = getinfoDevice['uptime'].toString();
        });
      },
    );
    getDevice();
  }

  @override
  void dispose() {
    time.cancel();
    super.dispose();
  }

  final _jFullInfo = JFullInfo();
  CpuInfoProvider infoCpu = CpuInfoProvider();
  final DeviceInfoNullSafety _deviceInfoNullSafety = DeviceInfoNullSafety();

  Future<void> getDevice() async {
    final getHardware = await _jFullInfo.getHardwareInformation();
    final getAndroid = await _jFullInfo.getAndroidInformation();
    final hardware = await DeviceInformation.hardware;
    final hardware1 = await DeviceInformation.cpuName;
    Map<String, dynamic> systemInfo = await _deviceInfoNullSafety.systemInfo;
    Map<String,dynamic> abiInfo = await _deviceInfoNullSafety.abiInfo;


    if (!mounted) return;

    setState(() {
      //_teste = abiInfo.toString();

      _getCpuname = hardware1;

      _getnumberVersion = getHardware.deviceId;
      _getsdkVersion = getAndroid.androidSdk;
      _getCodename = getAndroid.codeName;
      _getproduct = getHardware.product;
      _getDevice = getHardware.device;
      _getBrand = getHardware.brand;
      _getBoard = getHardware.board;
      _getManufacturer = getHardware.manufacturer;
      _getModel = getHardware.model;
      _getidAndroid = getHardware.androidId;
      _getHost = getHardware.host;
      _getBootloader = getHardware.bootloader;

      _gethardware = hardware;
      _getAndroidVersion = getAndroid.release;

      _getUpdate = getAndroid.securityPatch;

      _getTypeDevice = systemInfo['phoneType'];
      _isRooted = systemInfo['isDeviceRooted'];
      _fingerPrint = systemInfo['fingerprint'];

      _supportedABI64 = abiInfo['supportedABI'];
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthSized = MediaQuery.of(context).size.width;
    double heightSized = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: _dateFormat != null
            ? Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    padding: const EdgeInsets.only(bottom: 10),
                    width: widthSized * 3,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                        boxShadow: [boxShadow]),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          height: 50,
                          width: widthSized,
                          decoration: const BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 7),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.phone_android,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                                const SizedBox(width: 15),
                                Text(
                                  '$_getManufacturer',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 10),
                          child: Column(
                            children: [
                              InfoContainer(
                                name: 'Versão do Android',
                                value: '$_getAndroidVersion',
                              ),
                              InfoContainer(
                                name: 'Modelo',
                                value: '$_getModel',
                              ),
                              InfoContainer(
                                name: 'Marca',
                                value: '$_getBrand',
                              ),
                              InfoContainer(
                                name: 'Dispositivo',
                                value: '$_getDevice',
                              ),
                              InfoContainer(
                                name: 'Fabricante',
                                value: '$_getManufacturer',
                              ),
                              InfoContainer(
                                name: 'Painel',
                                value: '$_getBoard',
                              ),
                              InfoContainer(
                                name: 'Hardware',
                                value: '$_gethardware',
                              ),
                              InfoContainer(
                                name: 'Produto',
                                value: '$_getproduct',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    padding: const EdgeInsets.only(bottom: 10),
                    width: widthSized * 3,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                        boxShadow: [boxShadow]),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          height: 50,
                          width: widthSized,
                          decoration: const BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 7),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.system_security_update_warning_sharp,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                                const SizedBox(width: 15),
                                const Text(
                                  'Sistema',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            children: [
                              InfoContainer(
                                name: 'SDK Version',
                                value: '$_getsdkVersion',
                              ),
                              InfoContainer(
                                name: 'Numero da Versão',
                                value: '$_getnumberVersion',
                              ),
                              InfoContainer(
                                name: 'Nome da CPU',
                                value: '$_getCpuname',
                              ),
                              InfoContainer(
                                name: 'Código',
                                value: '$_getCodename',
                              ),
                              InfoContainer(
                                name: 'Data Atual',
                                value: '$_dateFormat',
                              ),
                              InfoContainer(
                                name: 'Hora Atual',
                                value: '$_timeFormat',
                              ),
                              InfoContainer(
                                name: 'Tempo ativo',
                                value: '$_upTime',
                              ),
                              InfoContainer(
                                name: 'Tem SDcard',
                                value: _hasSdCard == 'true' ? 'Sim' : 'Não',
                              ),
                              InfoContainer(
                                name: 'Root',
                                value: _isRooted != false ? 'Sim' : 'Não',
                              ),
                              InfoContainer(
                                name: 'ABIs de suporte',
                                value: '$_supportedABI64',
                              ),
                              InfoContainer(
                                name: 'FingerPrint',
                                value: _fingerPrint != null ? '$_fingerPrint' : 'Não acessado',
                              ),
                            ],
                          ),
                        ),
                        //Text('$_teste')
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    padding: const EdgeInsets.only(bottom: 10),
                    width: widthSized * 3,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                        boxShadow: [boxShadow]),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 15, right: 10),
                          child: Column(
                            children: [
                              InfoContainer(
                                name: 'Tipo do dispositivo',
                                value: _getTypeDevice != null ? '$_getTypeDevice' : 'Não acessado',
                              ),
                              InfoContainer(
                                name: 'Bootloader',
                                value: '$_getBootloader',
                              ),
                              InfoContainer(
                                name: 'ID do Android',
                                value: '$_getidAndroid',
                              ),
                              InfoContainer(
                                name: 'Host',
                                value: '$_getHost',
                              ),
                              const InfoContainer(
                                name: 'Idioma do Android',
                                value: 'pt-br',
                              ),
                              InfoContainer(
                                name: 'Update Security',
                                value: '$_getUpdate',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: heightSized / 3),
                      child: CircularProgressIndicator(
                        color: Colors.cyan.withOpacity(.9),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
