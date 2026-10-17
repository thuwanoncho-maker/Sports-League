import 'package:flutter/material.dart';
import '../models/rov_data.dart';

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
      appBar: AppBar(title: Text('🏆 ตารางคะแนน - $tournamentName')),
      body: teams.isEmpty
          ? const Center(child: Text('ยังไม่มีข้อมูลทีมในตาราง'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  DataTable(
                    columnSpacing: 12,
                    headingRowBackgroundColor: WidgetStateProperty.all(const Color(0xFF1A1A2E)),
                    columns: const [
                      DataColumn(label: Text('#', style: TextStyle(color: Color(0xFFFFD700)))),
                      DataColumn(label: Text('ทีม', style: TextStyle(color: Color(0xFFFFD700)))),
                      DataColumn(label: Text('แข่ง', style: TextStyle(color: Color(0xFFFFD700)))),
                      DataColumn(label: Text('ชนะ', style: TextStyle(color: Color(0xFFFFD700)))),
                      DataColumn(label: Text('แพ้', style: TextStyle(color: Color(0xFFFFD700)))),
                      DataColumn(label: Text('GD', style: TextStyle(color: Color(0xFFFFD700)))),
                      DataColumn(label: Text('Pts', style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold))),
                    ],
                    rows: List.generate(sortedTeams.length, (index) {
                      final team = sortedTeams[index];
                      final bool isTop2 = index < 2;
                      return DataRow(
                        color: WidgetStateProperty.all(
                          isTop2 ? Colors.amber.withOpacity(0.15) : Colors.transparent,
                        ),
                        cells: [
                          DataCell(Text('${index + 1}', style: TextStyle(fontWeight: isTop2 ? FontWeight.bold : FontWeight.normal))),
                          DataCell(Text(team.tag, style: const TextStyle(fontWeight: FontWeight.bold))),
                          DataCell(Text('${team.seriesPlayed}')),
                          DataCell(Text('${team.seriesWon}')),
                          DataCell(Text('${team.seriesLost}')),
                          DataCell(Text('${team.gameDiff > 0 ? "+${team.gameDiff}" : team.gameDiff}')),
                          DataCell(Text(
                            '${team.points}',
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFFD700)),
                          )),
                        ],
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(width: 12, height: 12, color: Colors.amber.withOpacity(0.5)),
                      const SizedBox(width: 8),
                      const Text('แถบสีทอง = ทีมที่ผ่านเข้ารอบ Play-off (Top 2)', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}