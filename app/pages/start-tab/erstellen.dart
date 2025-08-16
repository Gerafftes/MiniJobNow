import 'package:flutter/material.dart';
import '../../widgets/job_card.dart';

class HilfeSuchenContent extends StatelessWidget {
  final Color cardColor;
  final Color secondaryText;
  final Color borderColor;
  final Color textColor;
  final Color jobCardColor;
  final Color jobButtonColor;
  final Color timeTextColor;
  final Color buttonTextColor;

  const HilfeSuchenContent({
    super.key,
    required this.cardColor,
    required this.secondaryText,
    required this.borderColor,
    required this.textColor,
    required this.jobCardColor,
    required this.jobButtonColor,
    required this.timeTextColor,
    required this.buttonTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    double h(double percent) => screenHeight * percent; // height-based spacing
    final double blockPadding = screenWidth * 0.053; // ~20 @ 375px width
    final double cornerRadius = screenWidth * 0.04; // ~15 @ 375px width

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(blockPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(cornerRadius),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Was möchtest du erstellen?',
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Erstelle entweder einen einmaligen Auftrag oder biete eine dauerhafte Dienstleistung an.',
                style: TextStyle(
                  color: secondaryText,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: h(0.037)),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF007AFF),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(cornerRadius),
              ),
              minimumSize: Size.fromHeight(h(0.07)),
              elevation: 0,
              textStyle: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            child: const Text('+ Job erstellen'),
          ),
        ),
        SizedBox(height: h(0.01)),
        Text(
          'Und Hilfe erhalten',
          style: TextStyle(color: secondaryText, fontSize: 14),
        ),
        SizedBox(height: h(0.02)),
        Center(
          child: Text(
            'Oder',
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
        SizedBox(height: h(0.02)),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF007AFF),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(cornerRadius),
              ),
              minimumSize: Size.fromHeight(h(0.07)),
              elevation: 0,
              textStyle: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            child: const Text('+ Dienstleistung anbieten'),
          ),
        ),
        SizedBox(height: h(0.01)),
        Text(
          'Und Geld verdienen',
          style: TextStyle(color: secondaryText, fontSize: 14),
        ),
        SizedBox(height: h(0.02)),
        Text(
          'Deine Aufträge',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(height: h(0.02)),
        JobCard(
          title: 'Gassi gehen',
          time: 'Heute, 14:00',
          price: '10 €',
          color: jobCardColor,
          textColor: textColor,
          buttonColor: const Color(0xFFD6543D),
          timeTextColor: timeTextColor,
          buttonTextColor: Colors.white,
          buttonLabel: 'Cancel',
        ),
        SizedBox(height: h(0.015)),
        JobCard(
          title: 'Einkaufshilfe',
          time: 'Heute, 15:00',
          price: '12 €',
          color: jobCardColor,
          textColor: textColor,
          buttonColor: const Color(0xFFD6543D),
          timeTextColor: timeTextColor,
          buttonTextColor: Colors.white,
          buttonLabel: 'Cancel',
        ),
        SizedBox(height: h(0.015)),
        JobCard(
          title: 'Paket abholen',
          time: 'Heute, 16:30',
          price: '8 €',
          color: jobCardColor,
          textColor: textColor,
          buttonColor: const Color(0xFFD6543D),
          timeTextColor: timeTextColor,
          buttonTextColor: Colors.white,
          buttonLabel: 'Cancel',
        ),
      ],
    );
  }
}
