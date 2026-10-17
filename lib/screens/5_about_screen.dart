import 'package:flutter/material.dart';

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