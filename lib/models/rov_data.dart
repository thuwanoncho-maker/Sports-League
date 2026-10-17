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