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