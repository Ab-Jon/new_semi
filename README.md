# SEMIBILL

Flutter client for [SEMIBILL](https://app.semibill.com) — wallet, bill payments, tickets, and crowdfunding.

The UI was rebuilt to match the SEMIBILL Figma file (light and dark). Backend contracts are unchanged: same Dio base URL, auth endpoints, and Riverpod providers.

## Run locally

```bash
flutter pub get
flutter run
```

For web:

```bash
flutter run -d web-server --web-hostname 127.0.0.1 --web-port 43141
```

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
