import 'dart:ui';
import 'dart:math' as math;
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
  String _themeMode = 'auto'; // 'light', 'auto', 'dark'

  @override
  Widget build(BuildContext context) {
    final bool isDark =
        _themeMode == 'auto'
            ? MediaQuery.of(context).platformBrightness == Brightness.dark
            : _themeMode == 'dark';
    final Color bgColor = isDark ? Colors.black : const Color(0xFFE6E6E6);
    final Color cardColor =
        isDark
            ? const Color(0xFF0D0D0D)
            : const Color(0xFFF2F2F2); // Nicht ausgewählt
    final Color cardColorActive =
        isDark ? const Color(0xFF1A1A1A) : Colors.white; // Ausgewählt
    final Color borderColor =
        isDark
            ? const Color.fromRGBO(255, 255, 255, 0.18)
            : const Color(0xFFCCCCCC);
    final Color secondaryText =
        isDark
            ? const Color.fromRGBO(255, 255, 255, 0.7)
            : const Color.fromRGBO(13, 13, 13, 0.7);
    final Color jobCardColor = isDark ? cardColor : const Color(0xFFF2F2F2);
    final Color jobButtonColor =
        isDark ? const Color(0xFF1A1A1A) : Colors.white;
    final Color textColor =
        isDark ? const Color(0xFFF2F2F2) : const Color(0xFF0D0D0D);
    final Color timeTextColor =
        isDark ? const Color(0xFFB3B3B3) : const Color(0xFF4D4D4D);
    final Color bellIconColor = isDark ? Colors.white : const Color(0xFF0D0D0D);
    final Color homeActionIconColor =
        isDark ? Colors.white : const Color(0xFF1A1A1A);

    Widget content;
    switch (selectedIndex) {
      case 0:
        content = _IchHelfeGernContent(
          cardColor: cardColor,
          secondaryText: secondaryText,
          borderColor: borderColor,
          textColor: textColor,
          jobCardColor: jobCardColor,
          jobButtonColor: jobButtonColor,
          timeTextColor: timeTextColor,
          filterIconColor: bellIconColor,
          themeMode: _themeMode,
        );
        break;
      case 1:
        content = _HilfeSuchenContent(
          cardColor: cardColor,
          secondaryText: secondaryText,
          borderColor: borderColor,
          textColor: textColor,
        );
        break;
      case 2:
        content = _IchBieteAnContent(
          cardColor: cardColor,
          secondaryText: secondaryText,
          borderColor: borderColor,
          textColor: textColor,
        );
        break;
      default:
        content = const SizedBox();
    }

    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'SF Pro'),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: bgColor,
        child: Scaffold(
          backgroundColor: bgColor,
          extendBody: true,
          appBar: AppBar(
            backgroundColor: bgColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.notifications_none,
                color: bellIconColor,
                size: 28,
              ),
              onPressed: () => setState(() => _bottomNavIndex = 3),
            ),
            title: Text(
              'MiniJobNow',
              style: TextStyle(
                color: textColor,
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
                                selectedIndex == 0
                                    ? cardColorActive
                                    : cardColor,
                            onTap: () => setState(() => selectedIndex = 0),
                            isSelected: selectedIndex == 0,
                            textColor: textColor,
                            iconColor: homeActionIconColor,
                          ),
                          _HomeActionButton(
                            iconPath: 'assets/icons/Artboard 1.svg',
                            label: 'Hilfe\nsuchen',
                            color:
                                selectedIndex == 1
                                    ? cardColorActive
                                    : cardColor,
                            onTap: () => setState(() => selectedIndex = 1),
                            isSelected: selectedIndex == 1,
                            textColor: textColor,
                            iconColor: homeActionIconColor,
                          ),
                          _HomeActionButton(
                            iconPath: 'assets/icons/Artboard 3.svg',
                            label: 'Ich biete\nan',
                            color:
                                selectedIndex == 2
                                    ? cardColorActive
                                    : cardColor,
                            onTap: () => setState(() => selectedIndex = 2),
                            isSelected: selectedIndex == 2,
                            textColor: textColor,
                            iconColor: homeActionIconColor,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Profil',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Theme',
                          style: TextStyle(color: textColor, fontSize: 16),
                        ),
                        const SizedBox(width: 16),
                        SegmentedButton<String>(
                          segments: const [
                            ButtonSegment<String>(
                              value: 'light',
                              label: Text('Light'),
                            ),
                            ButtonSegment<String>(
                              value: 'auto',
                              label: Text('Auto'),
                            ),
                            ButtonSegment<String>(
                              value: 'dark',
                              label: Text('Dark'),
                            ),
                          ],
                          selected: {_themeMode},
                          onSelectionChanged: (Set<String> newSelection) {
                            setState(() {
                              _themeMode = newSelection.first;
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>((
                                  Set<MaterialState> states,
                                ) {
                                  if (states.contains(MaterialState.selected)) {
                                    return const Color(0xFF007AFF);
                                  }
                                  return cardColor;
                                }),
                            foregroundColor:
                                MaterialStateProperty.resolveWith<Color>((
                                  Set<MaterialState> states,
                                ) {
                                  if (states.contains(MaterialState.selected)) {
                                    return Colors.white;
                                  }
                                  return textColor;
                                }),
                          ),
                        ),
                      ],
                    ),
                  ],
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
                  filter: ImageFilter.blur(
                    sigmaX: isDark ? 5 : 3,
                    sigmaY: isDark ? 5 : 3,
                  ),
                  child: Container(
                    height: 64,
                    decoration: BoxDecoration(
                      color:
                          isDark
                              ? Colors.white.withOpacity(0.3)
                              : const Color(0xFFCCCCCC).withOpacity(0.8),
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
                        // Farben für die BottomNavigationBar anpassen
                        bottomNavigationBarTheme: BottomNavigationBarThemeData(
                          selectedItemColor:
                              isDark ? Colors.white : const Color(0xFF000000),
                          unselectedItemColor:
                              isDark
                                  ? const Color.fromARGB(153, 255, 255, 255)
                                  : const Color(0xFF333333),
                          selectedLabelStyle: TextStyle(
                            color:
                                isDark ? Colors.white : const Color(0xFF000000),
                          ),
                          unselectedLabelStyle: TextStyle(
                            color:
                                isDark
                                    ? const Color.fromARGB(153, 255, 255, 255)
                                    : const Color(0xFF333333),
                          ),
                        ),
                      ),
                      child: BottomNavigationBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        // Farben werden jetzt über das Theme gesetzt
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
                            _bottomNavIndex < 3
                                ? _bottomNavIndex
                                : _mainTabIndex,
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
  final Color textColor;
  final Color iconColor;

  const _HomeActionButton({
    required this.iconPath,
    required this.label,
    required this.color,
    required this.onTap,
    required this.isSelected,
    required this.textColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: _getMargin(context),
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
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
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

  EdgeInsets _getMargin(BuildContext context) {
    // Hole die Position des Buttons im Row-Widget
    final parent = context.findAncestorWidgetOfExactType<Row>();
    if (parent != null && parent.children.length == 3) {
      final idx = parent.children.indexOf(this);
      if (idx == 0) {
        // Erster Button: kein linker Margin
        return const EdgeInsets.only(right: 6);
      } else if (idx == 2) {
        // Letzter Button: kein rechter Margin
        return const EdgeInsets.only(left: 6);
      }
    }
    // Mittlerer oder Fallback
    return const EdgeInsets.symmetric(horizontal: 6);
  }
}

// --- Seiteninhalte ---
class _IchHelfeGernContent extends StatelessWidget {
  final Color cardColor;
  final Color secondaryText;
  final Color borderColor;
  final Color textColor;
  final Color jobCardColor;
  final Color jobButtonColor;
  final Color timeTextColor;
  final Color filterIconColor;
  final String themeMode;
  const _IchHelfeGernContent({
    required this.cardColor,
    required this.secondaryText,
    required this.borderColor,
    required this.textColor,
    required this.jobCardColor,
    required this.jobButtonColor,
    required this.timeTextColor,
    required this.filterIconColor,
    required this.themeMode,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark =
        themeMode == 'auto'
            ? MediaQuery.of(context).platformBrightness == Brightness.dark
            : themeMode == 'dark';
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
              Text(
                'Finde spontane Jobs in deiner Nähe.',
                style: TextStyle(
                  color: textColor,
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
            Text(
              'In deiner Nähe',
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            IconButton(
              onPressed: () {
                final bool isDark =
                    themeMode == 'auto'
                        ? MediaQuery.of(context).platformBrightness ==
                            Brightness.dark
                        : themeMode == 'dark';
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor:
                      isDark
                          ? const Color(0xFF0D0D0D)
                          : const Color(0xFFE6E6E6),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  builder: (context) {
                    double distance = 5;
                    bool isCategoryOpen = false;
                    String selectedCategory = 'Alle';
                    final List<String> categories = [
                      'Haushalt & Reinigung',
                      'Gartenarbeit & Pflanzenpflege',
                      'Umzug & Möbel tragen',
                      'Reparaturen & Heimwerken',
                      'Kinderbetreuung',
                      'Seniorenhilfe',
                      'Einkäufe & Besorgungen',
                      'Nachhilfe & Technikhilfe',
                      'Haustierbetreuung',
                      'Sonstiges / Allgemeine Hilfe',
                    ];
                    return StatefulBuilder(
                      builder: (context, setModalState) {
                        final screenHeight = MediaQuery.of(context).size.height;
                        final screenWidth = MediaQuery.of(context).size.width;
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.55,
                          padding: EdgeInsets.all(
                            screenWidth * 0.06,
                          ), // ~24px on 400px width
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Filter',
                                    style: TextStyle(
                                      color:
                                          isDark
                                              ? Colors.white
                                              : const Color(0xFF000000),
                                      fontSize:
                                          screenWidth *
                                          0.05, // ~20px on 400px width
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed:
                                        () => Navigator.of(context).pop(),
                                    style: TextButton.styleFrom(
                                      foregroundColor: const Color(0xFF007AFF),
                                      padding: EdgeInsets.zero,
                                      minimumSize: const Size(0, 0),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      'Speichern',
                                      style: TextStyle(
                                        color: Color(0xFF007AFF),
                                        fontSize:
                                            screenWidth *
                                            0.04, // ~16px on 400px width
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenHeight * 0.03,
                              ), // ~24px on 800px height
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Distanz',
                                  style: TextStyle(
                                    color:
                                        isDark
                                            ? Colors.white
                                            : const Color(0xFF000000),
                                    fontSize:
                                        screenWidth *
                                        0.04, // ~16px on 400px width
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ), // ~16px on 800px height
                              Row(
                                children: [
                                  Expanded(
                                    flex: 9,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        right: screenWidth * 0.03,
                                      ), // ~12px on 400px width
                                      child: SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                          activeTrackColor: const Color(
                                            0xFF007AFF,
                                          ),
                                          inactiveTrackColor:
                                              isDark
                                                  ? Colors.white24
                                                  : const Color(0xFFB3B3B3),
                                          trackHeight:
                                              screenHeight *
                                              0.005, // ~4px on 800px height
                                          thumbColor: const Color(0xFF007AFF),
                                          overlayColor: const Color(0x33007AFF),
                                          valueIndicatorColor: const Color(
                                            0xFF007AFF,
                                          ),
                                          showValueIndicator:
                                              ShowValueIndicator.always,
                                          tickMarkShape: RoundSliderTickMarkShape(
                                            tickMarkRadius:
                                                screenHeight *
                                                0.004, // ~3px on 800px height
                                          ),
                                          activeTickMarkColor:
                                              isDark
                                                  ? Colors.white
                                                  : const Color(0xFF000000),
                                          inactiveTickMarkColor:
                                              isDark
                                                  ? Colors.white38
                                                  : const Color(0xFF666666),
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
                                  SizedBox(
                                    width: screenWidth * 0.03,
                                  ), // ~12px on 400px width
                                  SizedBox(
                                    width:
                                        screenWidth *
                                        0.125, // ~50px on 400px width
                                    child: Text(
                                      '${distance.round()} km',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color:
                                            isDark
                                                ? Colors.white
                                                : const Color(0xFF000000),
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            screenWidth *
                                            0.04, // ~16px on 400px width
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenHeight * 0.015,
                              ), // ~12px on 800px height
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Kategorie',
                                  style: TextStyle(
                                    color:
                                        isDark
                                            ? Colors.white
                                            : const Color(0xFF000000),
                                    fontSize:
                                        screenWidth *
                                        0.04, // ~16px on 400px width
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.01,
                              ), // ~8px on 800px height
                              GestureDetector(
                                onTap: () {
                                  setModalState(
                                    () => isCategoryOpen = !isCategoryOpen,
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        screenWidth *
                                        0.04, // ~16px on 400px width
                                    vertical:
                                        screenHeight *
                                        0.015, // ~12px on 800px height
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        isDark
                                            ? const Color(0xFF1A1A1A)
                                            : const Color(0xFFF2F2F2),
                                    borderRadius: BorderRadius.circular(
                                      screenWidth * 0.0375,
                                    ), // ~15px on 400px width
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        selectedCategory,
                                        style: TextStyle(
                                          color:
                                              isDark
                                                  ? Colors.white
                                                  : const Color(0xFF000000),
                                          fontSize:
                                              screenWidth *
                                              0.04, // ~16px on 400px width
                                        ),
                                      ),
                                      TweenAnimationBuilder<double>(
                                        tween: Tween(
                                          begin: 0,
                                          end: isCategoryOpen ? 0.5 : 0.0,
                                        ),
                                        duration: const Duration(
                                          milliseconds: 200,
                                        ),
                                        builder:
                                            (context, turns, child) =>
                                                Transform.rotate(
                                                  angle: turns * 2 * math.pi,
                                                  child: child,
                                                ),
                                        child: Icon(
                                          Icons.keyboard_arrow_down,
                                          color:
                                              isDark
                                                  ? Colors.white
                                                  : const Color(0xFF000000),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (isCategoryOpen) ...[
                                SizedBox(
                                  height: screenHeight * 0.01,
                                ), // ~8px on 800px height
                                Container(
                                  decoration: BoxDecoration(
                                    color:
                                        isDark
                                            ? const Color(0xFF1A1A1A)
                                            : const Color(0xFFF2F2F2),
                                    borderRadius: BorderRadius.circular(
                                      screenWidth * 0.0375,
                                    ), // ~15px on 400px width
                                  ),
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: categories.length,
                                    separatorBuilder:
                                        (context, idx) => Divider(
                                          color:
                                              isDark
                                                  ? Colors.white12
                                                  : const Color(0xFFCCCCCC),
                                          height: 1,
                                        ),
                                    itemBuilder: (context, idx) {
                                      final cat = categories[idx];
                                      return ListTile(
                                        onTap: () {
                                          setModalState(() {
                                            selectedCategory = cat;
                                            isCategoryOpen = false;
                                          });
                                        },
                                        title: Text(
                                          cat,
                                          style: TextStyle(
                                            color:
                                                isDark
                                                    ? Colors.white
                                                    : const Color(0xFF000000),
                                            fontSize:
                                                screenWidth *
                                                0.04, // ~16px on 400px width
                                          ),
                                        ),
                                        trailing: GestureDetector(
                                          onTap: () {
                                            setModalState(() {
                                              selectedCategory = cat;
                                              isCategoryOpen = false;
                                            });
                                          },
                                          child: Container(
                                            width:
                                                screenWidth *
                                                0.06, // ~24px on 400px width
                                            height:
                                                screenWidth *
                                                0.06, // ~24px on 400px width
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color:
                                                    selectedCategory == cat
                                                        ? const Color(
                                                          0xFF007AFF,
                                                        )
                                                        : isDark
                                                        ? Colors.white38
                                                        : const Color(
                                                          0xFFCCCCCC,
                                                        ),
                                                width: 2,
                                              ),
                                              color:
                                                  selectedCategory == cat
                                                      ? const Color(0xFF007AFF)
                                                      : Colors.transparent,
                                            ),
                                            child:
                                                selectedCategory == cat
                                                    ? Icon(
                                                      Icons.check,
                                                      color:
                                                          isDark
                                                              ? Colors.white
                                                              : const Color(
                                                                0xFF000000,
                                                              ),
                                                      size:
                                                          screenWidth *
                                                          0.04, // ~16px on 400px width
                                                    )
                                                    : null,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                              SizedBox(
                                height: screenHeight * 0.02,
                              ), // ~16px on 800px height
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Sortieren von',
                                  style: TextStyle(
                                    color:
                                        isDark
                                            ? Colors.white
                                            : const Color(0xFF000000),
                                    fontSize:
                                        screenWidth *
                                        0.04, // ~16px on 400px width
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.01,
                              ), // ~8px on 800px height
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical:
                                            screenHeight *
                                            0.015, // ~12px on 800px height
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            isDark
                                                ? const Color(0xFF1A1A1A)
                                                : const Color(0xFFF2F2F2),
                                        borderRadius: BorderRadius.circular(
                                          screenWidth * 0.0375,
                                        ), // ~15px on 400px width
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Neu zu Alt',
                                        style: TextStyle(
                                          color:
                                              isDark
                                                  ? Colors.white
                                                  : const Color(0xFF000000),
                                          fontSize:
                                              screenWidth *
                                              0.04, // ~16px on 400px width
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.02,
                                  ), // ~8px on 400px width
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical:
                                            screenHeight *
                                            0.015, // ~12px on 800px height
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            isDark
                                                ? const Color(0xFF1A1A1A)
                                                : const Color(0xFFF2F2F2),
                                        borderRadius: BorderRadius.circular(
                                          screenWidth * 0.0375,
                                        ), // ~15px on 400px width
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Alt zu Neu',
                                        style: TextStyle(
                                          color:
                                              isDark
                                                  ? Colors.white
                                                  : const Color(0xFF000000),
                                          fontSize:
                                              screenWidth *
                                              0.04, // ~16px on 400px width
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ), // ~16px on 800px height
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor:
                                        isDark
                                            ? const Color(0xFF1A1A1A)
                                            : const Color(0xFFF2F2F2),
                                    foregroundColor: const Color(0xFF007AFF),
                                    side: const BorderSide(
                                      color: Color(0xFF007AFF),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        screenWidth * 0.0375,
                                      ), // ~15px on 400px width
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical:
                                          screenHeight *
                                          0.0175, // ~14px on 800px height
                                    ),
                                  ),
                                  child: Text(
                                    'Kartenansicht',
                                    style: TextStyle(
                                      color:
                                          isDark
                                              ? Colors.white
                                              : const Color(0xFF000000),
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          screenWidth *
                                          0.04, // ~16px on 400px width
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
              icon: Icon(Icons.tune, color: filterIconColor, size: 28),
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
          color: jobCardColor,
          textColor: textColor,
          buttonColor: jobButtonColor,
          timeTextColor: timeTextColor,
        ),
        const SizedBox(height: 12),
        _JobCard(
          title: 'Einkaufshilfe',
          time: 'Heute, 15:00',
          price: '12 €',
          color: jobCardColor,
          textColor: textColor,
          buttonColor: jobButtonColor,
          timeTextColor: timeTextColor,
        ),
        const SizedBox(height: 12),
        _JobCard(
          title: 'Paket abholen',
          time: 'Heute, 16:30',
          price: '8 €',
          color: jobCardColor,
          textColor: textColor,
          buttonColor: jobButtonColor,
          timeTextColor: timeTextColor,
        ),
      ],
    );
  }
}

class _HilfeSuchenContent extends StatelessWidget {
  final Color cardColor;
  final Color secondaryText;
  final Color borderColor;
  final Color textColor;
  const _HilfeSuchenContent({
    required this.cardColor,
    required this.secondaryText,
    required this.borderColor,
    required this.textColor,
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
              Text(
                'Stell einfach deinen Job ein.',
                style: TextStyle(
                  color: textColor,
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
              backgroundColor: const Color(0xFF007AFF),
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
        Text(
          'Laufende Jobs',
          style: TextStyle(
            color: textColor,
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
  final Color textColor;
  const _IchBieteAnContent({
    required this.cardColor,
    required this.secondaryText,
    required this.borderColor,
    required this.textColor,
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
              Text(
                'Teile, was du gut kannst.',
                style: TextStyle(
                  color: textColor,
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
  final Color textColor;
  final Color buttonColor;
  final Color timeTextColor;

  const _JobCard({
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
