import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TestScreen extends StatelessWidget {
  final String testName;
  const TestScreen({super.key, required this.testName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(testName, style: GoogleFonts.poppins()),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Instructions', style: theme.textTheme.headlineSmall?.copyWith(fontFamily: 'Poppins')),
            const SizedBox(height: 8),
            const Text(
              'Record your video in a well-lit environment. Keep your camera stable and follow the steps shown in the instruction video below.',
            ),
            const SizedBox(height: 24),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: Colors.black12,
                child: const Center(
                  child: Icon(Icons.play_circle_outline, size: 64, color: Colors.black54),
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                print('Upload button pressed');
              },
              child: const Text('Record or Upload Video'),
            ),
            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}