import 'package:flutter/material.dart';
import '../models/rov_data.dart';

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
                                        (selectedMatch!.boFormat == 3 ? 3 : 4),
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
                                        (selectedMatch!.boFormat == 3 ? 3 : 4),
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