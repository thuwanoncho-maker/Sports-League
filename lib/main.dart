import 'package:flutter/material.dart';
import 'models/rov_data.dart';
import 'screens/1_create_tournament_screen.dart';
import 'screens/2_fixtures_screen.dart';
import 'screens/3_score_input_screen.dart';
import 'screens/4_standings_screen.dart';
import 'screens/5_about_screen.dart';

void main() {
  runApp(const RovLeagueApp());
}

class RovLeagueApp extends StatelessWidget {
  const RovLeagueApp({super.key});

  @override
  Widget build(BuildContext context) {
    // โทนสีหลักจาก rov.in.th/hero
    const goldColor = Color(0xFFE5B842); // ทอง metallic RoV
    const metallicBorder = Color(0xFFC5A059); // ขอบทองโลหะ
    const darkBackground = Color(0xFF080B10); // ดำอมน้ำเงินเข้ม
    const cardBackground = Color(0xFF101622); // การ์ดฮีโร่น้ำเงินเข้ม
    const navBackground = Color(0xFF0A0D14); // แถบเมนูด้านล่าง

    return MaterialApp(
      title: 'RoV eSports Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBackground,
        primaryColor: goldColor,
        cardColor: cardBackground,
        
        // AppBar สไตล์แบนเนอร์ RoV
        appBarTheme: const AppBarTheme(
          backgroundColor: navBackground,
          foregroundColor: goldColor,
          centerTitle: true,
          elevation: 10,
          shadowColor: Color(0xAAFFD700),
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: goldColor,
            letterSpacing: 2.0,
          ),
        ),

        // ปุ่มกดสไตล์ RoV Metallic Button
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: goldColor,
            foregroundColor: Colors.black,
            textStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, letterSpacing: 1),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: const BorderSide(color: Color(0xFFFFF0AA), width: 1.5),
            ),
            elevation: 8,
            shadowColor: goldColor.withOpacity(0.6),
          ),
        ),

        // Input Field สไตล์กรอบช่อง RoV
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF141C2B),
          labelStyle: const TextStyle(color: Colors.white70),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: goldColor, width: 2),
            borderRadius: BorderRadius.circular(6),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: metallicBorder, width: 1),
            borderRadius: BorderRadius.circular(6),
          ),
        ),

        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: navBackground,
          selectedItemColor: goldColor,
          unselectedItemColor: Colors.white38,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  String tournamentName = 'RoV Pro Campus League';
  List<RovTeam> teams = [];
  List<RovMatch> matches = [];

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      CreateTournamentScreen(
        tournamentName: tournamentName,
        teams: teams,
        onCreated: (newName, newTeams, newMatches) {
          setState(() {
            tournamentName = newName;
            teams = newTeams;
            matches = newMatches;
          });
        },
      ),
      FixturesScreen(matches: matches, tournamentName: tournamentName),
      ScoreInputScreen(
        matches: matches,
        onScoreSubmitted: () {
          setState(() {});
        },
      ),
      StandingsScreen(teams: teams, tournamentName: tournamentName),
      const AboutScreen(),
    ];

    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFFC5A059), width: 1.5)),
          boxShadow: [
            BoxShadow(color: Color(0x33E5B842), blurRadius: 10, offset: Offset(0, -2)),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              activeIcon: Icon(Icons.add_circle, color: Color(0xFFE5B842)),
              label: 'สร้างลีก',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_esports_outlined),
              activeIcon: Icon(Icons.sports_esports, color: Color(0xFFE5B842)),
              label: 'ตารางแข่ง',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit_note_outlined),
              activeIcon: Icon(Icons.edit_note, color: Color(0xFFE5B842)),
              label: 'กรอกผล',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events_outlined),
              activeIcon: Icon(Icons.emoji_events, color: Color(0xFFE5B842)),
              label: 'ตารางคะแนน',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.badge_outlined),
              activeIcon: Icon(Icons.badge, color: Color(0xFFE5B842)),
              label: 'ผู้จัดทำ',
            ),
          ],
        ),
      ),
    );
  }
}