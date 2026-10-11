# aegis

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Authentication

Enable **Email/Password** as a sign-in provider in Firebase Authentication.
Sign-up requires a name, email, password, and phone number. Phone numbers are
stored in E.164 format (for example, `+14155552671`); they are profile data and
are not used to authenticate or send SMS.

Deploy the Firestore rules configured in `firebase.json`:

```sh
firebase deploy --only firestore:rules
```
