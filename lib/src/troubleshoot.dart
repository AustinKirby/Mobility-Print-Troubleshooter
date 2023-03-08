/// Troubleshoot State
enum TroubleshootState { success, fail, error, loading, none }

/// Result returned from troubleshoot
class TroubleshootResult {
  final TroubleshootState state;
  final String? message;

  TroubleshootResult({this.state = TroubleshootState.none, this.message});
}

/// Troubleshoot class
abstract class Troubleshoot {
  Future<TroubleshootResult> troubleshoot();
}
