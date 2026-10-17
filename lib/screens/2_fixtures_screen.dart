import 'package:flutter/material.dart';
import '../models/rov_data.dart';

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