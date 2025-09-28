class TestResult {
  final String testType;
  final String athleteName;
  final String email;
  final double? jumpHeight; // in cm
  final int? numberOfReps; // for sit-ups test
  final double formScore; // out of 10
  final int confidence; // percentage
  final DateTime submittedAt;

  TestResult({
    required this.testType,
    required this.athleteName,
    required this.email,
    this.jumpHeight,
    this.numberOfReps,
    required this.formScore,
    required this.confidence,
    required this.submittedAt,
  });

  String get formattedSubmissionTime {
    return "${submittedAt.month}/${submittedAt.day}/${submittedAt.year}, ${_formatTime(submittedAt)}";
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final hour12 = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return "$hour12:$minute $period";
  }

  String get testIcon {
    switch (testType.toLowerCase()) {
      case 'vertical jump':
        return '🏃';
      case 'sit-ups':
        return '💪';
      case 'sit & reach test':
        return '🤸';
      default:
        return '🏅';
    }
  }
}