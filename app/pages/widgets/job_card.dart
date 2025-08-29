import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JobCard extends StatelessWidget {
  final String title;
  final String time;
  final String price;
  final String? distance;
  final Color color;
  final Color textColor;
  final Color buttonColor;
  final Color timeTextColor;
  final Color buttonTextColor;
  final String buttonLabel;
  final bool showVerified;

  const JobCard({
    super.key,
    required this.title,
    required this.time,
    required this.price,
    this.distance,
    required this.color,
    required this.textColor,
    required this.buttonColor,
    required this.timeTextColor,
    required this.buttonTextColor,
    this.buttonLabel = 'Job annehmen',
    this.showVerified = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 15, 18, 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        if (showVerified) ...[
                          const SizedBox(width: 6),
                          SvgPicture.asset(
                            'assets/icons/verified.svg',
                            width: 16,
                            height: 16,
                            colorFilter: const ColorFilter.mode(
                              Color(0xFFFFD700),
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 10.5),
                    Row(
                      children: [
                        Text(
                          distance ?? '',
                          style: TextStyle(
                            color: timeTextColor,
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                        if (distance != null) ...[
                          const SizedBox(width: 8),
                          Text(
                            '|',
                            style: TextStyle(
                              color: timeTextColor,
                              fontSize: 14,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          time,
                          style: TextStyle(
                            color: timeTextColor,
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  price,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    height: 1.4,
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
              child: Text(
                buttonLabel,
                style: TextStyle(color: buttonTextColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
