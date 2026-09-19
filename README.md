# SEMIBILL

Flutter client for [SEMIBILL](https://app.semibill.com) — wallet, bill payments, tickets, and crowdfunding.

The UI was rebuilt from the SEMIBILL Figma frames (node 348-8175): phone-width chrome, floating pill tab bar, Settings and Security lists, Home, Wallet, and related flows. Backend contracts are unchanged: same Dio base URL, auth endpoints, and Riverpod providers.

## Run locally

```bash
flutter pub get
flutter run
```

For web:

```bash
flutter run -d web-server --web-hostname 127.0.0.1 --web-port 43141
```

## Android APK (install on your phone)

You need Flutter and the Android SDK (Android Studio is the easiest way to get the SDK).

```bash
flutter pub get
flutter build apk --release
```

The file is:

```
build/app/outputs/flutter-apk/app-release.apk
```

Put that APK on the phone (USB, Drive, Telegram, etc.), then:

1. Open **Settings → Security** and allow installs from this source.
2. Tap the APK and install.
3. Open **Semi Bill**. Login currently skips the API and goes straight to Home.

This build is signed with the debug key, so it is fine for testing, not Play Store.

## Backend

API host: `https://app.semibill.com`

Auth routes used by the app:

- `POST /api/register`
- `POST /api/login`
- `POST /api/forget-password-token`
- `POST /api/initialize-verify`
- `POST /api/verify-otp`

Do not change those payloads without coordinating with the backend.

## Screens

- Auth: splash, login, register, forgot password, BVN
- Tabs: Home, Services, Wallet, Settings
- Services: airtime, data, cable, betting, electricity, internet, gift, refer, tickets, crowdfunding
- Wallet: deposit, withdraw, transfer
- Settings: security, 2FA, notifications, profile, support, devices, FAQ, terms
