import 'package:flutter/material.dart';

class ShowInfoSensors extends StatefulWidget {
  final String title;
  //final String image;
  final String name;
  final String vendor;
  final String power;
  final String version;

  const ShowInfoSensors({
    super.key,
    required this.title,
    //required this.image,
    required this.name,
    required this.vendor,
    required this.power,
    required this.version,
  });

  @override
  State<ShowInfoSensors> createState() => _ShowInfoSensorsState();
}

class _ShowInfoSensorsState extends State<ShowInfoSensors> {
  @override
  Widget build(BuildContext context) {
    double widthSized = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 2),
      width: widthSized,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            color: Colors.black.withOpacity(.2)
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 20,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          widget.title,
                          style: TextStyle(color: Colors.cyan[600]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nome: ${widget.name}'),
                Text('Vendedor: ${widget.vendor}'),
                Text('Energia: ${widget.power}'),
                Text('Versão: ${widget.version}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
