# Security Audit

This document summarizes the Mobile Application Security Verification Standard (MASVS) checks performed on PixPricer. The project regularly scans the source code using **mobsfscan** and analyzes the built artifacts with **MobSF**. No high‑severity issues were detected in the latest run.

## MASVS Coverage

| Area | Status |
| ---- | ------ |
| Code Quality & Build Settings | ✅ Passing |
| Data Storage & Privacy | ✅ Passing |
| Cryptography | ✅ Passing |
| Authentication & Session Management | ✅ Passing |
| Network Communication | ✅ Passing |
| Platform Interaction | ✅ Passing |

The scanning steps are automated in the CI pipeline and must succeed before deployment.
