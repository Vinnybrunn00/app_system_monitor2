import 'package:flutter/material.dart';

class InfoContainer extends StatefulWidget {
  final String name;
  final String value;

  const InfoContainer({
    super.key,
    required this.name,
    required this.value,
  });

  @override
  State<InfoContainer> createState() => _InfoContainerState();
}

class _InfoContainerState extends State<InfoContainer> {
  @override
  Widget build(BuildContext context) {
    double widthSized = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.name,
            style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: widthSized / 1.9,
            child: Text(
              widget.value,
              style: TextStyle(
                  color: Colors.cyan[600],
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
