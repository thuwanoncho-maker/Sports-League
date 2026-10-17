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
    return MaterialApp(
      title: 'RoV eSports Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFFFFD700),
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardColor: const Color(0xFF1E1E2C),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A1A2E),
          foregroundColor: Color(0xFFFFD700),
          centerTitle: true,
          elevation: 4,
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF1A1A2E),
        selectedItemColor: const Color(0xFFFFD700),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: 'สร้างลีก'),
          BottomNavigationBarItem(icon: Icon(Icons.sports_esports), label: 'ตารางแข่ง'),
          BottomNavigationBarItem(icon: Icon(Icons.edit_note), label: 'กรอกผล'),
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard), label: 'ตารางคะแนน'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'ผู้จัดทำ'),
        ],
      ),
    );
  }
}