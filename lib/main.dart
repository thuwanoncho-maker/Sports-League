import 'package:flutter/material.dart';

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
class RovTeam {
  String name;
  String tag;
  int seriesPlayed = 0;
  int seriesWon = 0;
  int seriesLost = 0;
  int gamesWon = 0;
  int gamesLost = 0;

  RovTeam({required this.name, required this.tag});

  int get points => seriesWon;
  int get gameDiff => gamesWon - gamesLost;

  void resetStats() {
    seriesPlayed = 0;
    seriesWon = 0;
    seriesLost = 0;
    gamesWon = 0;
    gamesLost = 0;
  }
}

class RovMatch {
  RovTeam teamA;
  RovTeam teamB;
  int scoreA = 0;
  int scoreB = 0;
  int boFormat; // 3 หรือ 5
  bool isCompleted = false;
  String mvpName = '';

  RovMatch({
    required this.teamA,
    required this.teamB,
    this.boFormat = 3,
  });

  void submitResult(int a, int b, String mvp) {
    if (isCompleted) {
      teamA.seriesPlayed--;
      teamA.gamesWon -= scoreA;
      teamA.gamesLost -= scoreB;
      teamB.seriesPlayed--;
      teamB.gamesWon -= scoreB;
      teamB.gamesLost -= scoreA;
      if (scoreA > scoreB) {
        teamA.seriesWon--;
        teamB.seriesLost--;
      } else if (scoreB > scoreA) {
        teamB.seriesWon--;
        teamA.seriesLost--;
      }
    }

    scoreA = a;
    scoreB = b;
    mvpName = mvp;
    isCompleted = true;

    teamA.seriesPlayed++;
    teamA.gamesWon += a;
    teamA.gamesLost += b;

    teamB.seriesPlayed++;
    teamB.gamesWon += b;
    teamB.gamesLost += a;

    if (a > b) {
      teamA.seriesWon++;
      teamB.seriesLost++;
    } else if (b > a) {
      teamB.seriesWon++;
      teamA.seriesLost++;
    }
  }
}



class CreateTournamentScreen extends StatefulWidget {
  final String tournamentName;
  final List<RovTeam> teams;
  final Function(String, List<RovTeam>, List<RovMatch>) onCreated;

  const CreateTournamentScreen({
    super.key,
    required this.tournamentName,
    required this.teams,
    required this.onCreated,
  });

  @override
  State<CreateTournamentScreen> createState() => _CreateTournamentScreenState();
}

class _CreateTournamentScreenState extends State<CreateTournamentScreen> {
  final _nameController = TextEditingController();
  final _teamNameController = TextEditingController();
  final _teamTagController = TextEditingController();

