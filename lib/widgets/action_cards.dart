import 'package:flutter/material.dart';

class ActionCard extends StatelessWidget {
  const ActionCard(
      {super.key,
      required this.title,
      required this.page,
      required this.color});
  final String title;
  final Widget page;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
