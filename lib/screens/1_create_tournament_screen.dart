import 'package:flutter/material.dart';
import '../models/rov_data.dart';

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