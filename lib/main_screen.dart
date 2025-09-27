import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'athlete_data.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final athleteData = Provider.of<AthleteData>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${athleteData.fullName}!', style: GoogleFonts.poppins()),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () => context.go('/profile'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              'Choose a Test',
              style: theme.textTheme.headlineSmall?.copyWith(fontFamily: 'Poppins'),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: Icon(Icons.straighten, color: theme.colorScheme.secondary),
                title: Text('Sit & Reach Test', style: GoogleFonts.poppins()),
                onTap: () => context.go('/test/Sit & Reach Test'),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: Icon(Icons.fitness_center, color: theme.colorScheme.secondary),
                title: Text('Sit-ups Test', style: GoogleFonts.poppins()),
                onTap: () => context.go('/test/Sit-ups Test'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}