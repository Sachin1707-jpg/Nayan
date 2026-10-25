# VisionMate AI — Product Requirements Document (PRD)

**Document Version:** 1.0.0  
**Document Status:** Draft for Technical & User Validation Review  
**Author:** Senior Product Manager, Accessibility Product Specialist & Mobile Application Architect  
**Target Platform:** Android (First Priority), Flutter & Dart (Cross-Platform Architecture for Future iOS Feasibility)  
**Development Toolchain:** Windows Dev Environment, Flutter SDK, Dart, Antigravity IDE  
**Target Release Horizon:** MVP (Q1) / Phased V1 Rollout  

---

## Table of Contents
1. [Executive Summary](#1-executive-summary)
2. [Problem Statement](#2-problem-statement)
3. [Product Vision and Objectives](#3-product-vision-and-objectives)
4. [Target Users and User Personas](#4-target-users-and-user-personas)
5. [User Needs and Pain Points](#5-user-needs-and-pain-points)
6. [Product Goals and Non-Goals](#6-product-goals-and-non-goals)
7. [Functional Requirements](#7-functional-requirements)
8. [Non-Functional Requirements](#8-non-functional-requirements)
9. [Feature Prioritization (MoSCoW Matrix)](#9-feature-prioritization-moscow-matrix)
10. [User Stories with Acceptance Criteria](#10-user-stories-with-acceptance-criteria)
11. [Primary Use Cases](#11-primary-use-cases)
12. [Accessibility Requirements (A11y Core)](#12-accessibility-requirements-a11y-core)
13. [Privacy and Security Requirements](#13-privacy-and-security-requirements)
14. [Safety Requirements and Product Limitations](#14-safety-requirements-and-product-limitations)
15. [Dependencies and External Services](#15-dependencies-and-external-services)
16. [Success Metrics and Key Performance Indicators (KPIs)](#16-success-metrics-and-key-performance-indicators-kpis)
17. [MVP Scope](#17-mvp-scope)
18. [Future Enhancements](#18-future-enhancements)
19. [Risks, Assumptions, and Mitigation Strategies](#19-risks-assumptions-and-mitigation-strategies)
20. [Release Acceptance Criteria](#20-release-acceptance-criteria)
21. [Pre-Implementation Decisions & Open Questions](#21-pre-implementation-decisions--open-questions)

---

## 1. Executive Summary

VisionMate AI is a voice-first, accessible mobile assistive platform engineered to empower blind and low-vision (BLV) individuals to navigate their physical surroundings, read printed and digital text, access information, and maintain social connectivity with autonomy and dignity.

Built natively on Flutter and Dart targeting Android first (with an intentional architecture enabling subsequent iOS deployment), VisionMate AI combines low-latency conversational speech interaction, on-device optical character recognition (OCR), multimodal generative AI scene interpretation, pedestrian-oriented navigational guidance, ambient utilities (curated news and music), and emergency trusted-contact connectivity.

Unlike conventional mobile apps where accessibility is retrofitted as a secondary compliance task, VisionMate AI treats accessibility as the baseline architectural foundation. Every visual element is paired with non-visual sensory affordances: earcons (auditory icons), customized haptic signatures, TalkBack-first focus navigation, and uninterrupted voice command routing with barge-in support.

---

## 2. Problem Statement

Over 2.2 billion people globally live with near or distance vision impairment (World Health Organization). In their daily lives, blind and low-vision users face critical barriers to personal autonomy:

1. **Information Isolation:** Printed text on mail, medicine bottles, food packaging, appliance dials, and street signs is inaccessible without sighted assistance or cumbersome, single-purpose scanning tools.
2. **Environmental Disorientation:** Navigating unfamiliar outdoor and indoor environments requires significant cognitive bandwidth. Mainstream GPS applications are designed for drivers or sighted pedestrians and fail to provide tactile or clock-face landmark cues (e.g., "Doorway at your 2 o'clock").
3. **App Fragmentation and High Cognitive Friction:** Users currently juggle 4–6 disparate apps for daily living (e.g., Be My Eyes, Seeing AI, Google Lookout, Google Maps, Voice Access, Audio Players). Switching between complex, multi-touch visual interfaces with screen readers introduces high cognitive load, navigation fatigue, and input errors.
4. **Safety and Anxiety in Transit:** Commuting alone exposes BLV users to disorientation, unexpected path obstructions, and communication isolation during emergencies or when immediate remote sighted help is needed.

---

## 3. Product Vision and Objectives

### 3.1 Product Vision
To create the world's most dependable, intuitive, and dignified voice-first mobile companion for blind and low-vision individuals—providing instant situational awareness, environmental literacy, and effortless utility through sound, voice, and touch.

### 3.2 Product Objectives
* **Deliver True Hands-Free & Low-Touch Utility:** Enable users to perform core visual tasks (reading text, inspecting scenes, checking directions) within 2 vocal or tactile interactions.
* **Guarantee Blazing-Fast Local OCR:** Deliver on-device text recognition with sub-second auditory response to enable continuous reading of documents, signs, and labels without cloud dependency.
* **Uncompromising Accessibility Standards:** Achieve 100% compliance with WCAG 2.2 Level AA/AAA mobile criteria, full compatibility with Android TalkBack, and complete usability with the screen turned off (Battery Saver / Screen Curtain mode).
* **Clear Safety Boundaries:** Transparently convey system confidence, latency bounds, and environmental limitations without giving users a false sense of obstacle-detection immunity.

---

## 4. Target Users and User Personas

> **Important Note on Research Validation:**  
> The personas below represent initial synthesized target archetypes based on industry-standard assistive technology workflows. All pain points, motor preferences, and cognitive load assumptions **must be validated** through direct participatory research and usability testing with blind and low-vision cohorts during the alpha phase.

```
+-----------------------------------------------------------------------------------------------------+
|                                      USER PERSONAS MATRIX                                           |
+-------------------+--------------------------------+------------------------------------------------+
| Persona           | Visual Condition               | Primary Need                                   |
+-------------------+--------------------------------+------------------------------------------------+
| Arthur (62)       | Total Blindness (Retinitis     | Voice-driven mail/medicine reading, reliable   |
| Retired Teacher   | Pigmentosa), Experienced Cane  | pedestrian turn-by-turn navigation with        |
|                   | User, Expert TalkBack User     | clock-face orientations.                       |
+-------------------+--------------------------------+------------------------------------------------+
| Priya (28)        | Low Vision (Stargardt Disease) | High-contrast visual feeds, quick camera text  |
| Software QA       | Significant Central Vision Loss| capture, instant news summaries, hands-free    |
|                   | Retains Peripheral Vision      | music controls while commuting.                |
+-------------------+--------------------------------+------------------------------------------------+
| Marcus (19)       | Recent Vision Loss (Trauma)    | Low cognitive burden, simple tactile gestures, |
| College Student   | Novice Screen Reader User,     | trusted-contact one-touch emergency calling,   |
|                   | High Anxiety in Transit        | reassuring scene descriptions.                 |
+-------------------+--------------------------------+------------------------------------------------+
```

### Persona 1: Arthur — The Totally Blind Independent Commuter
* **Demographics:** 62 years old, retired educator, totally blind for 15 years.
* **Assistive Tech Proficiency:** High; uses a primary white cane and Android TalkBack daily.
* **Daily Workflow:** Walks to local grocery stores, reads paper mail, checks bus schedules, listens to news.
* **Frustrations:** Apps that require visual targeting without auditory aiming cues; slow cloud processing that freezes his screen reader; mainstream navigation apps that say "Head northeast" instead of relative orientations.

### Persona 2: Priya — The Low-Vision Professional
* **Demographics:** 28 years old, accessibility QA engineer, diagnosed with Stargardt disease.
* **Assistive Tech Proficiency:** Moderate-to-high; uses large typography, high contrast, inverted colors, and occasionally TalkBack.
* **Daily Workflow:** Navigating office buildings, reading printed packaging/menus, rapid audio skimming of articles.
* **Frustrations:** Apps with fixed micro-fonts, low-contrast buttons, white backgrounds that cause glare/photophobia, and voice assistants that interrupt or talk too slowly.

### Persona 3: Marcus — The Newly Impaired Learner
* **Demographics:** 19 years old, university student, experienced severe sight loss 8 months ago.
* **Assistive Tech Proficiency:** Low; finds TalkBack gestures complex and intimidating; relies heavily on natural conversational voice.
* **Daily Workflow:** Finding classrooms, identifying objects in his dorm room, feeling secure when traveling alone.
* **Frustrations:** Fear of missing obstacles, getting lost on crosswalks, complicated multi-step menus.

---

## 5. User Needs and Pain Points

```
+-------------------------------------------------------------------------------------------------------+
| User Need                  | Current Industry Pain Point               | VisionMate AI Architectural Fix|
+----------------------------+-------------------------------------------+--------------------------------+
| Fast Text Scanning         | Cloud roundtrip latency (2-5s); requires  | On-device ML Kit OCR with real-|
|                            | continuous Internet connectivity.         | time audio feedback loop (<1s).|
+----------------------------+-------------------------------------------+--------------------------------+
| Environmental Awareness    | Pure GPS lacks micro-orientation; misses  | Relative clock-face guidance & |
|                            | elevation, stairs, and door positions.    | multimodal visual Q&A.         |
+----------------------------+-------------------------------------------+--------------------------------+
| Non-Visual Control         | Touchscreen interfaces assume visual eye- | Voice-first dialog + full-     |
|                            | hand coordination.                        | screen tactile macro gestures. |
+----------------------------+-------------------------------------------+--------------------------------+
| Battery & Thermal Comfort  | Continuous camera + neural models cause   | Hybrid edge-cloud triggering;  |
|                            | device overheating and battery drain.     | Screen Curtain / OLED black mode|
+----------------------------+-------------------------------------------+--------------------------------+
| Cognitive Predictability   | Screen readers clash with in-app audio;   | Strict Audio Focus ducking and |
|                            | unpredictable latency breeds anxiety.     | distinct earcon status cues.   |
+----------------------------+-------------------------------------------+--------------------------------+
```

---

## 6. Product Goals and Non-Goals

### 6.1 Product Goals
* **G-001 (Speed):** Deliver real-time, on-device OCR reading with initial speech output within 800 milliseconds of camera frame capture.
* **G-002 (Voice-First Ergonomics):** Allow 100% of core application workflows (reading, navigation, scene query, calling, news) to be initiated and completed via conversational voice commands or single-finger tactile macro-gestures.
* **G-003 (System Harmony):** Respect OS-level accessibility features (TalkBack) and audio focus rules, ensuring the app never speaks over system accessibility announcements or emergency alerts.
* **G-004 (Graceful Degradation):** Ensure critical functionality (OCR text reading, saved contacts, offline cached navigation routes) operates when network connectivity is lost.
* **G-005 (Cognitive Safety):** Establish explicit auditory confidence indicators and disclaimers to prevent over-reliance on AI outputs in high-risk physical scenarios.

### 6.2 Product Non-Goals
* **NG-001 (Not an Obstacle Avoidance System):** VisionMate AI is **not** a replacement for a primary mobility tool (white cane, guide dog, or electronic travel aid). It will **not** guarantee real-time hazard/puddle/drop-off/vehicle avoidance.
* **NG-002 (Not a Medical Diagnostic Device):** The app will not provide prescription verification, medical diagnoses, or definitive dosage validation from medicine labels.
* **NG-003 (Not an Autonomous Driving / Cycling Tool):** Navigation is strictly calibrated for pedestrian walking speeds (< 6 km/h) and will not support high-speed transit tracking.
* **NG-004 (Not a Monolithic Social Network):** VisionMate AI will not build proprietary social feeds, messaging walls, or user-to-user community boards; it relies on standard phone calls and OS-level communication tools.
* **NG-005 (No In-App Proprietary Music Streaming Service):** VisionMate AI will integrate with established third-party services (e.g., Spotify, YouTube Music via OS intents / APIs) rather than hosting music streaming infrastructure.

---

## 7. Functional Requirements

### 7.1 Core Voice Interaction & Conversational Engine (VCE)

| Req ID | Feature Name | Description | Priority |
| :--- | :--- | :--- | :--- |
| **FR-001** | Wake Word & Tactile Push-to-Talk (PTT) | The system shall support both a configurable wake phrase ("Hey VisionMate") and a low-friction tactile trigger (hardware volume key double-press or full-screen single-tap hold) to initiate listening. | **Must Have (MVP)** |
| **FR-002** | Speech-to-Text (STT) Processing | The system shall transcribe user vocal commands with an on-device/hybrid STT engine supporting English at launch, with automatic speech endpoint detection (VAD). | **Must Have (MVP)** |
| **FR-003** | Conversational Intent Parsing & NLU | The system shall map user utterances to application intents (e.g., `READ_TEXT`, `DESCRIBE_SCENE`, `NAVIGATE_TO`, `CALL_CONTACT`, `READ_NEWS`, `PLAY_MUSIC`, `CHANGE_SETTINGS`). | **Must Have (MVP)** |
| **FR-004** | Spoken Dialogue Barge-In | The user shall be able to interrupt (barge-in on) any active TTS speech output at any time by speaking a command or tapping the screen once with two fingers. | **Must Have (MVP)** |
| **FR-005** | Ambiguity Clarification Dialogue | If a voice command is ambiguous (e.g., "Call John" when two contacts exist), the system shall prompt a spoken disambiguation question rather than failing or selecting arbitrarily. | **Should Have** |
| **FR-006** | Multilingual Voice Support | The system shall support localized voice recognition and responses for Spanish, French, German, and Hindi in addition to English. | **Could Have (V2)** |

### 7.2 Text-to-Speech (TTS) & Auditory Earcon System (TTS)

| Req ID | Feature Name | Description | Priority |
| :--- | :--- | :--- | :--- |
| **FR-007** | High-Fidelity TTS Playback | The system shall render all vocal responses using low-latency, naturalistic speech synthesis with configurable pitch, volume, and speech rate (0.5x to 3.5x). | **Must Have (MVP)** |
| **FR-008** | Specialized Auditory Earcon Soundscape | The system shall play distinctive, non-speech auditory cues (earcons) for: Listening Started, Processing Query, Success, Error/Warning, Camera Aligned, and Text Detected. | **Must Have (MVP)** |
| **FR-009** | Dual-Stream Audio Focus Management | The system shall correctly duck or pause ambient audio (music, radio) when executing speech output or listening to voice inputs, adhering strictly to Android `AudioFocusRequest`. | **Must Have (MVP)** |
| **FR-010** | Continuous Text Reading Controls | While reading long text, the user shall be able to vocalize commands: "Pause", "Resume", "Repeat sentence", "Next paragraph", "Read faster", or "Stop". | **Must Have (MVP)** |

### 7.3 Camera-Based Optical Character Recognition (OCR)

| Req ID | Feature Name | Description | Priority |
| :--- | :--- | :--- | :--- |
| **FR-011** | Live Stream Text Recognition (Instant Mode) | The system shall continuously analyze camera frames using on-device ML Kit OCR and immediately speak detected short text snippets (street signs, room numbers, labels). | **Must Have (MVP)** |
| **FR-012** | Audio-Guided Document Aiming Assistant | When reading full documents (letters, menus), the system shall provide spoken alignment feedback (e.g., "Move camera up", "Rotate right", "Hold steady") based on edge detection. | **Should Have (MVP+)** |
| **FR-013** | High-Resolution Document Capture & Read | Upon user command ("Read document"), the system shall capture a high-res still image, process layout analysis, order text columns logically, and read the entire page sequentially. | **Must Have (MVP)** |
| **FR-014** | Offline OCR Operation | Text recognition in Instant Mode and Document Capture shall function 100% offline without requiring cellular or Wi-Fi data. | **Must Have (MVP)** |
| **FR-015** | Handwriting & Currency Recognition | The system shall detect handwritten notes and currency denominations from camera frames. | **Could Have (V2)** |

### 7.4 Multimodal Scene Understanding & Visual Q&A (AI-SCENE)

| Req ID | Feature Name | Description | Priority |
| :--- | :--- | :--- | :--- |
| **FR-016** | Snapshot Scene Description | On voice command ("Describe what's in front of me"), the system shall capture a still frame and generate a concise 2-sentence situational summary using a multimodal vision model. | **Must Have (MVP)** |
| **FR-017** | Interactive Conversational Follow-Up | Following a scene description, the user shall be able to ask contextual questions (e.g., "Where is my coffee mug?", "What color is the shirt on the left?"). | **Should Have (MVP+)** |
| **FR-018** | Spatial Object Localization Cues | Scene descriptions shall include relative spatial orientation using clock-face positions (e.g., "A doorway at your 11 o'clock, approximately 3 meters away"). | **Should Have** |
| **FR-019** | Continuous Video Stream Narration | The system shall dynamically narrate changing visual scenes in real-time over a continuous video feed with adaptive rate limiting. | **Won't Have (V1)** |

### 7.5 Destination Search & Pedestrian Walking Navigation (NAV)

| Req ID | Feature Name | Description | Priority |
| :--- | :--- | :--- | :--- |
| **FR-020** | Spoken Voice Destination Search | The user shall search for addresses, points of interest, or saved locations using natural speech (e.g., "Navigate to 452 Elm Street" or "Find nearest pharmacy"). | **Should Have** |
| **FR-021** | Pedestrian Turn-by-Turn Audio Routing | The system shall provide spoken walking instructions utilizing relative direction cues ("Turn slightly left in 20 meters onto Market Street") rather than cardinal compass terms. | **Should Have** |
| **FR-022** | Off-Route Recalculation & Audio Alert | The system shall detect when the pedestrian has deviated > 15 meters from the walking path, trigger a distinct haptic/earcon alert, and recalculate immediately. | **Should Have** |
| **FR-023** | Saved Favorite Waypoints | Users shall be able to save frequent locations via voice ("Save current location as Home", "Navigate to Work"). | **Should Have** |
| **FR-024** | Transit & Indoor Beacon Integration | Spoken guidance for indoor subways, escalators, and Bluetooth low-energy (BLE) building beacons. | **Could Have (V2)** |

### 7.6 Ambient Information: News & Media Utility (UTIL)

| Req ID | Feature Name | Description | Priority |
| :--- | :--- | :--- | :--- |
| **FR-025** | Curated Voice News Reader | The system shall fetch top headlines from verified RSS/news feeds and read 60-second synthesized summaries upon voice request ("Read today's news"). | **Could Have** |
| **FR-026** | News Category Filtering | Users shall be able to filter news via voice command by category ("World", "Technology", "Local", "Sports"). | **Could Have** |
| **FR-027** | Music Service Intent Integration | The system shall launch and control external music playback (Spotify/YouTube Music/Default Player) via OS voice intents ("Play jazz on Spotify", "Pause music"). | **Could Have** |

### 7.7 Trusted Contacts & Calling Assistance (COMMS)

| Req ID | Feature Name | Description | Priority |
| :--- | :--- | :--- | :--- |
| **FR-028** | Voice-Initiated Phone Dialing | The system shall dial phone numbers or contact names from the user's phonebook upon spoken command ("Call daughter Sarah"). | **Must Have (MVP)** |
| **FR-029** | Dedicated Emergency SOS Trigger | A rapid triple-tap gesture or emergency vocal phrase ("VisionMate Emergency") shall immediately place a phone call and send an SMS with current GPS coordinates to a designated Trusted Contact. | **Must Have (MVP)** |
| **FR-030** | Remote Sighted Video Link (WebRTC / Third-Party) | One-touch live video sharing with a pre-configured trusted contact for remote visual assistance. | **Won't Have (V1)** |

### 7.8 Accessibility Settings & System Customization (SET)

| Req ID | Feature Name | Description | Priority |
| :--- | :--- | :--- | :--- |
| **FR-031** | Vocal Speech-Rate Configuration | Users shall adjust TTS speech rate dynamically via voice ("Set speech rate to 2x") or through an accessible stepped slider. | **Must Have (MVP)** |
| **FR-032** | Screen Curtain (Privacy & Battery Shield) | Users shall be able to toggle a black OLED screen curtain on/off via triple-tap, allowing full application usage while saving battery and protecting visual privacy. | **Must Have (MVP)** |
| **FR-033** | High-Contrast Low-Vision UI Theme | The visual UI shall provide high-contrast color palettes (pure black background `#000000`, bright yellow text `#FFD700`, or bright cyan `#00FFFF`) meeting WCAG AAA. | **Must Have (MVP)** |
| **FR-034** | Haptic Feedback Customizer | Users can toggle and scale the intensity of tactile vibration patterns corresponding to earcons and system events. | **Must Have (MVP)** |

---

## 8. Non-Functional Requirements

### 8.1 Performance and Latency (NFR-PERF)

```
+-------------------------------------------------------------------------------------------------------+
| Identifier | Metric / Constraint                           | Target Threshold                         |
+------------+-----------------------------------------------+------------------------------------------+
| NFR-001    | Local Instant OCR Time-to-Speech              | <= 800 ms from frame capture             |
| NFR-002    | Wake Word / Push-to-Talk Activation Latency   | <= 200 ms to audio listening cue         |
| NFR-003    | Speech-to-Intent Resolution (Local)           | <= 600 ms post-speech silence            |
| NFR-004    | Cloud AI Scene Description Response           | <= 3.5 seconds on 4G / 5G / Wi-Fi        |
| NFR-005    | Cold App Launch to Interactive State          | <= 1.8 seconds on standard Android device|
| NFR-006    | Frame Rate in Active Camera Guidance Modes    | Stable 30 FPS without frame drop         |
+-------------------------------------------------------------------------------------------------------+
```

### 8.2 Battery, Memory, and Thermal Constraints (NFR-HW)

* **NFR-007 (Battery Consumption):** Continuous camera-assisted OCR reading shall consume no more than 12% device battery per 60 minutes of active use. In audio-only navigation or idle voice standby, consumption must not exceed 4% per hour.
* **NFR-008 (Thermal Throttling Guard):** The app must continuously monitor device thermal status via Android thermal APIs. If temperature reaches severe levels, it must gracefully downsample camera frame rate from 30 FPS to 15 FPS and notify the user via a calm earcon and speech announcement.
* **NFR-009 (Memory Footprint):** Peak application memory (RAM) usage shall not exceed 350 MB during active on-device ML model execution.

### 8.3 Reliability, Availability, and Robustness (NFR-REL)

* **NFR-010 (Crash-Free Sessions):** The application shall maintain a >= 99.8% crash-free session rate across diverse Android OEM devices (Samsung, Google Pixel, Motorola, Xiaomi).
* **NFR-011 (Offline Core Fallback):** When network connectivity is lost (offline mode), the app must gracefully retain 100% of local features: Instant OCR, Document Reading, Trusted Contact Phone Dialing, and Voice Setting adjustments.
* **NFR-012 (Network Reconnection Recovery):** In-flight network requests (scene descriptions, navigation recalculations) that fail due to cellular dropouts must retry with exponential backoff (max 3 retries) before delivering a polite auditory error prompt.

### 8.4 Maintainability, Platform Portability & Architecture (NFR-ARCH)

* **NFR-013 (Architecture Layering):** The Flutter codebase shall strictly enforce Clean Architecture principles (Presentation, Domain, and Data layers) utilizing the BLoC (Business Logic Component) pattern for unidirectional state management.
* **NFR-014 (Cross-Platform Foundation):** All hardware abstraction layers (Camera, Audio I/O, Haptics, Sensors, GPS) must be implemented via platform interfaces to ensure zero-rewrite code reuse when targeting iOS in future iterations.
* **NFR-015 (Modularity):** AI model interfaces (ML Kit, Cloud Vision / Gemini) must use interchangeable repository patterns, allowing model swapping without altering business logic.

---

## 9. Feature Prioritization (MoSCoW Matrix)

To ensure rapid delivery of a rock-solid, production-grade assistive application, features are prioritized according to user safety, cognitive utility, and platform feasibility.

```
+-------------------------------------------------------------------------------------------------------+
|                                    MoSCoW PRIORITIZATION MATRIX                                       |
+-------------------------------------------------------------------------------------------------------+
| MUST HAVE (MVP Release)                                                                               |
| * Push-to-Talk & Wake Word Voice Command Loop (FR-001, FR-002, FR-003, FR-004)                        |
| * Low-Latency Text-to-Speech & Earcon Audio System (FR-007, FR-008, FR-009, FR-010)                   |
| * On-Device Live OCR & Document Reader (FR-011, FR-013, FR-014)                                       |
| * Basic Cloud AI Scene Description Snapshot (FR-016)                                                  |
| * Voice Contact Dialing & Emergency SOS Alerting (FR-028, FR-029)                                     |
| * Core Accessibility Suite: Screen Curtain, High Contrast, Speech Rate, Haptics (FR-031..FR-034)      |
| * Android TalkBack Compatibility & Semantic Labeling (AR-001..AR-008)                                 |
+-------------------------------------------------------------------------------------------------------+
| SHOULD HAVE (MVP+ / Release 1.1)                                                                      |
| * Audio-Guided Document Aiming Assistant (FR-012)                                                     |
| * Conversational Follow-Up Visual Q&A (FR-017)                                                        |
| * Spoken Pedestrian Walking Navigation & Clock-Face Guidance (FR-020, FR-021, FR-022, FR-023)           |
| * Ambiguity Clarification Dialogue (FR-005)                                                           |
+-------------------------------------------------------------------------------------------------------+
| COULD HAVE (Release 1.2 / Future Minor)                                                               |
| * Curated Voice News Reader & Category Filters (FR-025, FR-026)                                       |
| * Third-Party Music Service Control via OS Intents (FR-027)                                           |
| * Multilingual Speech & TTS Expansion (FR-006)                                                        |
| * Handwriting & Currency Identifier (FR-015)                                                          |
+-------------------------------------------------------------------------------------------------------+
| WON'T HAVE (Release 1.0 - Deferred to V2 / Advanced Hardware)                                         |
| * Continuous Video Stream Narration (FR-019)                                                          |
| * Remote Sighted Video Link (WebRTC) (FR-030)                                                         |
| * Indoor BLE Beacon Mesh Navigation (FR-024)                                                          |
| * Direct Hardware Smart-Glasses Camera Pairing                                                        |
+-------------------------------------------------------------------------------------------------------+
```

---

## 10. User Stories with Acceptance Criteria

### US-001: Instant On-Device Text Reading
* **As a** blind user sorting my physical paper mail,  
* **I want to** point my smartphone camera at the letters and hear the printed text spoken immediately,  
* **So that I can** independently identify sender names, billing amounts, and important documents without sighted help.

#### Acceptance Criteria (Gherkin Syntax)
```gherkin
Scenario: Successful real-time text recognition in Instant Mode
  Given VisionMate AI is in "Text Reading" mode
  And the device camera is pointed at a clear printed document with text >= 12pt font
  When text enters the camera viewport under adequate lighting (> 100 lux)
  Then the system shall trigger the "Text Detected" earcon within 300 ms
  And speak the recognized text stream via TTS within 800 ms of frame ingestion
  And the process shall operate completely without internet connection.

Scenario: Inadequate lighting detected during reading
  Given VisionMate AI is scanning text
  When the ambient sensor reports light levels < 20 lux
  Then the system shall automatically turn on the device camera LED flash
  And play a subtle "Flashlight Activated" earcon cue
  And continue scanning without interrupting the speech flow.
```

### US-002: Hands-Free Voice Control with Barge-In
* **As an** individual holding a cane in one hand and groceries in the other,  
* **I want to** speak commands naturally and interrupt the assistant whenever needed,  
* **So that I can** control the phone safely without fumbling for on-screen touch targets.

#### Acceptance Criteria
```gherkin
Scenario: Voice command execution via Push-to-Talk
  Given the phone is held in hand or hanging from a chest lanyard
  When the user double-presses either hardware Volume Key or holds the screen for 400 ms
  Then the device shall trigger a crisp 30 ms haptic pulse and play the "Listening" earcon
  And temporary background audio ducking (-80% volume) shall engage immediately
  When the user says "Read my document" and pauses for 500 ms
  Then the system shall acknowledge with the "Processing" earcon and launch Document Capture.

Scenario: User barge-in during long speech playback
  Given the system TTS is actively reciting a 3-paragraph letter
  When the user taps the screen once with two fingers OR speaks "VisionMate, Stop"
  Then the TTS playback shall terminate within 100 ms
  And the system shall emit a soft "Stopped" earcon and await the next command.
```

### US-003: Multimodal Scene Understanding with Spatial Cues
* **As a** visually impaired traveler entering an unfamiliar hotel lobby,  
* **I want to** capture a snapshot and receive a concise scene summary with clock-face directions,  
* **So that I can** orient myself toward the reception desk, seating area, or elevator doors.

#### Acceptance Criteria
```gherkin
Scenario: Scene description query with clock-face orientation
  Given the user triggers the command "Describe scene"
  When the camera captures a clear image of the room
  Then the system shall emit a periodic rhythmic "Thinking" earcon every 1.0 second
  And return an audio description within 3.5 seconds
  And the response text must include prominent landmarks with relative clock-face bearings
    (e.g., "Reception desk at your 12 o'clock, sofa seating at your 9 o'clock").

Scenario: Network unavailable during scene description request
  Given the device has no cellular or Wi-Fi connectivity
  When the user requests "Describe scene"
  Then the system shall immediately inform: "Scene description requires an internet connection. Text reading is still available offline."
  And play the designated "Feature Unavailable" earcon.
```

### US-004: Emergency Assistance & Trusted Contact Alerting
* **As a** visually impaired individual feeling disoriented or unsafe during a night walk,  
* **I want to** execute a discrete emergency command,  
* **So that my** trusted family member is dialed immediately and receives my precise location.

#### Acceptance Criteria
```gherkin
Scenario: SOS trigger via tactile macro gesture
  Given the phone is unlocked with VisionMate AI active or in background
  When the user taps the screen 3 times rapidly with two fingers
  Then the device shall vibrate with an intense emergency haptic pattern
  And play a distinctive 2-tone confirmation chime
  And initiate an outbound cellular voice call to the designated primary Trusted Contact
  And transmit an SMS with coordinates: "VisionMate Alert: [User Name] requested assistance. Location: https://maps.google.com/?q=LAT,LONG".
```

---

## 11. Primary Use Cases

### 11.1 Use Case UC-01: Processing Daily Physical Mail
* **Primary Actor:** Blind User.
* **Preconditions:** VisionMate AI installed; camera permissions granted; device running.
* **Triggers:** User picks up a stack of postal envelopes.
* **Main Success Scenario:**
  1. User triggers Push-to-Talk and states: *"Read mail"*.
  2. VisionMate AI confirms with *"Point your camera at the envelope"*.
  3. User holds the envelope 30 cm above the table.
  4. Instant OCR detects text and speaks: *"Sender: City Water Department. Notice of Account Balance."*
  5. User says: *"Capture document"*.
  6. Camera captures high-res image; system processes layout and begins reading line-by-line.
  7. User says: *"Pause"* when done reading the relevant amount.
* **Alternative Flows / Edge Cases:**
  * *Document Out of Frame:* System calculates that text boundaries clip the edge and speaks: *"Move camera back slightly to capture full page."*
  * *Blurry Capture:* System detects motion blur score > threshold, plays warning earcon, and prompts: *"Image blurry, please hold steady and retry."*

### 11.2 Use Case UC-02: Walking to a Local Destination
* **Primary Actor:** Low-Vision Pedestrian with White Cane.
* **Preconditions:** GPS location services enabled; destination pre-saved or spoken.
* **Main Success Scenario:**
  1. User presses PTT: *"Navigate to City Library"*.
  2. VisionMate AI resolves the address, confirms estimated walking time (*"12 minutes"*), and asks: *"Start walking?"*
  3. User says: *"Yes"*.
  4. App initiates pedestrian guidance. Phone is kept in shirt pocket or hand.
  5. As the user approaches an intersection, app speaks: *"In 15 meters, turn left onto 4th Avenue. Audible pedestrian signal present."*
  6. User follows sidewalk and successfully reaches the entrance.
* **Alternative Flows / Edge Cases:**
  * *Off-Route Deviation:* User accidentally turns down an alleyway. GPS detects 20-meter drift. System vibrates twice and says: *"Off route. Turn around and walk 20 meters back to Elm Street."*
  * *Weak GPS Signal (Urban Canyon):* System notifies: *"GPS accuracy low due to tall buildings. Rely strictly on your cane and physical landmarks."*

---

## 12. Accessibility Requirements (A11y Core)

Accessibility is the foundational constraint of VisionMate AI, not an add-on. The application must comply with **WCAG 2.2 Level AA and AAA (Mobile Applicable Criteria)** and adhere to Android Accessibility Design Standards.

```
+-------------------------------------------------------------------------------------------------------+
| Identifier | Accessibility Domain     | Mandatory Technical Requirement                               |
+------------+--------------------------+---------------------------------------------------------------+
| AR-001     | TalkBack Compatibility   | 100% of interactive widgets must have semantic Flutter        |
|            |                          | `Semantics()` wrappers with explicit labels, hints, and roles.|
+------------+--------------------------+---------------------------------------------------------------+
| AR-002     | Focus Traversal Order    | Logical top-to-bottom, left-to-right reading order without    |
|            |                          | focus traps. Hidden decorative images must have `excludeFrom- |
|            |                          | Semantics: true`.                                             |
+------------+--------------------------+---------------------------------------------------------------+
| AR-003     | Touch Target Size        | Every touch target must measure at least 48 x 48 dp           |
|            |                          | (Recommended 64 x 64 dp for major macro buttons).             |
+------------+--------------------------+---------------------------------------------------------------+
| AR-004     | Color Contrast & Modes   | Contrast ratio >= 7.0:1 (AAA level) for text against          |
|            |                          | background. Pure dark mode (`#000000`) enabled by default.    |
+------------+--------------------------+---------------------------------------------------------------+
| AR-005     | Dynamic Typography       | Full support for Android OS font scaling up to 200% without   |
|            |                          | text clipping, truncation, or layout overflow.                |
+------------+--------------------------+---------------------------------------------------------------+
| AR-006     | Non-Visual State Cues    | Every state change (loading, success, failure) must emit both |
|            |                          | an earcon audio chime AND a specialized haptic vibration.     |
+------------+--------------------------+---------------------------------------------------------------+
| AR-007     | Screen Curtain Mode      | Custom black overlay disabling all screen backlight/emissions |
|            |                          | while maintaining touch gesture response and audio feedback.  |
+------------+--------------------------+---------------------------------------------------------------+
| AR-008     | Screen Reader Dual-Mode  | App must intelligently cooperate with TalkBack: when user is   |
|            |                          | using internal voice commands, internal TTS ducks TalkBack    |
|            |                          | gracefully without muting critical system announcements.      |
+------------+--------------------------+---------------------------------------------------------------+
```

---

## 13. Privacy and Security Requirements

Visual and vocal assistive technologies handle intensely sensitive personal data: private mail, financial statements, medical prescriptions, real-time GPS locations, and home environments.

```
+-------------------------------------------------------------------------------------------------------+
| Identifier | Privacy / Security Domain| Mandatory Technical Requirement                               |
+------------+--------------------------+---------------------------------------------------------------+
| PSR-001    | Local Camera Processing  | Video frames analyzed during Instant OCR must be processed in |
|            |                          | volatile device RAM (framebuffer) and never saved to storage. |
+------------+--------------------------+---------------------------------------------------------------+
| PSR-002    | Cloud Vision Data Policy | Captured frames sent to Cloud Multimodal AI must be encrypted |
|            |                          | via TLS 1.3, stripped of user metadata, and deleted post-infer|
|            |                          | ence (Zero Data Retention agreement with AI provider).        |
+------------+--------------------------+---------------------------------------------------------------+
| PSR-003    | Voice Audio Recording    | Audio buffers for voice commands must be processed locally or  |
|            |                          | streamed via transient sockets. Never stored permanently.     |
+------------+--------------------------+---------------------------------------------------------------+
| PSR-004    | Trusted Contact Privacy  | Trusted contact names and phone numbers must be stored in     |
|            |                          | encrypted local storage (Android Keystore / EncryptedSharedPreferences)|
|            |                          | and never synced to external analytics or advertising servers.|
+------------+--------------------------+---------------------------------------------------------------+
| PSR-005    | Location Data Isolation  | GPS location is queried strictly for active navigation or SOS |
|            |                          | dispatch. No background location tracking or advertising SDKs.|
+------------+--------------------------+---------------------------------------------------------------+
| PSR-006    | Explicit Consent Onboard | First-launch wizard must feature an accessible, spoken audio  |
|            |                          | privacy agreement explaining camera, microphone, and data flow.|
+------------+--------------------------+---------------------------------------------------------------+
```

---

## 14. Safety Requirements and Product Limitations

> ### ⚠️ CRITICAL SAFETY MANDATE & LIABILITY DISCLAIMER
> VisionMate AI is an assistive informational application. It is **NOT** a certified medical device, safety system, or replacement for mobility aids. The following safety architecture must be embedded into the application code and user onboarding:

* **SR-001 (No Guarantee of Pedestrian Safety):** The app shall prominently issue an audible safety disclaimer upon first launch and route initialization:  
  *"VisionMate AI does not detect all obstacles, drop-offs, moving vehicles, or overhead hazards. Always use your white cane or guide dog."*
* **SR-002 (Prohibition of Obstacle Avoidance Claims):** The software shall **never** advertise, suggest, or imply real-time obstacle avoidance capabilities. Computer vision models running on standard single-lens smartphones cannot reliably judge depth, transparent glass doors, drop-offs (subway platform edges), or rapid approaching hazards.
* **SR-003 (Environmental Awareness Guard):** When walking navigation is active, the app shall periodically remind users to keep one ear unobstructed if wearing headphones, or encourage the use of bone-conduction headphones.
* **SR-004 (Confidence Thresholding & Refusal to Guess):** If a scene description or OCR model yields an inference confidence score below 65%, the system must not fabricate answers. It must explicitly state: *"I cannot read this clearly. Please adjust lighting or distance."*
* **SR-005 (Safety-Critical Medication Disclaimer):** If OCR detects medical packaging or prescription terms, the app will read the text verbatim but append an automatic vocal notice: *"Please verify prescription dosages with a healthcare professional or pharmacist."*

---

## 15. Dependencies and External Services

```
+-------------------------------------------------------------------------------------------------------+
| Domain / Component        | Selected Service / SDK / Engine          | Rationale & Fallback           |
+---------------------------+------------------------------------------+--------------------------------+
| Mobile Framework          | Flutter SDK (3.x) & Dart (3.x)           | Cross-platform clean code; high|
|                           |                                          | performance reactive UI.       |
+---------------------------+------------------------------------------+--------------------------------+
| On-Device OCR             | Google ML Kit Text Recognition           | High-accuracy, offline-capable,|
|                           | (v2 on-device engine)                    | zero latency cost, privacy safe|
+---------------------------+------------------------------------------+--------------------------------+
| Speech-to-Text (STT)      | Android Native SpeechRecognizer API      | Low latency, native OS voice   |
|                           | with Whisper on-device fallback (V2)     | integration, multi-language.   |
+---------------------------+------------------------------------------+--------------------------------+
| Text-to-Speech (TTS)      | Google Text-to-Speech Engine             | High intelligibility, adjustable|
|                           | via `flutter_tts` plugin                 | speech rates (up to 3.5x).     |
+---------------------------+------------------------------------------+--------------------------------+
| Multimodal AI Vision      | Gemini 1.5 Flash API / Cloud Vision API  | Sub-second cloud inference,    |
|                           | via secure proxy endpoint                | strong multimodal reasoning.   |
+---------------------------+------------------------------------------+--------------------------------+
| Mapping & Geocoding       | Mapbox Navigation SDK / Google Maps SDK  | Pedestrian walking profiles,   |
|                           | & OpenStreetMap pedestrian routing       | reliable pedestrian sidewalk data|
+---------------------------+------------------------------------------+--------------------------------+
| Audio & Haptics Engine    | `audioplayers` + `vibration` / native    | Low-latency earcon soundscapes |
|                           | Android HapticFeedbackConstants          | and customizable vibrations.   |
+---------------------------+------------------------------------------+--------------------------------+
| News Content Delivery     | Curated Open RSS feeds (NPR, BBC, AP)    | Plaintext feeds, no login/auth |
|                           | parsed via lightweight cloud worker      | required, high reliability.    |
+---------------------------+------------------------------------------+--------------------------------+
| Telecom / Emergency Dial  | `url_launcher` (tel:, sms:) & Android    | Native OS telephony dispatch;  |
|                           | TelephonyManager framework               | zero external VoIP dependency. |
+-------------------------------------------------------------------------------------------------------+
```

---

## 16. Success Metrics and Key Performance Indicators (KPIs)

To evaluate product efficacy, accessibility compliance, and user satisfaction, the following metrics will be tracked:

```
+-------------------------------------------------------------------------------------------------------+
| Metric Category    | Specific Indicator               | Target Baseline (MVP)   | Stretch Goal (V1.0) |
+--------------------+----------------------------------+-------------------------+---------------------+
| Task Completion    | Mail / Document Reading Success  | >= 90% completion       | >= 96% completion   |
|                    | Destination Navigation Arrival   | >= 85% without wrong turn| >= 92% arrival     |
|                    | Voice Command Intent Accuracy    | >= 92% accurate parsing | >= 98% accurate     |
+--------------------+----------------------------------+-------------------------+---------------------+
| Speed & Efficiency | Time to Read First Text Snippet  | <= 1.2 seconds          | <= 800 milliseconds |
|                    | Scene Description End-to-End Latency| <= 4.0 seconds       | <= 2.8 seconds      |
|                    | Emergency SOS Trigger Execution  | <= 2.0 seconds to dial  | <= 1.0 second       |
+--------------------+----------------------------------+-------------------------+---------------------+
| Stability & Tech   | Crash-Free User Sessions         | >= 99.5%                | >= 99.9%            |
|                    | Memory Leak Occurrence           | 0 persistent leaks      | 0 persistent leaks  |
|                    | Unhandled Exception Rate         | < 0.2% of sessions      | < 0.05% of sessions |
+--------------------+----------------------------------+-------------------------+---------------------+
| User Adoption      | Day-7 User Retention (D7)        | >= 45%                  | >= 60%              |
| & Satisfaction     | System Usability Scale (SUS)     | >= 80 (Grade A)         | >= 88 (Grade A+)    |
|                    | Accessibility Community Rating   | 4.6 / 5.0 stars         | 4.9 / 5.0 stars     |
+-------------------------------------------------------------------------------------------------------+
```

---

## 17. MVP Scope

The Minimum Viable Product (MVP) focuses exclusively on high-frequency survival and independence utilities, stripping away extraneous tertiary features to deliver an exceptionally polished, crash-proof core.

```
+-------------------------------------------------------------------------------------------------------+
|                                        MVP SCOPE BOUNDARY                                             |
+-----------------------------------------+-------------------------------------------------------------+
| INCLUDED IN MVP (Release 1.0)           | DEFERRED TO POST-MVP (Phase 2 & 3)                          |
+-----------------------------------------+-------------------------------------------------------------+
| 1. Push-to-Talk Voice Command Engine    | 1. Real-time Video Stream continuous narration              |
| 2. High-speed On-Device OCR (Instant)   | 2. Turn-by-Turn GPS Pedestrian Navigation                   |
| 3. High-Res Document Capture & Reading  | 3. Curated News Audio Reader & Summaries                    |
| 4. Cloud Snapshot Scene Description     | 4. Music Streaming Integration (Spotify/Apple Music)        |
| 5. Emergency SOS & Trusted Calling      | 5. Handwriting, Currency, and Barcode Recognition           |
| 6. Screen Curtain & High-Contrast Modes | 6. Multilingual translations beyond English                 |
| 7. Speech Rate & Pitch Customizer       | 7. Smart Glasses hardware accessory pairing                 |
| 8. Full TalkBack Semantic Accessibility | 8. Remote Sighted Volunteer video bridge (Be My Eyes style) |
+-----------------------------------------+-------------------------------------------------------------+
```

---

## 18. Future Enhancements

### 18.1 Phase 2: Mobility & Contextual Ambient Utilities (Q2–Q3)
* **Integrated Sidewalk Navigation:** Mapbox-powered walking routes with crosswalk warnings, step counts, and compass-calibrated clock-face orientations.
* **Barcode & Smart Packaging Identifier:** Direct scanning of UPC barcodes and Accessible QR codes (NaviLens) to read food ingredients and allergens.
* **Audio News & Entertainment Hub:** Hands-free voice browsing of RSS news feeds, podcast episodes, and Spotify playback controls.

### 18.2 Phase 3: Wearable AI & Spatial Computing (Q4+)
* **Smart Glasses Integration (Camera-on-Head):** Bluetooth streaming from lightweight camera frames (e.g., Ray-Ban Meta or open-source wearable cameras) eliminating the need to hold a smartphone.
* **Sub-Meter Indoor Localization:** Visual Inertial Odometry (VIO) and BLE beacon trilateration for navigating inside shopping centers, hospitals, and train stations.
* **Collaborative Sighted Video Assistance:** WebRTC one-way video, two-way audio encrypted video link connecting users directly to family members or trained sighted agents.

---

## 19. Risks, Assumptions, and Mitigation Strategies

### 19.1 Unvalidated Assumptions Requiring User Cohort Testing

> **Attention Research Team:**  
> The following assumptions are currently hypothetical and must be prioritized for empirical validation in early usability sessions with blind and low-vision participants:

1. **Assumption A-01:** *Users prefer a physical hardware key trigger (Volume Key double-tap) over an always-listening wake word ("Hey VisionMate").*  
   *Test Goal:* Measure false-activation rate and motor comfort across 15 participants using canes or guide dogs.
2. **Assumption A-02:** *Users can orient their phone camera toward target documents using only audio alignment cues without sighted intervention.*  
   *Test Goal:* Evaluate whether audio earcon pitch/frequency feedback enables total capture of a standard 8.5x11 page within 3 attempts.
3. **Assumption A-03:** *Clock-face landmark terminology ("Door at 2 o'clock") is more intuitive in mobile pedestrian guidance than distance/heading measurements ("Turn right in 30 feet").*  
   *Test Goal:* Conduct walking trials comparing cognitive disorientation rates between both cue models.

### 19.2 Technical, Safety, and Operational Risks Matrix

```
+-------------------------------------------------------------------------------------------------------+
| Identifier | Risk Description        | Impact | Prob. | Proactive Mitigation Strategy                 |
+------------+-------------------------+--------+-------+-----------------------------------------------+
| R-001      | Device Overheating      | HIGH   | MED   | Implement dynamic frame-rate governor; limit  |
|            | during extended camera  |        |       | OCR continuous analysis to 10 FPS when motion |
|            | and neural processing.  |        |       | is static; auto-activate thermal throttling.  |
+------------+-------------------------+--------+-------+-----------------------------------------------+
| R-002      | Accidental Emergency    | HIGH   | MED   | Require a 2-second cancel confirmation window |
|            | SOS False Alarms.       |        |       | with audible countdown ("Calling in 3... 2..1"|
|            |                         |        |       | with single-tap cancel).                      |
+------------+-------------------------+--------+-------+-----------------------------------------------+
| R-003      | User Reliance on Scene  | CRIT-  | MED   | Enforce mandatory audio disclaimers; display  |
|            | AI in Dangerous Traffic | ICAL   |       | explicit warnings; suppress walking guidance  |
|            | or Crosswalks.          |        |       | if GPS velocity indicates vehicular speeds.   |
+------------+-------------------------+--------+-------+-----------------------------------------------+
| R-004      | High Cloud Inference    | MED    | HIGH  | Cache frequent queries; throttle snapshot AI  |
|            | Costs (Gemini/Vision).  |        |       | requests to max 1 per 3 seconds; encourage    |
|            |                         |        |       | on-device local OCR wherever possible.        |
+------------+-------------------------+--------+-------+-----------------------------------------------+
| R-005      | TalkBack Audio Collision| HIGH   | HIGH  | Architect strict Android AudioFocus hooks;    |
|            | (Speech overlapping     |        |       | silence internal TTS whenever TalkBack issues |
|            | system screen reader).  |        |       | accessibility focus announcements.            |
+-------------------------------------------------------------------------------------------------------+
```

---

## 20. Release Acceptance Criteria

Before any candidate build is certified for production deployment to the Google Play Store (Internal / Closed Testing track), it must strictly pass the following quality gates:

### 20.1 Accessibility & Usability Gates
* [ ] **Gate A1:** Zero unresolved TalkBack focus traps or unlabelled interactive widgets across all screens.
* [ ] **Gate A2:** 100% of core flows (Instant Reading, Document Capture, Scene Query, SOS Call) successfully executed by 3 independent blind test participants using voice and touch alone.
* [ ] **Gate A3:** High-contrast theme passes automated contrast checks (all text elements >= 7:1 against background).

### 20.2 Latency & Performance Gates
* [ ] **Gate P1:** On-device OCR processes camera frames and emits speech output within <= 800 ms on mid-range Android test device (Google Pixel 6a / Samsung Galaxy A54).
* [ ] **Gate P2:** Wake word / PTT audio response cue initiates within <= 200 ms.
* [ ] **Gate P3:** Peak memory consumption remains <= 350 MB over 30 minutes of continuous scanning.

### 20.3 Safety & Reliability Gates
* [ ] **Gate S1:** Crash-free sessions >= 99.8% over minimum 500 test sessions.
* [ ] **Gate S2:** Emergency SOS trigger reliably dials the configured phone number and dispatches SMS location in 10 out of 10 test trials.
* [ ] **Gate S3:** First-launch safety disclaimer cannot be skipped without explicit user voice or tactile confirmation.

---

## 21. Pre-Implementation Decisions & Open Questions

The following critical product, engineering, and UX questions are currently unresolved and require stakeholder sign-off prior to beginning sprint execution:

### 21.1 Architectural & Technical Decisions Needed
1. **Wake-Word Engine Selection (Always-Listening vs. Hardware Trigger):**  
   *Decision:* Do we license a specialized low-power edge wake-word engine (e.g., Porcupine / Picovoice) for "Hey VisionMate", or rely strictly on hardware volume-button triggers for MVP?  
   *Trade-off:* Continuous microphone listening drains battery and requires complex Android background service permissions; hardware button triggers are 100% reliable and battery-friendly but require physical hand interaction.
2. **Multimodal Cloud Vision Provider & Cost Quotas:**  
   *Decision:* Which AI backend will serve Scene Descriptions (Google Gemini 1.5 Flash vs. OpenAI GPT-4o mini vs. Anthropic Claude 3.5 Haiku)?  
   *Trade-off:* Need to benchmark latency vs. cost per 1,000 queries and ensure the provider adheres to Zero Data Retention for sensitive imagery.
3. **Audio Architecture (Dual-Player vs System TTS):**  
   *Decision:* Should VisionMate AI use the operating system's native TTS engine (via `flutter_tts`) or bundle a neural on-device voice engine (e.g., Sherpa-ONNX / Piper)?  
   *Trade-off:* Native TTS is lightweight and respects user's preferred TalkBack voice; neural engines sound significantly more natural but add ~40 MB to the app download size.

### 21.2 Product & UX Decisions Needed
4. **Emergency SOS Legal & False-Trigger Strategy:**  
   *Decision:* Should the SOS feature be enabled by default, or require an explicit setup flow where the user designates a verified trusted contact?  
   *Recommendation:* Require explicit contact verification during onboarding to prevent dialing unconfigured or invalid numbers.
5. **Screen Curtain Activation UX:**  
   *Decision:* What is the fail-safe gesture to reveal the screen if a user accidentally activates Screen Curtain and forgets the gesture?  
   *Recommendation:* A hardware key chord (holding Volume Up + Volume Down for 3 seconds) must reliably reset the screen curtain.
6. **Navigation Mapping Provider Licensing:**  
   *Decision:* For Phase 2 navigation, do we utilize Mapbox Navigation SDK (commercial licensing per monthly active user) or build a custom solution over OpenStreetMap / Google Directions?  
   *Trade-off:* Mapbox provides superior turn-by-turn voice guidance events out-of-the-box, but introduces ongoing subscription overhead.

---
*End of Product Requirements Document.*  
*Next Stage: Technical Architecture Design Document (TADD) & Participatory User Testing Protocol.*
