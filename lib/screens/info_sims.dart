import 'package:flutter/material.dart';
import 'package:jfullinfo/jFullInfo.dart';
import 'package:system_monitor/style/styles.dart';
import 'package:system_monitor/widgets/container_info.dart';

class InfoSims extends StatefulWidget {
  const InfoSims({super.key});

  @override
  State<InfoSims> createState() => _InfoSimsState();
}

class _InfoSimsState extends State<InfoSims> {
  String? operadoraName,
      mnc,
      subscribeId,
      slotIndex,
      cardId,
      mcc,
      operadoraId,
      countryIso,
      displayName,
      iccId;

  @override
  void initState() {
    super.initState();
    getSims();
  }

  final _jFullInfo = JFullInfo();
  
  Future<void> getSims() async {
    final sims = await _jFullInfo.getSimInformation();

    setState(() {
      operadoraName = sims.first.carrierName;
      cardId = sims.first.cardId;
      operadoraId = sims.first.carrierId;
      countryIso = sims.first.countryIso;
      displayName = sims.first.displayName;
      iccId = sims.first.iccId;
      mcc = sims.first.mcc;
      mnc = sims.first.mnc;
      slotIndex = sims.first.slotIndex;
      subscribeId = sims.first.subscribeId;
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthSized = MediaQuery.of(context).size.width;
    double heightSized = MediaQuery.of(context).size.height;
    return 
        operadoraName != null
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
                            const Image(
                              height: 50,
                              image: AssetImage(
                                'assets/images/chip.png',
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '$operadoraName',
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
                            name: 'ID da operadora',
                            value: '$operadoraId',
                          ),
                          InfoContainer(
                            name: 'ID do Chip',
                            value: '$cardId',
                          ),
                          InfoContainer(
                            name: 'País',
                            value: '$countryIso',
                          ),
                          InfoContainer(
                            name: 'Nome de Exibição',
                            value: '$displayName',
                          ),
                          InfoContainer(
                            name: 'ID do icc',
                            value: '$iccId',
                          ),
                          InfoContainer(
                            name: 'MCC',
                            value: '$mcc',
                          ),
                          InfoContainer(
                            name: 'MNC',
                            value: '$mnc',
                          ),
                          InfoContainer(
                            name: 'Indice do Slot',
                            value: '$slotIndex',
                          ),
                          InfoContainer(
                            name: 'ID de inscrição',
                            value: '$subscribeId',
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
          );
  }
}
