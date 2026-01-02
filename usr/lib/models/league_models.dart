import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Season {
  final String id;
  String name;
  DateTime startDate;
  DateTime? endDate;
  bool isActive;

  Season({
    required this.id,
    required this.name,
    required this.startDate,
    this.endDate,
    this.isActive = true,
  });
}

class League {
  final String id;
  String name;
  String seasonId;

  League({
    required this.id,
    required this.name,
    required this.seasonId,
  });
}

class Venue {
  final String id;
  String name;
  String address;

  Venue({
    required this.id,
    required this.name,
    required this.address,
  });
}

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
  String? venueId; // Optional home venue
  int played;
  int won;
  int drawn;
  int lost;
  int points;

  Team({
    required this.id,
    required this.name,
    required this.players,
    this.venueId,
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
  List<Season> seasons = [];
  List<League> leagues = [];
  List<Venue> venues = [];
  List<Team> teams = [];
  List<Player> players = []; // Global list of players
  List<LeagueMatch> matches = [];

  LeagueData() {
    _generateMockData();
  }

  void _generateMockData() {
    // Mock Seasons
    var s1 = Season(id: 's1', name: 'Winter 2023', startDate: DateTime(2023, 9, 1));
    seasons.add(s1);

    // Mock Leagues
    var l1 = League(id: 'l1', name: 'Premier Division', seasonId: 's1');
    leagues.add(l1);

    // Mock Venues
    var v1 = Venue(id: 'v1', name: 'The Red Lion', address: '123 High St');
    var v2 = Venue(id: 'v2', name: 'The Kings Head', address: '45 Queen Rd');
    venues.addAll([v1, v2]);

    // Create Players
    var p1 = Player(id: 'p1', name: 'Phil Taylor');
    var p2 = Player(id: 'p2', name: 'Michael van Gerwen');
    var p3 = Player(id: 'p3', name: 'Peter Wright');
    var p4 = Player(id: 'p4', name: 'Gerwyn Price');
    var p5 = Player(id: 'p5', name: 'Fallon Sherrock');
    var p6 = Player(id: 'p6', name: 'Raymond van Barneveld');
    
    players.addAll([p1, p2, p3, p4, p5, p6]);

    // Create Teams
    var t1 = Team(id: 't1', name: 'The Power House', players: [p1, p6], venueId: 'v1');
    var t2 = Team(id: 't2', name: 'Green Machine', players: [p2, p4], venueId: 'v2');
    var t3 = Team(id: 't3', name: 'Snakebite Club', players: [p3, p5], venueId: 'v1');

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

  // Admin Methods
  void addSeason(String name, DateTime startDate) {
    seasons.add(Season(id: uuid.v4(), name: name, startDate: startDate));
    notifyListeners();
  }

  void addLeague(String name, String seasonId) {
    leagues.add(League(id: uuid.v4(), name: name, seasonId: seasonId));
    notifyListeners();
  }

  void addVenue(String name, String address) {
    venues.add(Venue(id: uuid.v4(), name: name, address: address));
    notifyListeners();
  }

  void addPlayer(String name) {
    players.add(Player(id: uuid.v4(), name: name));
    notifyListeners();
  }

  void addTeam(String name, String? venueId, List<Player> selectedPlayers) {
    teams.add(Team(id: uuid.v4(), name: name, players: selectedPlayers, venueId: venueId));
    notifyListeners();
  }
}
