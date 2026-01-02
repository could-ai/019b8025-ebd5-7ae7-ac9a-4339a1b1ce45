import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/league_models.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var leagueData = Provider.of<LeagueData>(context);
    var matches = leagueData.matches;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fixtures & Results'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: matches.length,
        itemBuilder: (context, index) {
          final match = matches[index];
          final homeTeam = leagueData.getTeam(match.homeTeamId);
          final awayTeam = leagueData.getTeam(match.awayTeamId);
          final dateFormat = DateFormat('EEE, MMM d, yyyy');

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    dateFormat.format(match.date),
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          homeTeam?.name ?? 'Unknown',
                          textAlign: TextAlign.right,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: match.isCompleted ? Colors.blueGrey[100] : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: match.isCompleted ? null : Border.all(color: Colors.grey.shade300),
                          ),
                          child: Text(
                            match.isCompleted
                                ? '${match.homeScore} - ${match.awayScore}'
                                : 'VS',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: match.isCompleted ? Colors.black : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          awayTeam?.name ?? 'Unknown',
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