  int selectedBo = 3;
  List<RovTeam> localTeams = [];

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.tournamentName;
    localTeams = List.from(widget.teams);
  }

  void _addTeam() {
    if (_teamNameController.text.isNotEmpty && _teamTagController.text.isNotEmpty) {
      setState(() {
        localTeams.add(
          RovTeam(
            name: _teamNameController.text.trim(),
            tag: _teamTagController.text.trim().toUpperCase(),
          ),
        );
        _teamNameController.clear();
        _teamTagController.clear();
      });
    }
  }

  // อัลกอริทึมจัดตารางแข่งสลับรอบ (Circle Method Round Robin) ไม่ให้ทีมแข่งติดกัน
  List<RovMatch> _generateRoundRobinMatches(List<RovTeam> teams, int boFormat) {
    List<RovMatch> scheduledMatches = [];
    List<RovTeam?> teamList = List.from(teams);

    // ถ้าจำนวนทีมเป็นเลขคี่ ให้ใส่ทีมหลอก (BYE) เพื่อช่วยหมุนรอบ
    if (teamList.length % 2 != 0) {
      teamList.add(null);
    }

    int numTeams = teamList.length;
    int numRounds = numTeams - 1;
    int halfSize = numTeams ~/ 2;

    List<RovTeam?> tempTeams = List.from(teamList);

    for (int round = 0; round < numRounds; round++) {
      for (int i = 0; i < halfSize; i++) {
        RovTeam? teamA = tempTeams[i];
        RovTeam? teamB = tempTeams[numTeams - 1 - i];

        // ข้ามคู่ที่มีทีม BYE
        if (teamA != null && teamB != null) {
          scheduledMatches.add(
            RovMatch(
              teamA: teamA,
              teamB: teamB,
              boFormat: boFormat,
            ),
          );
        }
      }

      // หมุนลำดับทีมตามเข็มนาฬิกา (ล็อกตำแหน่งแรกไว้)
      RovTeam? last = tempTeams.removeLast();
      tempTeams.insert(1, last);
    }

    return scheduledMatches;
  }

  void _generateTournament() {
    if (localTeams.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ต้องเพิ่มทีมอย่างน้อย 2 ทีมขึ้นไป')),
      );
      return;
    }

    // เรียกใช้อัลกอริทึมจัดรอบแข่งใหม่
    List<RovMatch> matches = _generateRoundRobinMatches(localTeams, selectedBo);

    widget.onCreated(_nameController.text.trim(), localTeams, matches);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('สร้างตารางการแข่งขันเรียบร้อย! ทั้งหมด ${matches.length} แมตช์')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('⚔️ RoV League Setup')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'ชื่อการแข่งขัน (Tournament Name)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.emoji_events, color: Color(0xFFE5B842)),
              ),
            ),
            const SizedBox(height: 16),
            const Text('รูปแบบการแข่ง:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<int>(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Bo3', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                    value: 3,
                    groupValue: selectedBo,
                    onChanged: (val) => setState(() => selectedBo = val!),
                  ),
                ),
                Expanded(
                  child: RadioListTile<int>(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Bo5', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                    value: 5,
                    groupValue: selectedBo,
                    onChanged: (val) => setState(() => selectedBo = val!),
                  ),
                ),
                Expanded(
                  child: RadioListTile<int>(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Bo7', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                    value: 7,
                    groupValue: selectedBo,
                    onChanged: (val) => setState(() => selectedBo = val!),
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            const Text('ลงทะเบียนทีมเข้าร่วม:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _teamNameController,
                    decoration: const InputDecoration(labelText: 'ชื่อทีม (เช่น Bacon Time)'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: _teamTagController,
                    decoration: const InputDecoration(labelText: 'ชื่อย่อ (BAC)'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_box, size: 36, color: Color(0xFFE5B842)),
                  onPressed: _addTeam,
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: localTeams.length,
              itemBuilder: (context, index) {
                final team = localTeams[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFFE5B842),
                      foregroundColor: Colors.black,
                      child: Text(team.tag),
                    ),
                    title: Text(team.name),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () {
                        setState(() => localTeams.removeAt(index));
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE5B842),
                  foregroundColor: Colors.black,
                ),
                onPressed: _generateTournament,
                icon: const Icon(Icons.sports_esports),
                label: const Text('สร้างตารางการแข่งขัน', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class FixturesScreen extends StatelessWidget {
  final List<RovMatch> matches;
  final String tournamentName;

  const FixturesScreen({
    super.key,
    required this.matches,
    required this.tournamentName,
  });

  Widget _buildHeroStyleBadge(RovTeam team) {
    return Column(
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
            ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE5B842), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE5B842).withOpacity(0.3),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Center(
            child: Text(
              team.tag,
              style: const TextStyle(
                color: Color(0xFFE5B842),
                fontWeight: FontWeight.w900,
                fontSize: 16,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          team.name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('⚔️ SCHEDULE - $tournamentName'),
      ),
      body: matches.isEmpty
          ? const Center(
              child: Text(
                'ยังไม่มีแมตช์การแข่งขัน\nกรุณาสร้างลีกในหน้า "สร้างลีก"',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              itemCount: matches.length,
              itemBuilder: (context, index) {
                final match = matches[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF131B2A), Color(0xFF0A0E18)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: match.isCompleted
                          ? const Color(0xFFE5B842)
                          : const Color(0xFF233148),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: match.isCompleted
                            ? const Color(0xFFE5B842).withOpacity(0.2)
                            : Colors.black54,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Match Header Badge
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1B263B),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: const Color(0xFFC5A059)),
                              ),
                              child: Text(
                                'MATCH ${index + 1} • Bo${match.boFormat}',
                                style: const TextStyle(
                                  color: Color(0xFFE5B842),
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: match.isCompleted
                                    ? Colors.green.withOpacity(0.2)
                                    : Colors.amber.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: match.isCompleted ? Colors.greenAccent : Colors.amber,
                                  width: 0.8,
                                ),
                              ),
                              child: Text(
                                match.isCompleted ? '• FINISHED' : '• UPCOMING',
                                style: TextStyle(
                                  color: match.isCompleted ? Colors.greenAccent : Colors.amber,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Team A vs Team B
                        Row(
                          children: [
                            Expanded(child: _buildHeroStyleBadge(match.teamA)),
                            
                            // VS Shield Emblem
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF3B2E10), Color(0xFF1F1808)],
                                ),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: const Color(0xFFE5B842), width: 1.5),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFE5B842).withOpacity(0.35),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: Text(
                                match.isCompleted
                                    ? '${match.scoreA} - ${match.scoreB}'
                                    : 'VS',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFFE5B842),
                                  letterSpacing: 2,
                                ),
                              ),
                            ),

                            Expanded(child: _buildHeroStyleBadge(match.teamB)),
                          ],
                        ),

                        // MVP Section
                        if (match.isCompleted && match.mvpName.isNotEmpty) ...[
                          const SizedBox(height: 14),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF261D0C),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: const Color(0xFFE5B842).withOpacity(0.7)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.star, color: Color(0xFFE5B842), size: 15),
                                const SizedBox(width: 6),
                                Text(
                                  'MATCH MVP: ${match.mvpName}',
                                  style: const TextStyle(
                                    color: Color(0xFFE5B842),
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}


class ScoreInputScreen extends StatefulWidget {
  final List<RovMatch> matches;
  final VoidCallback onScoreSubmitted;

  const ScoreInputScreen({
    super.key,
    required this.matches,
    required this.onScoreSubmitted,
  });

  @override
  State<ScoreInputScreen> createState() => _ScoreInputScreenState();
}

class _ScoreInputScreenState extends State<ScoreInputScreen> {
  RovMatch? selectedMatch;
  int scoreA = 0;
  int scoreB = 0;
  final _mvpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // คำนวณคะแนนสูงสุดที่ชนะได้ตามรูปแบบการแข่ง (Bo3 -> ชนะ 2, Bo5 -> ชนะ 3, Bo7 -> ชนะ 4)
    int maxWins = selectedMatch != null ? ((selectedMatch!.boFormat + 1) ~/ 2) : 2;

    return Scaffold(
      appBar: AppBar(title: const Text('📝 บันทึกผลการแข่งขัน')),
      body: widget.matches.isEmpty
          ? const Center(child: Text('ยังไม่มีรายการแข่งขัน'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('เลือกแมตช์ที่ต้องการกรอกผล:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<RovMatch>(
                    value: selectedMatch,
                    isExpanded: true,
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                    hint: const Text('-- เลือกแมตช์ --'),
                    items: widget.matches.map((match) {
                      return DropdownMenuItem(
                        value: match,
                        child: Text('${match.teamA.tag} vs ${match.teamB.tag} (Bo${match.boFormat})'),
                      );
                    }).toList(),
                    onChanged: (match) {
                      setState(() {
                        selectedMatch = match;
                        scoreA = match?.scoreA ?? 0;
                        scoreB = match?.scoreB ?? 0;
                        _mvpController.text = match?.mvpName ?? '';
                      });
                    },
                  ),
                  if (selectedMatch != null) ...[
                    const SizedBox(height: 24),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              '${selectedMatch!.teamA.name} VS ${selectedMatch!.teamB.name}',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFFD700)),
                            ),
                            Text(
                              'รูปแบบการแข่ง: Best of ${selectedMatch!.boFormat} (ชนะ $maxWins ใน ${selectedMatch!.boFormat} เกม)',
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            const Divider(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(selectedMatch!.teamA.tag, style: const TextStyle(fontWeight: FontWeight.bold)),
                                    DropdownButton<int>(
                                      value: scoreA,
                                      items: List.generate(
                                        maxWins + 1, // สกอร์เป็นไปได้ตั้งแต่ 0 ถึง maxWins
                                        (index) => DropdownMenuItem(value: index, child: Text('$index')),
                                      ),
                                      onChanged: (val) => setState(() => scoreA = val!),
                                    ),
                                  ],
                                ),
                                const Text(':', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                                Column(
                                  children: [
                                    Text(selectedMatch!.teamB.tag, style: const TextStyle(fontWeight: FontWeight.bold)),
                                    DropdownButton<int>(
                                      value: scoreB,
                                      items: List.generate(
                                        maxWins + 1,
                                        (index) => DropdownMenuItem(value: index, child: Text('$index')),
                                      ),
                                      onChanged: (val) => setState(() => scoreB = val!),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: _mvpController,
                              decoration: const InputDecoration(
                                labelText: 'ผู้เล่นยอดเยี่ยม (Match MVP)',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.star, color: Colors.amber),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFD700),
                                foregroundColor: Colors.black,
                              ),
                              onPressed: () {
                                selectedMatch!.submitResult(scoreA, scoreB, _mvpController.text.trim());
                                widget.onScoreSubmitted();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('บันทึกและประมวลผลคะแนนเรียบร้อย!')),
                                );
                              },
                              icon: const Icon(Icons.save),
                              label: const Text('บันทึกผลการแข่ง'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}


class StandingsScreen extends StatelessWidget {
  final List<RovTeam> teams;
  final String tournamentName;

  const StandingsScreen({
    super.key,
    required this.teams,
    required this.tournamentName,
  });

  @override
  Widget build(BuildContext context) {
    List<RovTeam> sortedTeams = List.from(teams);
    sortedTeams.sort((a, b) {
      if (b.points != a.points) return b.points.compareTo(a.points);
      if (b.gameDiff != a.gameDiff) return b.gameDiff.compareTo(a.gameDiff);
      return b.gamesWon.compareTo(a.gamesWon);
    });

    return Scaffold(
      appBar: AppBar(title: Text('🏆 LEADERBOARD - $tournamentName')),
      body: teams.isEmpty
          ? const Center(
              child: Text(
                'ยังไม่มีข้อมูลทีมในตารางคะแนน',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF141923),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFFFD700).withOpacity(0.5)),
                      boxShadow: const [
                        BoxShadow(color: Colors.black54, blurRadius: 10, offset: Offset(0, 4)),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: DataTable(
                        columnSpacing: 10,
                        headingRowColor: WidgetStateProperty.all(const Color(0xFF1F283A)),
                        columns: const [
                          DataColumn(label: Text('#', style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('TEAM', style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('P', style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('W', style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('L', style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('GD', style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('PTS', style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.w900))),
                        ],
                        rows: List.generate(sortedTeams.length, (index) {
                          final team = sortedTeams[index];
                          final bool isChampion = index == 0;
                          final bool isPlayoff = index < 2;

                          return DataRow(
                            color: WidgetStateProperty.all(
                              isChampion
                                  ? const Color(0xFF382A0B)
                                  : isPlayoff
                                      ? const Color(0xFF222B18)
                                      : Colors.transparent,
                            ),
                            cells: [
                              DataCell(
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (isChampion)
                                      const Text('👑 ', style: TextStyle(fontSize: 14))
                                    else
                                      Text('${index + 1}', style: TextStyle(fontWeight: isPlayoff ? FontWeight.bold : FontWeight.normal)),
                                  ],
                                ),
                              ),
                              DataCell(
                                Text(
                                  team.tag,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isChampion ? const Color(0xFFFFD700) : Colors.white,
                                  ),
                                ),
                              ),
                              DataCell(Text('${team.seriesPlayed}')),
                              DataCell(Text('${team.seriesWon}', style: const TextStyle(color: Colors.greenAccent))),
                              DataCell(Text('${team.seriesLost}', style: const TextStyle(color: Colors.redAccent))),
                              DataCell(Text('${team.gameDiff > 0 ? "+${team.gameDiff}" : team.gameDiff}')),
                              DataCell(
                                Text(
                                  '${team.points}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16,
                                    color: Color(0xFFFFD700),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10141D),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(width: 12, height: 12, decoration: BoxDecoration(color: const Color(0xFF382A0B), borderRadius: BorderRadius.circular(2), border: Border.all(color: const Color(0xFFFFD700)))),
                            const SizedBox(width: 8),
                            const Text('แถบสีทอง = อันดับ 1 (LEAGUE CHAMPION)', style: TextStyle(fontSize: 11, color: Color(0xFFFFD700))),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Container(width: 12, height: 12, decoration: BoxDecoration(color: const Color(0xFF222B18), borderRadius: BorderRadius.circular(2), border: Border.all(color: Colors.greenAccent))),
                            const SizedBox(width: 8),
                            const Text('แถบสีเขียว = ผ่านเข้ารอบ Play-off (Top 2)', style: TextStyle(fontSize: 11, color: Colors.greenAccent)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}


class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const goldColor = Color(0xFFE5B842);
    const cardBackground = Color(0xFF101622);

    return Scaffold(
      appBar: AppBar(title: const Text('👥 ABOUT DEVELOPER')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // โลโก้แอป
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: goldColor, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: goldColor.withOpacity(0.35),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: const CircleAvatar(
                radius: 45,
                backgroundColor: Color(0xFF1E293B),
                child: Icon(Icons.sports_esports, size: 50, color: goldColor),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'RoV eSports League Hub',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: goldColor),
            ),
            const Text('แอปพลิเคชันจัดการตารางแข่งขันและคำนวณคะแนน RoV', style: TextStyle(color: Colors.grey)),
            const Divider(height: 32, color: Colors.white24),
            
            // การ์ดผู้จัดทำ
            Card(
              color: cardBackground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Color(0xFFC5A059), width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ผู้จัดทำโปรเจกต์:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: goldColor),
                    ),
                    const SizedBox(height: 16),
                    
                    // ผู้จัดทำ
                    _buildMemberTile(
                      name: 'นาย ธุวานนท์ โจมแก้ว',
                      stdId: 'รหัสนักศึกษา: 016830641029-6', // 📌 เปลี่ยนเป็นรหัสนักศึกษาจริง
                      role: 'ตำแหน่งในเกม: Abyssal Dragon Lane / Dark Slayer Lane',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: cardBackground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.white12),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('แรงบันดาลใจในการพัฒนา:', style: TextStyle(fontWeight: FontWeight.bold, color: goldColor)),
                    SizedBox(height: 8),
                    Text(
                      'เนื่องจากในการจัดแข่งกีฬา eSports หรือเกม RoV ในระดับสถาบัน มักประสบปัญหาการคิดคะแนนและผลต่างเกม (Game Difference) ที่ซับซ้อน ผู้จัดทำจึงพัฒนาแอปนี้ขึ้นเพื่อช่วยสรุปตารางแข่งและคำนวณอันดับคะแนนโดยอัตโนมัติ',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberTile({
    required String name,
    required String stdId,
    required String role,
  }) {
    const goldColor = Color(0xFFE5B842);

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: goldColor, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: goldColor.withOpacity(0.35),
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipOval(
          child: Image.asset(
            'assets/profile.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const CircleAvatar(
              backgroundColor: Color(0xFF1E293B),
              child: Icon(Icons.person, size: 35, color: goldColor),
            ),
          ),
        ),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      subtitle: Text('$stdId\n$role', style: const TextStyle(color: Colors.grey, fontSize: 12)),
    );
  }
}