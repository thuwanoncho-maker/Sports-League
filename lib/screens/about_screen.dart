import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('👥 ผู้จัดทำโปรเจกต์')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFFFFD700),
              child: Icon(Icons.sports_esports, size: 60, color: Colors.black),
            ),
            const SizedBox(height: 16),
            const Text(
              'RoV eSports League Hub',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFFFD700)),
            ),
            const Text('แอปพลิเคชันจัดการตารางแข่งขันและคำนวณคะแนน RoV', style: TextStyle(color: Colors.grey)),
            const Divider(height: 32),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('รายชื่อสมาชิกในกลุ่ม:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 12),
                    ListTile(
                      leading: Icon(Icons.person, color: Color(0xFFFFD700)),
                      title: Text('นาย ธวานนท์ โชว์'),
                      subtitle: Text('รหัสนักศึกษา: XXXXXXXXXX\nตำแหน่งในเกม: Jungle / Dark Slayer Lane'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('แรงบันดาลใจในการพัฒนา:', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text(
                      'เนื่องจากในการจัดแข่งกีฬา eSports หรือเกม RoV ในระดับสถาบัน มักประสบปัญหาการคิดคะแนนและผลต่างเกม (Game Difference) ที่ซับซ้อน คณะผู้จัดทำจึงพัฒนาแอปนี้ขึ้นเพื่อช่วยสรุปตารางแข่งและคำนวณอันดับคะแนนโดยอัตโนมัติ',
                      style: TextStyle(color: Colors.grey),
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
}