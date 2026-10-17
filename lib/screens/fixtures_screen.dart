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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('🎮 ตารางแข่ง - $tournamentName')),
      body: matches.isEmpty
          ? const Center(child: Text('ยังไม่มีแมตช์การแข่งขัน กรุณาสร้างลีกก่อน'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: matches.length,
              itemBuilder: (context, index) {
                final match = matches[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'แมตช์ที่ ${index + 1} (Bo${match.boFormat})',
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Text(
                                '${match.teamA.name}\n[${match.teamA.tag}]',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: match.isCompleted ? Colors.amber.withOpacity(0.2) : Colors.black26,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: const Color(0xFFFFD700)),
                              ),
                              child: Text(
                                match.isCompleted
                                    ? '${match.scoreA} - ${match.scoreB}'
                                    : 'VS',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFFD700),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${match.teamB.name}\n[${match.teamB.tag}]',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        if (match.isCompleted && match.mvpName.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Chip(
                            avatar: const Icon(Icons.star, color: Colors.amber, size: 18),
                            label: Text('MVP: ${match.mvpName}', style: const TextStyle(fontSize: 12)),
                            backgroundColor: Colors.black45,
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