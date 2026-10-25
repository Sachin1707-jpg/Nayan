/// Application sizing constants optimized for accessibility.
/// 
/// All touch targets meet or exceed WCAG 2.2 guidelines for
/// accessible interactive elements.
class AppSizes {
  AppSizes._(); // Private constructor to prevent instantiation

  // Touch Targets
  /// Minimum touch target size for all interactive elements
  /// Exceeds WCAG 2.2 Level AAA requirement (44x44dp)
  static const double minTouchTarget = 72.0;

  /// Standard button height
  static const double buttonHeight = 72.0;

  /// Large button height for primary actions
  static const double buttonHeightLarge = 88.0;

  /// Small button height (still accessible)
  static const double buttonHeightSmall = 56.0;

  // Spacing Scale
  /// Extra small spacing (4dp)
  static const double spacingXS = 4.0;

  /// Small spacing (8dp)
  static const double spacingS = 8.0;

  /// Medium spacing (16dp)
  static const double spacingM = 16.0;

  /// Large spacing (24dp)
  static const double spacingL = 24.0;

  /// Extra large spacing (32dp)
  static const double spacingXL = 32.0;

  /// Extra extra large spacing (48dp)
  static const double spacingXXL = 48.0;

  // Border Radius
  /// Small border radius for subtle rounding
  static const double radiusS = 8.0;

  /// Medium border radius for buttons and cards
  static const double radiusM = 16.0;

  /// Large border radius for prominent elements
  static const double radiusL = 24.0;

  // Border Width
  /// Thin border (visible but subtle)
  static const double borderThin = 1.0;

  /// Medium border (clearly visible)
  static const double borderMedium = 2.0;

  /// Thick border (high visibility for focus states)
  static const double borderThick = 3.0;

  // Icon Sizes
  /// Small icon size
  static const double iconS = 24.0;

  /// Medium icon size
  static const double iconM = 32.0;

  /// Large icon size
  static const double iconL = 48.0;

  /// Extra large icon size (logos, feature icons)
  static const double iconXL = 64.0;

  /// Huge icon size (splash, welcome screens)
  static const double iconXXL = 80.0;

  // Text Sizes
  /// Minimum body text size for accessibility
  /// Meets WCAG Level AAA for readability
  static const double textBodyMin = 16.0;

  /// Standard body text size
  static const double textBody = 18.0;

  /// Large body text size
  static const double textBodyLarge = 20.0;

  /// Headline text size
  static const double textHeadline = 32.0;

  /// Title text size
  static const double textTitle = 24.0;

  /// Button text size
  static const double textButton = 20.0;

  // Padding
  /// Screen edge padding
  static const double paddingScreen = 24.0;

  /// Card padding
  static const double paddingCard = 16.0;

  /// Button padding (horizontal)
  static const double paddingButton = 24.0;
}
