import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  int _bottomNavIndex = 0;
  int _mainTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Color bgColor = Colors.black;
    final Color cardColor = const Color(0xFF232323);
    final Color cardColorActive = const Color(0xFF353535); // Helleres Grau
    final Color borderColor = const Color.fromRGBO(255, 255, 255, 0.18);
    final Color secondaryText = const Color.fromRGBO(255, 255, 255, 0.7);

    Widget content;
    switch (selectedIndex) {
      case 0:
        content = _IchHelfeGernContent(
          cardColor: cardColor,
          secondaryText: secondaryText,
          borderColor: borderColor,
        );
        break;
      case 1:
        content = _HilfeSuchenContent(
          cardColor: cardColor,
          secondaryText: secondaryText,
          borderColor: borderColor,
        );
        break;
      case 2:
        content = _IchBieteAnContent(
          cardColor: cardColor,
          secondaryText: secondaryText,
          borderColor: borderColor,
        );
        break;
      default:
        content = const SizedBox();
    }

    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'SF Pro'),
      ),
      child: Scaffold(
        backgroundColor: bgColor,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: bgColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.white,
              size: 28,
            ),
            onPressed: () => setState(() => _bottomNavIndex = 3),
          ),
          title: const Text(
            'MiniJobNow',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () => setState(() => _bottomNavIndex = 2),
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: CircleAvatar(
                  backgroundColor: cardColor,
                  radius: 20,
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: IndexedStack(
          index: _bottomNavIndex,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 92,
                  left: 16.0,
                  right: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // Drei große Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _HomeActionButton(
                          iconPath: 'assets/icons/Artboard 2.svg',
                          label: 'Ich helfe\ngerne',
                          color:
                              selectedIndex == 0 ? cardColorActive : cardColor,
                          onTap: () => setState(() => selectedIndex = 0),
                          isSelected: selectedIndex == 0,
                        ),
                        _HomeActionButton(
                          iconPath: 'assets/icons/Artboard 1.svg',
                          label: 'Hilfe\nsuchen',
                          color:
                              selectedIndex == 1 ? cardColorActive : cardColor,
                          onTap: () => setState(() => selectedIndex = 1),
                          isSelected: selectedIndex == 1,
                        ),
                        _HomeActionButton(
                          iconPath: 'assets/icons/Artboard 3.svg',
                          label: 'Ich biete\nan',
                          color:
                              selectedIndex == 2 ? cardColorActive : cardColor,
                          onTap: () => setState(() => selectedIndex = 2),
                          isSelected: selectedIndex == 2,
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    content,
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Center(
              child: Text(
                'Support',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text(
                'Profil',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text(
                'Notifications',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          minimum: const EdgeInsets.only(bottom: 4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    child: BottomNavigationBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      selectedItemColor: Colors.white,
                      unselectedItemColor: const Color.fromARGB(
                        153,
                        255,
                        255,
                        255,
                      ),
                      showSelectedLabels: true,
                      showUnselectedLabels: true,
                      items: const [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.home),
                          label: 'Start',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.headset),
                          label: 'Support',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.person_outline),
                          label: 'Profil',
                        ),
                      ],
                      currentIndex:
                          _bottomNavIndex < 3 ? _bottomNavIndex : _mainTabIndex,
                      onTap: (index) {
                        setState(() {
                          if (index == 0 && _bottomNavIndex == 0) {
                            // Bereits auf Start, aber evtl. nicht auf "Ich helfe gerne"
                            selectedIndex = 0;
                          } else {
                            _bottomNavIndex = index;
                            if (index < 3) _mainTabIndex = index;
                          }
                        });
                      },
                      type: BottomNavigationBarType.fixed,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeActionButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final Color color;
  final VoidCallback onTap;
  final bool isSelected;

  const _HomeActionButton({
    required this.iconPath,
    required this.label,
    required this.color,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
            boxShadow:
                isSelected
                    ? [
                      BoxShadow(
                        color: const Color.fromRGBO(255, 255, 255, 0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                    : [],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                iconPath,
                width: 32,
                height: 32,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Seiteninhalte ---
class _IchHelfeGernContent extends StatelessWidget {
  final Color cardColor;
  final Color secondaryText;
  final Color borderColor;
  const _IchHelfeGernContent({
    required this.cardColor,
    required this.secondaryText,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Info-Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Finde spontane Jobs in deiner Nähe.',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Verdiene flexibel Geld, indem du anderen bei kleinen Aufgaben hilfst – vom Einkauf bis zur Rasenpflege.',
                style: TextStyle(
                  color: secondaryText,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'In deiner Nähe',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: const Color(0xFF232323),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  builder: (context) {
                    double distance = 5;
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Filter',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                style: TextButton.styleFrom(
                                  foregroundColor: const Color(0xFF276EFF),
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(0, 0),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text(
                                  'Speichern',
                                  style: TextStyle(
                                    color: Color(0xFF276EFF),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Distanz',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          StatefulBuilder(
                            builder: (context, setModalState) {
                              return Row(
                                children: [
                                  Expanded(
                                    flex: 9,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 12),
                                      child: SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                          activeTrackColor: const Color(0xFF276EFF),
                                          inactiveTrackColor: Colors.white24,
                                          trackHeight: 4.0,
                                          thumbColor: const Color(0xFF276EFF),
                                          overlayColor: const Color(0x33276EFF),
                                          valueIndicatorColor: const Color(0xFF276EFF),
                                          showValueIndicator: ShowValueIndicator.always,
                                          tickMarkShape: const RoundSliderTickMarkShape(
                                            tickMarkRadius: 3,
                                          ),
                                          activeTickMarkColor: Colors.white,
                                          inactiveTickMarkColor: Colors.white38,
                                        ),
                                        child: Slider(
                                          min: 1,
                                          max: 15,
                                          label: '${distance.round()} km',
                                          value: distance,
                                          onChanged: (value) {
                                            setModalState(() {
                                              distance = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  SizedBox(
                                    width: 50,
                                    child: Text(
                                      '${distance.round()} km',
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Kategorie',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1A1A),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Alle',
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                ),
                                const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Sortieren nach',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1A1A1A),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Neu nach Alt',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1A1A1A),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Alt nach Neu',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFF276EFF)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              child: const Text(
                                'Kartenansicht',
                                style: TextStyle(color: Color(0xFF276EFF)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.tune, color: Colors.white, size: 28),
              style: IconButton.styleFrom(
                backgroundColor: cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _JobCard(
          title: 'Gassi gehen',
          time: 'Heute, 14:00',
          price: '10 €',
          color: cardColor,
        ),
        const SizedBox(height: 12),
        _JobCard(
          title: 'Einkaufshilfe',
          time: 'Heute, 15:00',
          price: '12 €',
          color: cardColor,
        ),
        const SizedBox(height: 12),
        _JobCard(
          title: 'Paket abholen',
          time: 'Heute, 16:30',
          price: '8 €',
          color: cardColor,
        ),
      ],
    );
  }
}

class _HilfeSuchenContent extends StatelessWidget {
  final Color cardColor;
  final Color secondaryText;
  final Color borderColor;
  const _HilfeSuchenContent({
    required this.cardColor,
    required this.secondaryText,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Beispielinhalt für "Hilfe suchen"
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Stell einfach deinen Job ein.',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Wenn du Hilfe brauchst, veröffentliche deinen Auftrag – jemand aus deiner Umgebung unterstützt dich schnell.',
                style: TextStyle(
                  color: secondaryText,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF276EFF),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              minimumSize: const Size.fromHeight(56),
              elevation: 0,
              textStyle: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            child: const Text('+ Job erstellen'),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Laufende Jobs',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 28),
        // Weitere Inhalte ...
      ],
    );
  }
}

class _IchBieteAnContent extends StatelessWidget {
  final Color cardColor;
  final Color secondaryText;
  final Color borderColor;
  const _IchBieteAnContent({
    required this.cardColor,
    required this.secondaryText,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Beispielinhalt für "Ich biete an"
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Teile, was du gut kannst.',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Erstelle feste Angebote für deine Dienstleistungen oder finde Anbieter für genau das, was du suchst.',
                style: TextStyle(
                  color: secondaryText,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        // Weitere Inhalte ...
      ],
    );
  }
}

class _JobCard extends StatelessWidget {
  final String title;
  final String time;
  final String price;
  final Color color;

  const _JobCard({
    required this.title,
    required this.time,
    required this.price,
    required this.color,
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: const TextStyle(
                    color: Colors.white,
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
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {},
              child: const Text('Job annehmen'),
            ),
          ),
        ],
      ),
    );
  }
}
