import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/league_models.dart';

class TeamsScreen extends StatelessWidget {
  const TeamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var leagueData = Provider.of<LeagueData>(context);
    var teams = leagueData.teams;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teams'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: teams.length,
        itemBuilder: (context, index) {
          final team = teams[index];
          return ExpansionTile(
            leading: CircleAvatar(
              child: Text(team.name.substring(0, 1)),
            ),
            title: Text(team.name),
            subtitle: Text('${team.players.length} Players'),
            children: team.players.map((player) {
              return ListTile(
                leading: const Icon(Icons.person),
                title: Text(player.name),
                trailing: Text('180s: ${player.oneEighties}'),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
