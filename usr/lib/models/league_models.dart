import 'package:flutter/material.dart';

class Player {
  final String id;
  final String name;
  int wins;
  int losses;
  int oneEighties;

  Player({
    required this.id,
    required this.name,
    this.wins = 0,
    this.losses = 0,
    this.oneEighties = 0,
  });
}

class Team {
  final String id;
  final String name;
  final List<Player> players;
  int played;
  int won;
  int drawn;
  int lost;
  int points;

  Team({
    required this.id,
    required this.name,
    required this.players,
    this.played = 0,
    this.won = 0,
    this.drawn = 0,
    this.lost = 0,
    this.points = 0,
  });
}

class LeagueMatch {
  final String id;
  final String homeTeamId;
  final String awayTeamId;
  final DateTime date;
  int? homeScore;
  int? awayScore;
  bool isCompleted;

  LeagueMatch({
    required this.id,
    required this.homeTeamId,
    required this.awayTeamId,
    required this.date,
    this.homeScore,
    this.awayScore,
    this.isCompleted = false,
  });
}

class LeagueData extends ChangeNotifier {
  List<Team> teams = [];
  List<LeagueMatch> matches = [];

  LeagueData() {
    _generateMockData();
  }

  void _generateMockData() {
    // Create Players
    var p1 = Player(id: 'p1', name: 'Phil Taylor');
    var p2 = Player(id: 'p2', name: 'Michael van Gerwen');
    var p3 = Player(id: 'p3', name: 'Peter Wright');
    var p4 = Player(id: 'p4', name: 'Gerwyn Price');
    var p5 = Player(id: 'p5', name: 'Fallon Sherrock');
    var p6 = Player(id: 'p6', name: 'Raymond van Barneveld');

    // Create Teams
    var t1 = Team(id: 't1', name: 'The Power House', players: [p1, p6]);
    var t2 = Team(id: 't2', name: 'Green Machine', players: [p2, p4]);
    var t3 = Team(id: 't3', name: 'Snakebite Club', players: [p3, p5]);

    // Update stats manually for mock
    t1.played = 5; t1.won = 4; t1.points = 12;
    t2.played = 5; t2.won = 3; t2.points = 9;
    t3.played = 5; t3.won = 1; t3.points = 3;

    teams = [t1, t2, t3];

    // Create Matches
    matches = [
      LeagueMatch(
        id: 'm1',
        homeTeamId: 't1',
        awayTeamId: 't2',
        date: DateTime.now().subtract(const Duration(days: 2)),
        homeScore: 7,
        awayScore: 4,
        isCompleted: true,
      ),
      LeagueMatch(
        id: 'm2',
        homeTeamId: 't2',
        awayTeamId: 't3',
        date: DateTime.now().add(const Duration(days: 1)),
      ),
      LeagueMatch(
        id: 'm3',
        homeTeamId: 't3',
        awayTeamId: 't1',
        date: DateTime.now().add(const Duration(days: 5)),
      ),
    ];
  }

  Team? getTeam(String id) {
    try {
      return teams.firstWhere((t) => t.id == id);
    } catch (e) {
      return null;
    }
  }
}
