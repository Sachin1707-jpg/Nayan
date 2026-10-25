/// Application strings for accessibility and screen readers.
/// 
/// These strings are optimized for text-to-speech output and
/// provide clear, descriptive labels for all interactive elements.
class AppStrings {
  AppStrings._(); // Private constructor to prevent instantiation

  // App Identity
  static const String appName = 'VisionMate AI';
  static const String appTagline = 'Your Voice-First Assistant';
  static const String appDescription = 'Designed for blind and low-vision users';

  // Home Screen
  static const String homeTitle = 'VisionMate AI Home';
  static const String homeWelcome = 'Welcome to VisionMate AI';
  
  // Voice Status
  static const String voiceActive = 'Voice Active';
  static const String voiceInactive = 'Voice Inactive';
  static const String voiceStatusLabel = 'Voice interaction status';

  // Feature Labels
  static const String featureVoiceAssistant = 'Voice Assistant';
  static const String featureReadText = 'Read Text';
  static const String featureDescribeScene = 'Describe Surroundings';
  static const String featureNavigation = 'Navigation';
  static const String featureNewsMusic = 'News and Music';
  static const String featureContacts = 'Trusted Contacts';
  static const String featureSettings = 'Settings';

  // Feature Descriptions (for screen readers)
  static const String featureVoiceAssistantHint = 'Start voice interaction. Double tap to activate voice commands';
  static const String featureReadTextHint = 'Use camera to read printed text. Double tap to open camera';
  static const String featureDescribeSceneHint = 'Get AI description of your surroundings. Double tap to capture image';
  static const String featureNavigationHint = 'Navigate to a destination. Double tap to start navigation';
  static const String featureNewsMusicHint = 'Listen to news or play music. Double tap to open media options';
  static const String featureContactsHint = 'Call trusted contacts or send SOS. Double tap to open contacts';
  static const String featureSettingsHint = 'Configure app preferences. Double tap to open settings';

  // Common Actions
  static const String actionStart = 'Start';
  static const String actionContinue = 'Continue';
  static const String actionCancel = 'Cancel';
  static const String actionConfirm = 'Confirm';
  static const String actionBack = 'Back';
  static const String actionNext = 'Next';
  static const String actionDone = 'Done';
  static const String actionSkip = 'Skip';
  static const String actionClose = 'Close';

  // Semantic Labels
  static const String semanticLogo = 'VisionMate AI Logo';
  static const String semanticLoading = 'Loading, please wait';
  static const String semanticError = 'Error occurred';
  static const String semanticSuccess = 'Success';

  // Button Semantic Labels (for screen readers)
  static const String semanticButtonStart = 'Start button. Double tap to activate.';
  static const String semanticButtonBack = 'Back button. Double tap to go back.';
  static const String semanticButtonHome = 'Home button. Double tap to return to home screen.';

  // Announcements (spoken by TTS)
  static const String announcementWelcome = 'Welcome to VisionMate AI';
  static const String announcementLoading = 'Loading';
  static const String announcementError = 'An error occurred. Please try again.';
  static const String announcementSuccess = 'Action completed successfully';

  // Placeholder messages
  static const String placeholderFeature = 'This feature is under development';
  static const String placeholderComingSoon = 'Coming soon';
}
