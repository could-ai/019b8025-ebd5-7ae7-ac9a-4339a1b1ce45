import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/league_models.dart';

class StandingsScreen extends StatelessWidget {
  const StandingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var leagueData = Provider.of<LeagueData>(context);
    // Sort teams by points descending
    var sortedTeams = List<Team>.from(leagueData.teams);
    sortedTeams.sort((a, b) => b.points.compareTo(a.points));

    return Scaffold(
      appBar: AppBar(
        title: const Text('League Standings'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Pos')),
            DataColumn(label: Text('Team')),
            DataColumn(label: Text('P')),
            DataColumn(label: Text('W')),
            DataColumn(label: Text('D')),
            DataColumn(label: Text('L')),
            DataColumn(label: Text('Pts')),
          ],
          rows: List<DataRow>.generate(sortedTeams.length, (index) {
            final team = sortedTeams[index];
            return DataRow(cells: [
              DataCell(Text('${index + 1}')),
              DataCell(Text(team.name, style: const TextStyle(fontWeight: FontWeight.bold))),
              DataCell(Text('${team.played}')),
              DataCell(Text('${team.won}')),
              DataCell(Text('${team.drawn}')),
              DataCell(Text('${team.lost}')),
              DataCell(Text('${team.points}', style: const TextStyle(fontWeight: FontWeight.bold))),
            ]);
          }),
        ),
      ),
    );
  }
}
