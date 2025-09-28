import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'athlete_data.dart';
import 'test_result.dart';

class TestResultsScreen extends StatelessWidget {
  const TestResultsScreen({super.key});

  List<TestResult> _getMockTestResults(String athleteName) {
    return [
      TestResult(
        testType: 'Vertical Jump',
        athleteName: athleteName,
        email: 'bogusbirla@gmail.com',
        jumpHeight: 49.4,
        numberOfReps: null,
        formScore: 8.4,
        confidence: 93,
        submittedAt: DateTime(2025, 9, 28, 12, 57, 20),
      ),
      TestResult(
        testType: 'Vertical Jump',
        athleteName: athleteName,
        email: 'bogusbirla@gmail.com',
        jumpHeight: 44.4,
        numberOfReps: null,
        formScore: 9.4,
        confidence: 97,
        submittedAt: DateTime(2025, 9, 28, 12, 57, 20),
      ),
      TestResult(
        testType: 'Vertical Jump',
        athleteName: athleteName,
        email: 'bogusbirla@gmail.com',
        jumpHeight: 42.8,
        numberOfReps: null,
        formScore: 9.1,
        confidence: 89,
        submittedAt: DateTime(2025, 9, 28, 11, 30, 15),
      ),
      TestResult(
        testType: 'Sit-ups',
        athleteName: athleteName,
        email: 'bogusbirla@gmail.com',
        jumpHeight: null,
        numberOfReps: 30,
        formScore: 7.8,
        confidence: 89,
        submittedAt: DateTime(2025, 9, 27, 15, 22, 45),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final athleteData = Provider.of<AthleteData>(context);
    final testResults = _getMockTestResults(athleteData.fullName);

    return Scaffold(
      appBar: AppBar(
        title: Text('Test Results', style: GoogleFonts.poppins()),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
      body: testResults.isEmpty
          ? const Center(
              child: Text('No test results available'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: testResults.length,
              itemBuilder: (context, index) {
                final result = testResults[index];
                return _TestResultCard(result: result);
              },
            ),
    );
  }
}

class _TestResultCard extends StatelessWidget {
  final TestResult result;

  const _TestResultCard({required this.result});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.grey.shade50,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with test type and confidence
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.testIcon,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            result.testType,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            result.athleteName,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Submitted: ${result.formattedSubmissionTime}',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Confidence: ${result.confidence}%',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Performance metrics
                Row(
                  children: [
                    if (result.jumpHeight != null) ...[
                      Expanded(
                        child: _MetricCard(
                          value: '${result.jumpHeight!}cm',
                          label: 'Jump Height',
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    if (result.numberOfReps != null) ...[
                      Expanded(
                        child: _MetricCard(
                          value: '${result.numberOfReps!}',
                          label: 'Reps in 1 min',
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: _MetricCard(
                        value: '${result.formScore}/10',
                        label: 'Form Score',
                        color: theme.colorScheme.tertiary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _MetricCard({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}