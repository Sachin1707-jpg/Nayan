/// Recognized command types
enum CommandType {
  readText,
  describeSurroundings,
  navigate,
  news,
  music,
  callContact,
  stop,
  unknown,
}

/// Command result with type and confidence
class CommandResult {
  final CommandType type;
  final String originalText;
  final double confidence;
  final String? parameter;

  CommandResult({
    required this.type,
    required this.originalText,
    this.confidence = 1.0,
    this.parameter,
  });

  bool get isUnknown => type == CommandType.unknown;
}

/// Voice command recognition and processing
/// Matches recognized speech to app commands
class VoiceCommandProcessor {

  /// Process recognized speech text and extract command
  static CommandResult processCommand(String recognizedText) {
    final text = recognizedText.toLowerCase().trim();

    if (text.isEmpty) {
      return CommandResult(
        type: CommandType.unknown,
        originalText: recognizedText,
        confidence: 0.0,
      );
    }

    // Read text commands
    if (_matchesPattern(text, ['read', 'text'])) {
      return CommandResult(
        type: CommandType.readText,
        originalText: recognizedText,
        confidence: 0.9,
      );
    }

    // Describe surroundings commands
    if (_matchesPattern(text, ['describe', 'surroundings']) ||
        _matchesPattern(text, ['what', 'see']) ||
        _matchesPattern(text, ['look', 'around']) ||
        _matchesPattern(text, ['describe', 'scene'])) {
      return CommandResult(
        type: CommandType.describeSurroundings,
        originalText: recognizedText,
        confidence: 0.9,
      );
    }

    // Navigation commands
    if (_matchesPattern(text, ['navigate']) ||
        _matchesPattern(text, ['directions']) ||
        _matchesPattern(text, ['take', 'me']) ||
        _matchesPattern(text, ['go', 'to']) ||
        _matchesPattern(text, ['where', 'am', 'i'])) {
      return CommandResult(
        type: CommandType.navigate,
        originalText: recognizedText,
        confidence: 0.85,
      );
    }

    // News commands
    if (_matchesPattern(text, ['news']) ||
        _matchesPattern(text, ['headlines']) ||
        _matchesPattern(text, ['what', 'happening'])) {
      return CommandResult(
        type: CommandType.news,
        originalText: recognizedText,
        confidence: 0.9,
      );
    }

    // Music commands
    if (_matchesPattern(text, ['music']) ||
        _matchesPattern(text, ['play', 'song']) ||
        _matchesPattern(text, ['audio'])) {
      return CommandResult(
        type: CommandType.music,
        originalText: recognizedText,
        confidence: 0.9,
      );
    }

    // Call contact commands
    if (_matchesPattern(text, ['call']) ||
        _matchesPattern(text, ['phone']) ||
        _matchesPattern(text, ['contact'])) {
      return CommandResult(
        type: CommandType.callContact,
        originalText: recognizedText,
        confidence: 0.85,
      );
    }

    // Stop commands
    if (_matchesPattern(text, ['stop']) ||
        _matchesPattern(text, ['cancel']) ||
        _matchesPattern(text, ['quit']) ||
        _matchesPattern(text, ['exit'])) {
      return CommandResult(
        type: CommandType.stop,
        originalText: recognizedText,
        confidence: 1.0,
      );
    }

    // Unknown command
    return CommandResult(
      type: CommandType.unknown,
      originalText: recognizedText,
      confidence: 0.0,
    );
  }

  /// Check if text matches all keywords in pattern
  static bool _matchesPattern(String text, List<String> keywords) {
    return keywords.every((keyword) => text.contains(keyword));
  }

  /// Get user-friendly command name
  static String getCommandName(CommandType type) {
    switch (type) {
      case CommandType.readText:
        return 'Read Text';
      case CommandType.describeSurroundings:
        return 'Describe Surroundings';
      case CommandType.navigate:
        return 'Navigation';
      case CommandType.news:
        return 'News';
      case CommandType.music:
        return 'Music';
      case CommandType.callContact:
        return 'Call Contact';
      case CommandType.stop:
        return 'Stop';
      case CommandType.unknown:
        return 'Unknown Command';
    }
  }

  /// Get response message for a command
  static String getCommandResponse(CommandType type) {
    switch (type) {
      case CommandType.readText:
        return 'Opening text reader. Point your camera at text to read it aloud.';
      case CommandType.describeSurroundings:
        return 'Opening scene description. I will describe what I see around you.';
      case CommandType.navigate:
        return 'Opening navigation. Where would you like to go?';
      case CommandType.news:
        return 'Opening news. Here are the latest headlines.';
      case CommandType.music:
        return 'Opening music player. What would you like to listen to?';
      case CommandType.callContact:
        return 'Opening trusted contacts. Who would you like to call?';
      case CommandType.stop:
        return 'Stopping voice interaction.';
      case CommandType.unknown:
        return 'I did not understand that command. Please try again.';
    }
  }

  /// Get list of available commands for help
  static List<String> getAvailableCommands() {
    return [
      'Read text',
      'Describe surroundings',
      'Navigate',
      'News',
      'Music',
      'Call a trusted contact',
      'Stop',
    ];
  }

  /// Get help message listing all commands
  static String getHelpMessage() {
    final commands = getAvailableCommands();
    final commandList = commands.map((cmd) => '• $cmd').join('\n');
    return 'Available commands:\n$commandList';
  }
}
