# Mobile Security Audit

PixPricer undergoes routine security evaluations based on the OWASP Mobile
Application Security Verification Standard (MASVS). The checks concentrate on
ensuring the confidentiality and integrity of user data as well as secure app
operation across both Android and iOS.

**MASVS Architecture:** The build pipeline enforces separation of debug and
release flavors. Release builds disable the Dart DevTools service and omit any
debugging traces. Source code is linted to prevent usage of unsafe APIs.

**Data Storage & Privacy:** User photos are encrypted with AES‑256 before being
written to the local sandbox. No personal information is transmitted to third
parties without explicit consent. Preference files and caches avoid storing
sensitive data in plaintext.

**Cryptography:** All encryption routines rely on platform‑provided key stores.
Keys never leave the device and are regenerated when the app is reinstalled.

**Authentication & Networking:** Connections to cloud services use HTTPS with
certificate pinning to thwart man‑in‑the‑middle attacks. Tokens are stored using
`flutter_secure_storage` and refreshed regularly.

**Code Quality & Resilience:** Static analysis scans are executed on every pull
request using MobSF. High‑severity findings are triaged immediately and must be
resolved before release. This includes removing debugging artifacts, tightening
permissions, or patching vulnerable libraries.

Regular audits help maintain MASVS‑L2 compliance and protect user privacy.
