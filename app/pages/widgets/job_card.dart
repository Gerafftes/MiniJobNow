import 'package:flutter/material.dart';

class JobCard extends StatelessWidget {
  final String title;
  final String time;
  final String price;
  final Color color;
  final Color textColor;
  final Color buttonColor;
  final Color timeTextColor;

  const JobCard({
    super.key,
    required this.title,
    required this.time,
    required this.price,
    required this.color,
    required this.textColor,
    required this.buttonColor,
    required this.timeTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(color: timeTextColor, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          IntrinsicWidth(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
                elevation: 0,
              ),
              onPressed: () {},
              child: Text('Job annehmen', style: TextStyle(color: textColor)),
            ),
          ),
        ],
      ),
    );
  }
}
