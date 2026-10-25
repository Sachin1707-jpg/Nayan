# VisionMate AI — UI/UX Design Brief & Accessibility Design System

**Document Version:** 1.0.0  
**Document Status:** Approved Design System Specification  
**Roles & Perspectives:** Senior Mobile UI/UX Designer, Accessibility Design Specialist & Flutter Design-System Architect  
**Target Platform:** Android First (API 26+), Flutter 3.x Engine, Hardware Form Factor: Touchscreen Smartphones (5.8" to 6.8")  
**Primary Baseline References:** [PRD (v1.0.0)](file:///c:/Users/SACHIN%20VERMA/OneDrive/Desktop/Nayan/docs/01_PRD.md), [TRD (v1.0.0)](file:///c:/Users/SACHIN%20VERMA/OneDrive/Desktop/Nayan/docs/02_TRD.md), [App Flow (v1.0.0)](file:///c:/Users/SACHIN%20VERMA/OneDrive/Desktop/Nayan/docs/03_APP_FLOW.md)

---

## Table of Contents
1. [Design Philosophy: Non-Visual First & Low-Vision Ergonomics](#1-design-philosophy-non-visual-first--low-vision-ergonomics)
2. [User Experience (UX) Principles](#2-user-experience-ux-principles)
3. [Visual Design System & Sensory Tokens](#3-visual-design-system--sensory-tokens)
4. [Screen Specifications (11 Core Screens)](#4-screen-specifications-11-core-screens)
5. [Interaction Design & Multi-Sensory Choreography](#5-interaction-design--multi-sensory-choreography)
6. [Flutter Implementation Guidance](#6-flutter-implementation-guidance)
7. [Accessibility Validation & Testing Checklist](#7-accessibility-validation--testing-checklist)
8. [Reusable UI Component Inventory](#8-reusable-ui-component-inventory)
9. [Design Acceptance Criteria & Readiness Gates](#9-design-acceptance-criteria--readiness-gates)
10. [Open Design Decisions Requiring User Validation](#10-open-design-decisions-requiring-user-validation)

---

## 1. Design Philosophy: Non-Visual First & Low-Vision Ergonomics

Conventional mobile design processes treat visual aesthetics as the primary product surface, treating accessibility (TalkBack, contrast, screen readers) as a secondary retrofit. **VisionMate AI completely reverses this paradigm.**

```
+-------------------------------------------------------------------------------------------------------+
|                                    INVERTED DESIGN HIERARCHY                                          |
+-------------------------------------------------------------------------------------------------------+
|  TRADITIONAL APP DESIGN                       VISIONMATE AI DESIGN                                    |
|                                                                                                       |
|  [ Visual Layout / Graphics ]  (Primary)      [ Auditory & Haptic Feedback ]  (Primary - 0 sight req) |
|  [ Micro-Interactions / UI  ]  (Secondary)    [ Voice Dialogue & PTT Chord ]  (Primary input)         |
|  [ Accessibility Labels     ]  (Afterthought) [ Macro Touch Zones (>= 64dp) ]  (Tactile confidence)    |
|                                               [ WCAG AAA High Contrast UI  ]  (Low-vision support)    |
+-------------------------------------------------------------------------------------------------------+
```

### Core Tenets of the Philosophy
1. **The "Eyes-Closed" Invariant:** Every core task (reading mail, checking location, placing an SOS call) must be 100% executable with the smartphone display powered completely off (Screen Curtain Mode) or held in a pocket/chest lanyard.
2. **Predictable Spatial Geography:** The screen is treated as physical tactile geography rather than dynamic fluid visual layouts. Macro buttons remain anchored in fixed quadrants so users build muscle memory and never have to hunt for interactive elements.
3. **Multi-Sensory Redundancy (Tri-Modal Confirmation):** Every critical state change emits three synchronized feedback signals:
   - An acoustic sound signature (**Earcon**).
   - A distinct tactile vibration (**Haptic Waveform**).
   - A spoken speech confirmation or TalkBack semantic label (**TTS Speech**).
4. **Photophobia & Glare Elimination:** Over 60% of low-vision individuals suffer from light sensitivity (photophobia). White backgrounds and light glows cause painful glare. VisionMate AI's default visual presentation is pure OLED black (`#000000`) paired with radiant safety yellow (`#FFD700`) and electric cyan (`#00E5FF`).

---

## 2. User Experience (UX) Principles

### 2.1 Voice-First Interaction
* Voice is the fastest, lowest-friction interface for blind users.
* Commands must be conversational, forgiving of colloquialisms, and support **instant barge-in** interruption. Users should never be trapped listening to a monologue they already understand.

### 2.2 Clear, Non-Ambiguous Feedback
* Avoid generic silent loading spinners. A loading state must emit a subtle, rhythmic acoustic heartbeat (`earcon_thinking.wav`) and micro-haptic ticks so the user knows the application is alive and processing.

### 2.3 Minimal Cognitive Load
* Prevent sensory overload. Speak only the most critical information first (e.g., *"Prescription: Amoxicillin 500mg"* before reading instructions). Present complex document text in bite-sized, controllable paragraph blocks.

### 2.4 Consistent Global Navigation
* A single, universal escape hatch exists everywhere: a **Two-Finger Double Tap** immediately silences active speech, stops active camera frame analysis, cancels network requests, and returns to the safe Home Hub.

### 2.5 Safe Error Recovery
* Errors are never dead-ends. When a failure occurs (e.g., blurry image, network loss), the system immediately explains the cause in plain English, suggests an exact physical action (*"Move camera back 6 inches"*), and leaves the user in an actionable state.

### 2.6 Privacy and User Control
* Users maintain strict control over when their camera and microphone are active. VisionMate AI **never** leaves the camera running in the background without clear, audible periodic earcon cues.

### 2.7 Low-Vision Ergonomics
* For users with macular degeneration, cataracts, or tunnel vision, all typography scales dynamically up to 200%. Elements feature thick, high-contrast borders (3dp), eliminating thin divider lines and subtle grey shades.

### 2.8 Screen-Reader (TalkBack) Harmony
* The internal voice assistant and Android TalkBack must never speak simultaneously. Native `AudioFocusManager` coordinates with `STREAM_ACCESSIBILITY` to yield speech instantly whenever TalkBack speaks.

---

## 3. Visual Design System & Sensory Tokens

### 3.1 Color Palette & Contrast Tokens

All visual tokens comply with **WCAG 2.2 Level AAA (Contrast Ratio >= 7.0:1)** against the pure black canvas.

```
+------------------------------------------------------------------------------------------------------+
| Token Name           | Hex Code  | RGB          | Contrast vs #000000 | Semantic Purpose             |
+----------------------+-----------+--------------+---------------------+------------------------------+
| `color-canvas`       | `#000000` | (0, 0, 0)    | Baseline (1.0:1)    | OLED Pure Black Background   |
| `color-surface`      | `#121212` | (18, 18, 18) | 1.2:1 (Elevation)   | Container Card Background    |
| `color-surface-high` | `#1E1E1E` | (30, 30, 30) | 1.4:1 (Borders)     | Card Divider / Outlines      |
| `color-primary`      | `#FFD700` | (255, 215, 0)| 16.5:1 (AAA Pass)   | Primary Actions / Reading    |
| `color-secondary`    | `#00E5FF` | (0, 229, 255)| 13.8:1 (AAA Pass)   | Scene AI / Secondary Action  |
| `color-navigation`   | `#39FF14` | (57, 255, 20)| 14.1:1 (AAA Pass)   | Walking Nav / Success States |
| `color-alert`        | `#FF3B30` | (255, 59, 48)| 7.2:1  (AAA Pass)   | Emergency SOS / Stop / Error |
| `color-text-high`    | `#FFFFFF` | (255, 255,255| 21.0:1 (AAA Pass)   | Primary Reading Typography   |
| `color-text-medium`  | `#E0E0E0` | (224, 224,224| 17.5:1 (AAA Pass)   | Secondary Hints & Captions   |
| `color-focus-ring`   | `#00E5FF` | (0, 229, 255)| 13.8:1 (AAA Pass)   | TalkBack / Focus Indicator   |
+------------------------------------------------------------------------------------------------------+
```

### 3.2 Typography & Text Scaling

* **Font Family:** `Inter` or `Roboto` (System-native, neutral neo-grotesque with wide apertures, open counters, and distinct character glyphs for `I`, `l`, and `1`).
* **Text Scaling Guarantee:** The UI layout is architected using `LayoutBuilder` and `Flexible` containers to support up to **200% Android OS Font Scaling** without text clipping, truncation, or layout overflow.

```
+------------------------------------------------------------------------------------------------------+
| Typography Token   | Base Size | Scaled 200% | Font Weight | Line Height | Usage Context             |
+--------------------+-----------+-------------+-------------+-------------+---------------------------+
| `type-display-h1`  | 32sp      | 64sp        | 800 (Bold)  | 1.25        | Screen Titles, Critical SOS|
| `type-headline-h2` | 24sp      | 48sp        | 700 (Bold)  | 1.30        | Section Headers, Quadrants|
| `type-body-large`  | 20sp      | 40sp        | 600 (Medium)| 1.40        | OCR Text Readout Display  |
| `type-body-medium` | 18sp      | 36sp        | 500 (Reg)   | 1.45        | Descriptions & Summaries  |
| `type-button-text` | 22sp      | 44sp        | 700 (Bold)  | 1.20        | Touch Target Macro Labels |
| `type-caption`     | 16sp      | 32sp        | 500 (Reg)   | 1.35        | Timestamps & Metadata     |
+------------------------------------------------------------------------------------------------------+
```

### 3.3 Spacing & Layout Grid
* Built upon an **8dp Base Grid**.
* Padding tokens: `space-xs: 4dp`, `space-sm: 8dp`, `space-md: 16dp`, `space-lg: 24dp`, `space-xl: 32dp`.
* **Touch-Target Minimum:** Every interactive tap zone must measure at least **64 x 64 dp** (exceeding standard 48x48 dp WCAG baseline to support tremors and motor impairments).

### 3.4 Button & Focus Indicators
* **Macro Button Surfaces:** Minimum height of **72dp**; solid high-contrast borders (3dp thickness) using `#FFD700` or `#00E5FF`. Rounded corners (16dp radius) for tactile comfort.
* **TalkBack Focus Indicator:** When a widget receives screen-reader focus, it displays a **4dp solid `#00E5FF` electric cyan outline** with an inner 2dp pure black inset shadow to ensure visibility over any background color.

---

## 4. Screen Specifications (11 Core Screens)

```
+-------------------------------------------------------------------------------------------------------+
|                                      SCREEN SPECIFICATION INDEX                                       |
+-------------------------------------------------------------------------------------------------------+
```

### 4.1 SCR-01: Welcome & Onboarding Wizard
```
+---------------------------------------+
| [VisionMate AI Logo & Header (32sp)]  |
|                                       |
| [Welcome Voice Card (22sp)]           |
| "Hold anywhere on screen to speak"    |
|                                       |
| +-----------------------------------+ |
| | [SPEECH RATE SLIDER (72dp)]       | |
| | Current: 1.0x (Normal)            | |
| +-----------------------------------+ |
|                                       |
| +-----------------------------------+ |
| | [SAFETY CONFIRMATION BUTTON]      | |
| | "I Understand the Safety Notice"  | |
| | Border: 3dp Solid #FFD700         | |
| +-----------------------------------+ |
|                                       |
| [Tactile Hint: "Two fingers to stop"] |
+---------------------------------------+
```
* **Screen Purpose:** Introduce non-visual controls, calibrate speech rate, confirm safety disclaimers, and verify basic voice interaction.
* **Component Hierarchy:** `Scaffold` -> `SafeArea` -> `Column` -> `HeaderTitle` -> `VoiceStatusBanner` -> `SpeechRateSlider` -> `SafetyNoticeCard` -> `ConfirmationMacroButton`.
* **Main Action:** Double-tap *"I Understand the Safety Notice"* button or vocalize *"I understand"*.
* **Secondary Actions:** Double-tap speech rate stepper (*"Faster"* / *"Slower"*).
* **Accessibility Labels:**  
  - Slider: `Semantics(label: "Speech rate slider, current value 1.0x", value: "1.0", increasedValue: "1.25", decreasedValue: "0.75")`.
  - Button: `Semantics(label: "Safety Notice Confirmation", hint: "Double tap to agree and complete setup", button: true)`.
* **Screen-Reader Behavior:** Automatically focuses on the HeaderTitle; announces: *"VisionMate onboarding. Listen to instructions or swipe right to adjust speech speed."*
* **Loading State:** Not applicable (local synchronous configuration).
* **Error State:** If microphone is rejected, switches to Tactile-Only guidance mode.
* **Empty State:** Not applicable.

---

### 4.2 SCR-02: Accessible Home Screen (Tactile Hub)
```
+---------------------------------------+
| [TOP-LEFT QUADRANT] [TOP-RIGHT QUAD]  |
| "READ TEXT"         | "DESCRIBE SCENE"|
| Color: #FFD700      | Color: #00E5FF  |
| Icon: Eye/Page      | Icon: Sparkles  |
| (Height: 45% screen)| (Height: 45%)   |
+---------------------+-----------------+
| [BOT-LEFT QUADRANT] | [BOT-RIGHT QUAD]|
| "DIRECTIONS"        | "NEWS & SETTINGS|
| Color: #39FF14      | Color: #FFFFFF  |
| Icon: Compass       | Icon: Gear      |
| (Height: 45% screen)| (Height: 45%)   |
+---------------------+-----------------+
| [BOTTOM DOCK: EMERGENCY SOS TRIPLE-TAP]
+---------------------------------------+
```
* **Screen Purpose:** Stable, permanent home base. 4 giant touch quadrants dividing the screen evenly.
* **Component Hierarchy:** `Scaffold` -> `Stack` -> `GridView.count(crossAxisCount: 2)` -> 4 x `AccessibleQuadrantCard`.
* **Main Action:** Long-press anywhere (400ms) or double-press Volume Down to speak any command.
* **Secondary Actions:** Single-tap any quadrant to hear label; double-tap to open feature.
* **Accessibility Labels:**  
  - Quadrant 1: `Semantics(label: "Read Text, Button", hint: "Double tap to open camera text scanner")`.
  - Quadrant 2: `Semantics(label: "Describe Scene, Button", hint: "Double tap to take a photo and hear description")`.
  - Quadrant 3: `Semantics(label: "Walking Directions, Button", hint: "Double tap to search destinations")`.
  - Quadrant 4: `Semantics(label: "News and Settings, Button", hint: "Double tap to view headlines and preferences")`.
* **Screen-Reader Behavior:** Focuses top-left quadrant on open. Swiping right traverses logically through the 4 quadrants in clockwise order.
* **Loading State:** Passive ambient mode (0.01% CPU, zero network).
* **Error State:** Network offline displays a high-contrast subtle warning banner at the top (`#FF3B30`), but quadrants remain 100% active.
* **Empty State:** Not applicable.

---

### 4.3 SCR-03: Voice Assistant Overlay Modal
```
+---------------------------------------+
| [Dimmed Background: #000000 80% alpha]|
|                                       |
|        ((((( RHYTHMIC )))))           |
|        ((((( LISTENING ))))           |
|        ((((( WAVEFORM  ))))           |
|        Color: Electric Cyan           |
|                                       |
| [TRANSCRIPT BOX (28sp High-Contrast)] |
| "Read this letter"                    |
|                                       |
| [HINT BAR: "Release to process"]      |
+---------------------------------------+
```
* **Screen Purpose:** Transient voice interaction overlay indicating listening, processing, and response states.
* **Component Hierarchy:** `ModalBottomSheet` / `OverlayEntry` -> `ListeningWaveform` -> `LiveTranscriptionBox` -> `CancelTouchDetector`.
* **Main Action:** Speak a natural voice command into the microphone.
* **Secondary Actions:** Tap anywhere with two fingers to cancel; release PTT button.
* **Accessibility Labels:** `Semantics(liveRegion: true, label: "Listening for your command. Speak now.")`.
* **Screen-Reader Behavior:** Announces *"Listening"* via `SemanticsService.announce()`. As speech is transcribed, updates `liveRegion`.
* **Loading State:** Waveform transitions from expanding rings (listening) to rotating dots (processing intent).
* **Error State:** No speech detected speaks: *"I didn't hear anything. Try again."* and closes overlay after 2 seconds.
* **Empty State:** Transcript box displays placeholder text: *"Listening..."*.

---

### 4.4 SCR-04: Camera Text Reader (OCR)
```
+---------------------------------------+
| [TOP BAR: Torch Toggle / Mode: INSTANT|
+---------------------------------------+
|                                       |
|  [HIGH-CONTRAST TEXT READOUT CARD]    |
|  "Pharmacy 500mg"                     |
|  "Take one tablet daily"              |
|  (Size: 24sp Bold, #FFD700 on #000000)|
|                                       |
|---------------------------------------|
| [AIMING HINT: "Document well aligned"]|
+---------------------------------------+
| [BOTTOM MACRO: 'CAPTURE DOCUMENT']    |
| Border: 3dp Solid #FFD700             |
+---------------------------------------+
```
* **Screen Purpose:** Live real-time text extraction (Instant Mode) or high-res document capture (Document Mode).
* **Component Hierarchy:** `Scaffold` -> `CameraPreview` (underneath) -> `BlackScrimOverlay` -> `LiveTextContainer` -> `AimingFeedbackBanner` -> `CaptureActionButton`.
* **Main Action:** Point camera at text; listen to automated speech readout.
* **Secondary Actions:** Tap *"Capture Document"* button; tap screen to pause/resume speech; voice command *"Flashlight"*.
* **Accessibility Labels:**  
  - Camera View: Excluded from TalkBack (`excludeSemantics: true`) to avoid spamming the screen reader with raw bounding boxes.
  - Readout Card: `Semantics(liveRegion: true, label: "Recognized text: Pharmacy 500 milligrams...")`.
* **Screen-Reader Behavior:** Dispatches clean synthesized speech chunks directly through `flutter_tts` rather than raw TalkBack focus changes.
* **Loading State:** Document processing displays high-contrast pulsing border and emits `earcon_processing.wav`.
* **Error State:** No text in frame emits a gentle click; blurry frame prompts: *"Hold steady, image is blurry"*.
* **Empty State:** Displays text: *"Point camera at printed mail, signs, or labels."*.

---

### 4.5 SCR-05: AI Scene Assistant (Visual Q&A)
```
+---------------------------------------+
| [TOP BAR: 'Scene Snapshot Captured']  |
+---------------------------------------+
|                                       |
|  [SCENE DESCRIPTION CARD (22sp)]      |
|  "In front of you is a kitchen        |
|   table. Coffee mug at your           |
|   2 o'clock, chair at 11 o'clock."    |
|  Color: #00E5FF on #000000            |
|                                       |
+---------------------------------------+
| [BOTTOM MACRO: 'HOLD TO ASK QUESTION']|
| Border: 3dp Solid #00E5FF             |
+---------------------------------------+
```
* **Screen Purpose:** Deliver a 2-sentence situational scene summary with clock-face landmarks and allow contextual follow-up questions.
* **Component Hierarchy:** `Scaffold` -> `FrozenSnapshotThumbnail` -> `SceneSummaryContainer` -> `FollowUpVoiceButton`.
* **Main Action:** Listen to initial spoken description; hold bottom button to ask follow-up (*"Where is my mug?"*).
* **Secondary Actions:** Two-finger double-tap to return to Home; swipe to re-read description.
* **Accessibility Labels:** `Semantics(label: "Scene description: In front of you is a kitchen table...")`.
* **Screen-Reader Behavior:** Focuses on the description text card automatically; TalkBack reads full text sequentially.
* **Loading State:** Plays rhythmic ticking earcon every 1.0 second; displays animated high-contrast cyan pulse.
* **Error State:** Network timeout speaks: *"Scene description unavailable. Text reading is still working offline."*.
* **Empty State:** Displays: *"Capturing scene..."*.

---

### 4.6 SCR-06: Destination Search & Route Preview
```
+---------------------------------------+
| [HEADER: 'Search Destination']        |
|                                       |
| +-----------------------------------+ |
| | [VOICE SEARCH BAR (72dp)]         | |
| | "Tap to speak address or place"   | |
| +-----------------------------------+ |
|                                       |
| [SAVED FAVORITE LOCATIONS (List)]     |
| +-----------------------------------+ |
| | Home (124 Maple St) - 400m        | |
| +-----------------------------------+ |
| | Pharmacy (Corner of 4th Ave)      | |
| +-----------------------------------+ |
|                                       |
| [CANCEL BUTTON (Bottom)]              |
+---------------------------------------+
```
* **Screen Purpose:** Resolve destination addresses via voice search or saved favorite waypoints.
* **Component Hierarchy:** `Scaffold` -> `VoiceSearchTriggerButton` -> `FavoritesListView` -> `DestinationResultCard`.
* **Main Action:** Tap search bar and speak destination (*"Navigate to Central Library"*).
* **Secondary Actions:** Double-tap a saved favorite location card.
* **Accessibility Labels:**  
  - Search: `Semantics(label: "Voice search destination", hint: "Double tap to speak destination address")`.
  - Favorites: `Semantics(label: "Favorite: Home, 124 Maple Street. 400 meters away.", button: true)`.
* **Screen-Reader Behavior:** Focus starts on the search button, followed by saved waypoints in order of distance.
* **Loading State:** Geocoding search speaks: *"Searching for Central Library..."*.
* **Error State:** Address not found speaks: *"Could not find that address. Please repeat with street name and city."*.
* **Empty State:** Favorites list displays: *"No saved favorites. Say 'Save current location as Home' to add one."*.

---

### 4.7 SCR-07: Navigation Assistance (Live Walking Guidance)
```
+---------------------------------------+
| [GIANT DIRECTION ARROW (High-Contrast)|
|  Turning Left in 15 meters            |
|  Color: #39FF14 (Emerald Green)       |
+---------------------------------------+
|                                       |
|  [CURRENT STEP READOUT (26sp Bold)]   |
|  "In 15 meters, turn left             |
|   onto Market Street."                |
|                                       |
|  [NEXT STEP PREVIEW (18sp)]           |
|  "Then walk forward 80 meters"        |
|                                       |
+---------------------------------------+
| [BOTTOM MACRO: 'END NAVIGATION']      |
| Border: 3dp Solid #FF3B30 (Alert Red) |
+---------------------------------------+
```
* **Screen Purpose:** Guide the pedestrian safely along sidewalks using relative clock-face turn directions and off-route warnings.
* **Component Hierarchy:** `Scaffold` -> `HighContrastDirectionalGraphic` -> `ActiveTurnStepCard` -> `NextStepSubCard` -> `StopNavigationButton`.
* **Main Action:** Listen to turn-by-turn spoken guidance; walk along designated path.
* **Secondary Actions:** Shake phone to repeat current instruction; double-tap *"End Navigation"* to abort.
* **Accessibility Labels:** `Semantics(liveRegion: true, label: "Current step: In 15 meters, turn left onto Market Street.")`.
* **Screen-Reader Behavior:** Updates `liveRegion` automatically as user crosses GPS step boundaries. Does not spam speech during straight walking.
* **Loading State:** Recalculating route speaks: *"Recalculating walking route..."*.
* **Error State:** Off-route drift (>15m) triggers severe double-buzz haptic and speaks: *"Off route. Turn around."*.
* **Empty State:** Not applicable.

---

### 4.8 SCR-08: News Reader & Audio Summaries
```
+---------------------------------------+
| [HEADER: 'Today's News' (Tech Category|
+---------------------------------------+
|                                       |
|  [HEADLINE CARD (24sp Bold)]          |
|  "Breakthrough in Assistive Robotics  |
|   Announced Today"                    |
|                                       |
|  [ARTICLE SUMMARY (20sp)]             |
|  "Researchers develop new tactile...  |
|                                       |
+---------------------------------------+
| [PLAY / PAUSE MACRO BUTTON (80dp)]    |
| [NEXT STORY BUTTON (80dp)]            |
+---------------------------------------+
```
* **Screen Purpose:** Hands-free voice listening of curated top headlines and summaries from clean RSS feeds.
* **Component Hierarchy:** `Scaffold` -> `CategoryFilterChips` -> `HeadlineCard` -> `ArticleBody` -> `AudioPlaybackControlsDock`.
* **Main Action:** Single tap to pause/resume playback; voice command *"Next story"*.
* **Secondary Actions:** Swipe right to skip; voice command *"Summarize"*.
* **Accessibility Labels:** `Semantics(label: "News story 1 of 5: Breakthrough in Assistive Robotics. Double tap to read full story.")`.
* **Screen-Reader Behavior:** Automatically reads the active headline upon navigation; controls are labeled with current playback state (`Playing` / `Paused`).
* **Loading State:** Displays high-contrast spinner and speaks: *"Fetching latest news headlines..."*.
* **Error State:** Network down speaks: *"Cannot fetch news while offline. Try again when connected."*.
* **Empty State:** Displays: *"No news articles found in this category."*.

---

### 4.9 SCR-09: Music & Media Controller
```
+---------------------------------------+
| [HEADER: 'Media Playback' (Spotify) ] |
+---------------------------------------+
|                                       |
|  [TRACK TITLE (28sp Bold)]            |
|  "Kind of Blue"                       |
|  [ARTIST (22sp)]                      |
|  "Miles Davis"                        |
|                                       |
+---------------------------------------+
| +-----------------------------------+ |
| | [PLAY / PAUSE TOGGLE (80dp)]      | |
| | Border: 3dp Solid #FFFFFF         | |
| +-----------------------------------+ |
|                                       |
| [VOICE HINT: "Say 'Play jazz'"]       |
+---------------------------------------+
```
* **Screen Purpose:** Audio media status and control bridge over external music services (Spotify, YouTube Music).
* **Component Hierarchy:** `Scaffold` -> `TrackMetadataCard` -> `TransportControlsRow` -> `AppLauncherButton`.
* **Main Action:** Tap large center button to toggle Play/Pause.
* **Secondary Actions:** Voice commands: *"Next track"*, *"Volume up"*, *"Play classic rock"*.
* **Accessibility Labels:** `Semantics(label: "Now playing Kind of Blue by Miles Davis. Play Pause button, currently playing.", button: true)`.
* **Screen-Reader Behavior:** Reflects Android MediaSession metadata; voice intents duck and resume gracefully.
* **Loading State:** Connecting speaks: *"Opening Spotify..."*.
* **Error State:** If player app is missing, speaks: *"Spotify is not installed. Would you like to use your default music player?"*.
* **Empty State:** Displays: *"No music currently playing. Say 'Play music' to begin."*.

---

### 4.10 SCR-10: Trusted Contacts & Emergency Calling
```
+---------------------------------------+
| [HEADER: 'Trusted Contacts & SOS']    |
+---------------------------------------+
|                                       |
| +-----------------------------------+ |
| | [PRIMARY CONTACT CARD (80dp)]     | |
| | Sarah (Daughter)                  | |
| | +1 (555) 234-5678                 | |
| | [CALL BUTTON]  [SMS LOCATION]     | |
| +-----------------------------------+ |
|                                       |
| +-----------------------------------+ |
| | [TRIGGER EMERGENCY SOS NOW]       | |
| | Border: 4dp Solid #FF3B30         | |
| | Color: Alert Red                  | |
| +-----------------------------------+ |
|                                       |
| [HINT: "Triple-tap screen for SOS"]   |
+---------------------------------------+
```
* **Screen Purpose:** Contact trusted family members, send emergency GPS coordinates, or trigger SOS.
* **Component Hierarchy:** `Scaffold` -> `PrimaryContactCard` -> `SecondaryContactCard` -> `AddContactButton` -> `EmergencySosMacroButton`.
* **Main Action:** Double-tap contact to place a cellular phone call; or voice *"Call Sarah"*.
* **Secondary Actions:** Double-tap *"Trigger Emergency SOS Now"*.
* **Accessibility Labels:**  
  - Contact: `Semantics(label: "Primary contact Sarah, phone number 555-234-5678. Double tap to call.", button: true)`.
  - SOS: `Semantics(label: "Emergency SOS. Double tap to send location and call emergency contact immediately.", button: true)`.
* **Screen-Reader Behavior:** Focuses first on Primary Contact; SOS button has custom semantic action warning: *"Warning: Places emergency call"*.
* **Loading State:** Dispatching SMS shows high-contrast alert and speaks: *"Sending your location to Sarah..."*.
* **Error State:** No cell signal speaks: *"No cellular service. Cannot send emergency text message."*.
* **Empty State:** If no contact configured, speaks: *"No trusted contacts saved. Say 'Add contact' to set one up."*.

---

### 4.11 SCR-11: Accessibility & Privacy Settings
```
+---------------------------------------+
| [HEADER: 'Accessibility Settings']    |
+---------------------------------------+
|                                       |
| +-----------------------------------+ |
| | [SCREEN CURTAIN TOGGLE (72dp)]    | |
| | State: OFF (Display Active)       | |
| +-----------------------------------+ |
|                                       |
| +-----------------------------------+ |
| | [THEME PALETTE SELECTOR (72dp)]   | |
| | Active: Pure Black & Yellow       | |
| +-----------------------------------+ |
|                                       |
| +-----------------------------------+ |
| | [HAPTIC INTENSITY STEPPER (72dp)] | |
| | Active: Strong (Recommended)      | |
| +-----------------------------------+ |
|                                       |
| [BACK TO HOME BUTTON (Bottom)]        |
+---------------------------------------+
```
* **Screen Purpose:** Customize speech synthesis, theme contrast, Screen Curtain, and privacy toggles.
* **Component Hierarchy:** `Scaffold` -> `ListView` -> 4 x `AccessibleSettingsRow` -> `ResetDefaultsButton`.
* **Main Action:** Double-tap any toggle row to cycle setting.
* **Secondary Actions:** Voice commands: *"Turn on Screen Curtain"*, *"Set theme to High Contrast White"*.
* **Accessibility Labels:**  
  - Curtain: `Semantics(label: "Screen Curtain. Turns off display backlight for privacy and battery. Currently off.", toggled: false, button: true)`.
  - Theme: `Semantics(label: "Color theme selector. Currently Black and Yellow.", button: true)`.
* **Screen-Reader Behavior:** Traverses list linearly; every change announces immediate confirmation via TTS and haptic tick.
* **Loading State:** Not applicable (synchronous settings persistence).
* **Error State:** Not applicable.
* **Empty State:** Not applicable.

---

## 5. Interaction Design & Multi-Sensory Choreography

To eliminate confusion, the application coordinates its four sensory channels (Voice, Audio Earcons, Haptics, and Screen Readers) according to strict rules of precedence.

```
+-------------------------------------------------------------------------------------------------------+
|                                  SENSORY CHOREOGRAPHY MATRIX                                          |
+--------------------+-------------------------+------------------------+-------------------------------+
| User Event         | Earcon Sound Cue        | Haptic Vibration Pulse | Speech / Screen Reader Action |
+--------------------+-------------------------+------------------------+-------------------------------+
| Push-to-Talk Press | earcon_listen_start.wav | Single 30ms sharp tick | Mutes background audio;       |
| (Double-click Vol) | (Ascending 2-tone)      | (Heavy click)          | awaits speech input.          |
+--------------------+-------------------------+------------------------+-------------------------------+
| Speech End (VAD)   | None                    | None                   | Begins local NLU intent       |
|                    |                         |                        | parsing immediately.          |
+--------------------+-------------------------+------------------------+-------------------------------+
| Cloud AI Waiting   | earcon_thinking.wav     | Periodic micro-tick    | Periodic soft acoustic pulse  |
| (> 1.0 second)     | (Rhythmic subtle pulse) | every 1.5 seconds      | confirms system alive.        |
+--------------------+-------------------------+------------------------+-------------------------------+
| Task Succeeded     | earcon_success.wav      | Dual crisp light pulses| Speaks result via TTS         |
| (OCR / Scene Done) | (Bright bell chime)     | (50ms on, 30ms off)    | (Ducks all other streams).    |
+--------------------+-------------------------+------------------------+-------------------------------+
| Off-Route Warning  | earcon_warning.wav      | Severe double pulse    | Speaks: "Off route. Turn      |
| (Nav Drift > 15m)  | (Low double buzz)       | (150ms heavy pulses)   | around and walk 15m back."    |
+--------------------+-------------------------+------------------------+-------------------------------+
| Emergency SOS      | earcon_sos.wav          | Continuous pulsing     | Speaks countdown: "Calling in |
| Trigger (Triple-tap| (Loud alternating siren)| pattern (100ms cycle)  | 3... 2... Tap to cancel."     |
+--------------------+-------------------------+------------------------+-------------------------------+
| Universal Cancel   | earcon_stopped.wav      | Single blunt thump     | Halts active speech instantly;|
| (2-Finger Double)  | (Downward tone)         | (80ms dull vibration)  | announces: "Cancelled."       |
+--------------------+-------------------------+------------------------+-------------------------------+
```

### 5.1 Speech Collision Prevention Architecture
* **Rule 1 (TalkBack Priority):** If Android TalkBack begins speaking an accessibility focus announcement, VisionMate AI's internal TTS engine **must pause immediately**.
* **Rule 2 (Voice Prompt Exclusivity):** When internal TTS is reading a document, background music is ducked by 80%. When the user triggers PTT, background music is muted 100%.
* **Rule 3 (No Duplicate Announcements):** Never announce the same text twice through both TalkBack focus and automated TTS speech. Text displayed on `SCR-04` and `SCR-05` uses `excludeSemantics: true` on the visual card if internal TTS is already reading it aloud.

---

## 6. Flutter Implementation Guidance

### 6.1 Semantic Tree Optimization & Clean Widgets

```dart
// Example: Accessible High-Contrast Macro Button
class AccessibleMacroButton extends StatelessWidget {
  final String label;
  final String hint;
  final Color borderColor;
  final VoidCallback onTap;
  final Widget icon;

  const AccessibleMacroButton({
    super.key,
    required this.label,
    required this.hint,
    required this.borderColor,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      hint: hint,
      button: true,
      enabled: true,
      excludeSemantics: true, // Prevents reading child text twice
      child: Material(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: borderColor, width: 3.5),
        ),
        child: InkWell(
          onTap: () {
            HapticFeedback.heavyImpact();
            onTap();
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            constraints: const BoxConstraints(minHeight: 72, minWidth: 72),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 16),
                Flexible(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: borderColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

### 6.2 Focus Traversal & Directional Management
To prevent blind users from becoming disoriented when swiping through TalkBack:
* Group related controls into explicit `FocusTraversalGroup` containers.
* Apply `OrderedTraversalPolicy` to guarantee that the primary action is always encountered first before auxiliary buttons.

### 6.3 Dynamic Text Scaling Without Overflow
* **Never use fixed heights** on containers holding text. Always use `minHeight` constraints paired with `Flexible` or `Expanded` widgets.
* Wrap all vertically scrolling content in `SingleChildScrollView(physics: BouncingScrollPhysics())` to guarantee that 200% font scaling can scroll naturally without clipping bottom buttons.

---

## 7. Accessibility Validation & Testing Checklist

Prior to any feature release, the QA and design team must execute the following validation suite on an **Android physical test device (Google Pixel or Samsung Galaxy)**:

```
+------------------------------------------------------------------------------------------------------+
| Check Item | Testing Domain             | Exact Verification Condition               | Pass / Fail   |
+------------+----------------------------+--------------------------------------------+---------------+
| CHK-01     | Eyes-Closed Operation      | Execute full OCR read, scene description,  | [ ] Verified  |
|            |                            | and phone call with screen curtain active. |               |
+------------+----------------------------+--------------------------------------------+---------------+
| CHK-02     | Color Contrast Compliance  | Automated check: All text >= 7.0:1 (AAA)   | [ ] Verified  |
|            |                            | against dark canvas using contrast checker.|               |
+------------+----------------------------+--------------------------------------------+---------------+
| CHK-03     | Minimum Touch Target Size  | All tappable surfaces >= 64 x 64 dp        | [ ] Verified  |
|            |                            | verified via Android Accessibility Scanner.|               |
+------------+----------------------------+--------------------------------------------+---------------+
| CHK-04     | 200% OS Text Scaling       | Set Android OS Font Size to Largest. Zero  | [ ] Verified  |
|            |                            | text clipping, truncation, or RenderFlex.  |               |
+------------+----------------------------+--------------------------------------------+---------------+
| CHK-05     | TalkBack Traversal Order   | Swiping right moves logically from top to  | [ ] Verified  |
|            |                            | bottom with 0 focus traps or dead ends.    |               |
+------------+----------------------------+--------------------------------------------+---------------+
| CHK-06     | Meaningful Semantic Labels | Zero unlabelled buttons (no "Button 42" or | [ ] Verified  |
|            |                            | "Unlabelled Image" announcements).         |               |
+------------+----------------------------+--------------------------------------------+---------------+
| CHK-07     | Push-to-Talk Barge-In      | User speaks during long TTS readout; TTS   | [ ] Verified  |
|            |                            | silences completely within <= 100 ms.      |               |
+------------+----------------------------+--------------------------------------------+---------------+
| CHK-08     | Universal Escape Hatch     | Two-finger double tap returns safely to    | [ ] Verified  |
|            |                            | Home Hub from any screen or modal state.   |               |
+------------------------------------------------------------------------------------------------------+
```

---

## 8. Reusable UI Component Inventory

```
+------------------------------------------------------------------------------------------------------+
| Component Name       | Purpose                       | Required Properties     | Flutter Widget Core |
+----------------------+-------------------------------+-------------------------+---------------------+
| `AccessibleMacroBtn` | Full-width tactile button     | `label`, `hint`,        | `Semantics` +       |
|                      | for high-frequency actions    | `borderColor`, `onTap`  | `InkWell` + `Border`|
+----------------------+-------------------------------+-------------------------+---------------------+
| `TactileQuadrantCard`| Quarter-screen anchor button  | `title`, `iconData`,    | `Expanded` +        |
|                      | for main home hub             | `themeColor`, `route`   | `Semantics(button)` |
+----------------------+-------------------------------+-------------------------+---------------------+
| `HighContrastCard`   | Card container for OCR text   | `child`, `borderColor`, | `Container` +       |
|                      | and scene descriptions        | `backgroundColor`       | `BoxDecoration`     |
+----------------------+-------------------------------+-------------------------+---------------------+
| `EarconSoundScope`   | Plays pre-cached audio cues   | `soundAssetKey`,        | `Soundpool` /       |
|                      | with zero latency             | `volume`                | `audioplayers`      |
+----------------------+-------------------------------+-------------------------+---------------------+
| `HapticPulseDriver`  | Executes specialized tactile  | `HapticPattern`         | Android native      |
|                      | vibration waveforms           | (`tick`, `severe`, `sos`| `Vibrator` channel  |
+----------------------+-------------------------------+-------------------------+---------------------+
| `ScreenCurtainLayer` | Pure black OLED blackout      | `isActive`,             | `Positioned.fill` + |
|                      | surface maintaining touch     | `onChordDismiss`        | `Color(0xFF000000)` |
+----------------------+-------------------------------+-------------------------+---------------------+
| `AccessibleSlider`   | Stepped slider for speech     | `value`, `min`, `max`,  | `Semantics` +       |
|                      | speed with tactile ticks      | `divisions`, `onChanged`| `SliderTheme`       |
+----------------------+-------------------------------+-------------------------+---------------------+
```

---

## 9. Design Acceptance Criteria & Readiness Gates

Before any UI screen is accepted for sprint engineering implementation, the design team and accessibility specialist must sign off on the following measurable criteria:

* **Gate 1 (Zero-Sight Completion):** The screen's primary task can be initiated, completed, and verified by a user wearing a light-blocking sleep mask.
* **Gate 2 (Non-Visual Error Recovery):** Every possible failure state (timeout, blur, disconnect) has an associated earcon sound and plain-English vocal recovery prompt.
* **Gate 3 (Touch Safety):** Tappable buttons have minimum 16dp spacing between them to prevent accidental presses by users with tremors.
* **Gate 4 (Color Independence):** No information is conveyed by color alone. Every colored visual cue (e.g. green arrival, red alert) is accompanied by an earcon and text/speech label.

---

## 10. Open Design Decisions Requiring User Validation

The following design decisions are currently provisional and must be validated through participatory user testing with blind and low-vision participants during the Alpha phase:

1. **Quadrant Haptic Borders:**  
   *Question:* Should crossing the visual boundary between quadrants on `SCR-02` trigger a subtle haptic boundary tick as the user drags their finger across the screen?  
   *Test Plan:* Test 10 participants to determine if boundary ticks enhance spatial orientation or create annoying sensory clutter.
2. **Push-to-Talk Gesture Preference:**  
   *Question:* Do participants prefer a double-tap on the hardware Volume Down key, a long-press anywhere on the screen, or a two-finger single tap to initiate listening?  
   *Test Plan:* Benchmark false-activation rates and user preference across a 3-day diary study.
3. **Screen Curtain Unlock Chord:**  
   *Question:* Is a 3-finger triple-tap reliable for blind users, or does it cause accidental triggers compared to a hardware chord (holding Volume Up + Volume Down for 3 seconds)?  
   *Test Plan:* Measure accidental activation rate during transit simulations.

---
*End of UI/UX Design Brief.*  
*Next Stage: Flutter Project Architecture Scaffold, Atomic Component Library, and Prototype Spikes.*
