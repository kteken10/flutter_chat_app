# Flutter Chat App

<p align="center"><img src="docs/banner.png" alt="Flutter Chat App: real-time chat built with Flutter and Firebase" width="100%"></p>

![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?logo=firebase&logoColor=black)
![Platforms](https://img.shields.io/badge/platforms-Android%20%7C%20iOS-0A2540)

A chat app built with Flutter and Firebase: sign in, find people and chat in real time.

## Screens

<p align="center"><img src="docs/tour.gif" width="260" alt="Tour of the app: sign in, discussions, conversation"></p>

| Sign in | Discussions | Conversation |
|:---:|:---:|:---:|
| <img src="docs/screens/sign-in.png" width="160" alt="Sign in screen"> | <img src="docs/screens/discussions.png" width="160" alt="Discussions screen"> | <img src="docs/screens/conversation.png" width="160" alt="Conversation screen"> |

## Features

- **Authentication**: sign up and sign in with Firebase Authentication; profiles stored in Cloud Firestore.
- **People**: users listed from Firestore.
- **Discussions**: conversation list with search.
- **Conversation**: chat bubbles, messages streamed from Firestore in real time.
- **Navigation**: bottom bar with discussions, people, stories, calls and settings.

## Tech stack

- Flutter, Dart, Provider
- Firebase: Authentication, Cloud Firestore
- [chat_bubbles](https://pub.dev/packages/chat_bubbles), [persistent_bottom_nav_bar](https://pub.dev/packages/persistent_bottom_nav_bar), [flutter_animate](https://pub.dev/packages/flutter_animate), [iconsax](https://pub.dev/packages/iconsax)

```
lib/
├── core/               theme
├── data/
│   ├── models/
│   ├── providers/
│   └── repositories/   auth and users (Firestore)
├── presentation/
│   ├── navigation/
│   ├── screens/        auth, discussion, peoples, stories, call, settings
│   └── widget/, ui/
├── services/firebase/
└── utils/
```

## Getting started

1. Create a Firebase project and enable Authentication (email and password) and Cloud Firestore.
2. Register the Android app and replace `android/app/google-services.json` with yours (and add `ios/Runner/GoogleService-Info.plist` for iOS).
3. Run:

```bash
flutter pub get
flutter run
```

## Roadmap

The stories, calls and settings tabs are placeholders for now.

- [ ] Store sent messages per conversation in Firestore
- [ ] Group chats
- [ ] Images and files in messages
- [ ] Stories
- [ ] Voice calls

## Author

**Dissang Kevin** · Mobile AI Engineer
[Portfolio](https://dissangkevin.work) · [GitHub](https://github.com/kteken10)
