<!-- Copyright (c) 2025 Shopping Bill App Project -->
<!-- SPDX-License-Identifier: MIT -->
# Shopping Bill App – Developer README

> **Audience:** Autonomous or human developers tasked with building the Shopping Bill App for iOS & Android. Follow this document *verbatim* to set up the workspace, implement features, and verify completeness.

---

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [Quick‑Start Checklist](#2-quick-start-checklist)
3. [Architecture & Tech Stack](#3-architecture--tech-stack)
4. [Folder & Package Structure](#4-folder--package-structure)
5. [Functional Specifications](#5-functional-specifications)
6. [Non‑Functional Requirements](#6-non-functional-requirements)
7. [OCR & ML Pipeline](#7-ocr--ml-pipeline)
8. [Discount Rule Engine](#8-discount-rule-engine)
9. [Data Models](#9-data-models)
10. [UI Guidelines](#10-ui-guidelines)
11. [Performance Targets & Benchmarks](#11-performance-targets--benchmarks)
12. [Testing Strategy](#12-testing-strategy)
13. [CI/CD Pipeline](#13-cicd-pipeline)
14. [Security & Privacy](#14-security--privacy)
15. [Roadmap & Milestones](#15-roadmap--milestones)
16. [Branch Workflow](#16-branch-workflow)
17. [Contribution Guidelines](#17-contribution-guidelines)
18. [License](#18-license)

---

## 1  Project Overview

A cross‑platform mobile application that enables shoppers to photograph shelf price tags (or receipt segments) and instantly:

* Extract **unit price, quantity, discounts**
* Generate a running bill with taxes
* Reconcile the bill against store receipts
* Flag mismatches for user dispute

*Design pillars: camera‑first, offline‑first, privacy‑centric, and <2 s end‑to‑end latency).*
See `docs/Blueprint.md` (generated from the canvas blueprint) for the high‑level product definition.

---

## 2  Quick‑Start Checklist

1. **Fork/Clone** this repository.
2. Run `./scripts/bootstrap.sh` → installs Flutter 3.22, Dart SDK, FVM, pre‑commit hooks.
3. `fvm flutter pub get` – resolves all packages.
4. `melos bootstrap` – link local packages within the repo.
5. `npm install` – install JavaScript and CSS tooling.
6. `npm run lint:js` & `npm run lint:css` followed by `npm run format` – verify JS/CSS style.
7. `fvm flutter run -d ios`, `-d android` – verify demo app builds (empty shell).
8. Run unit tests: `flutter test` (should pass 100%).
9. Read the [Coding Standards](#16-contribution-guidelines) section.

> **Goal:** You should have a compiling app scaffold and a green test suite within **15 minutes** on a standard macOS or Ubuntu workstation.

---

## 3  Architecture & Tech Stack

| Layer                | Technology                                                                  | Reason                                                |
| -------------------- | --------------------------------------------------------------------------- | ----------------------------------------------------- |
| UI                   | **Flutter 3.x (Dart 3)** + Riverpod                                         | Single codebase, native performance, composable state |
| Camera & ML          | Platform channels → **Google ML Kit** (Android) / **Apple VisionKit** (iOS) | On‑device OCR & barcode                               |
| Image Pre‑processing | OpenCV via ffi‑plugin (`opencv_ffi`)                                        | Shadow removal, thresholding                          |
| Local DB             | Drift (SQLite + SQLCipher)                                                  | Zero‑server MVP, encrypted storage                    |
| Dependency Injection | `riverpod` + `hooks_riverpod`                                               | Compile‑time safety                                   |
| Network (Phase 2)    | Firebase Auth + Firestore + Cloud Functions                                 | Easy serverless sync                                  |
| CI                   | GitHub Actions + Fastlane                                                   | Continuous builds, code signing                       |

Diagram: `docs/architecture.drawio` (source) – exports to `docs/architecture.png`.

---

## 4  Folder & Package Structure

```text
shopping_bill_app/
├── android/                  # Native Android runner
├── ios/                      # Native iOS runner
├── lib/
│   ├── main.dart             # Entry point
│   ├── src/
│   │   ├── presentation/     # UI widgets & screens
│   │   ├── application/      # State notifiers, services
│   │   ├── domain/           # Entities, value objects, repositories (DDD)
│   │   ├── infrastructure/   # Platform adapters (camera, ml, db)
│   │   └── core/             # Constants, theming, utils
│   └── generated/            # json_serializable models
├── scripts/                  # Dev‑ops and automation scripts
├── test/                     # Unit & integration tests
├── integration_test/         # Flutter integration tests
├── assets/
│   ├── translations/         # .arb i18n files
│   └── models/               # ML model bundles (if any)
└── docs/                     # Design docs, wireframes, diagrams
```

> **Rule:** *No* business logic in widgets; keep them pure. Application layer orchestrates flows.

---

## 5  Functional Specifications

Reference: section 5 of Blueprint.

* **FR‑01**\~**FR‑14** must be fully implemented for v1.0 tag.
* Use `domain/specs/requirements.yml` to track requirement → PR mapping with unit tests.

---

## 6  Non‑Functional Requirements

See section 6 of Blueprint.
Automated acceptance metrics:

* Cold launch time (<1 s) measured via `benchmark_harness`.
* OCR accuracy target (>95 %) validated against golden dataset in `assets/test_images/`.

---

## 7  OCR & ML Pipeline

1. **Acquisition:** 12‑MP camera stream at 720p for processing; keep full‑res copy.
2. **Pre‑processing:**

   ```dart
   img = removeShadows(img);
   img = enhanceContrastCLAHE(img);
   img = binarizeAdaptive(img);
   ```
3. **Text Recognition:** `MlKitTextRecognizer.processImage`.
4. **Price Extraction:** regex `r"[R$€$]?\s*(\d+[.,]\d{2})"` + confidence scoring.
5. **Discount Parsing:** phrase patterns – examples in `ml/discount_rules.yaml`.

> **Dataset:** Start with publicly available “GroZi‑120” + custom tagged images (`datasets/supermarket_tags/`).

---

## 8  Discount Rule Engine

Pure Dart library (`packages/discount_engine`):

```dart
abstract class DiscountRule {
  Money apply({required int quantity, required Money unitPrice});
}
class XForFixed extends DiscountRule { ... }
class BuyXGetY extends DiscountRule { ... }
class PctOffAboveQty extends DiscountRule { ... }
```

DSL grammar in `specs/discount_dsl.ebnf` (matches Blueprint Appendix A).

---

## 9  Data Models

Located in `lib/src/domain/models/`.  Use `freezed` + `json_serializable`.

```dart
@freezed
class Item with _$Item {
  const factory Item({
    required String id,
    required DateTime ts,
    required Money priceUnit,
    required double quantity,
    DiscountRule? discountRule,
  }) = _Item;
}
```

Full schema tables auto‑generated in Drift; see `lib/src/infrastructure/db/app_database.dart`.

---

## 10  UI Guidelines

* **Camera Screen** – autofire when focus locked >200 ms; show cropped preview.
* **Cart List** – swipe‑to‑delete, material 3 list‑items, subtotal in sticky footer.
* **Reconcile Screen** – diff table, red row highlights mismatches, share FAB.
* Color & typography tokens in `lib/src/core/theme/*.dart`.  Use Material 3 dynamic color.

Wireframes located in `docs/wireframes/` (Figma export → PNG).

---

## 11  Performance Targets & Benchmarks

| Metric                 | Target                         | Instrumentation                             |
| ---------------------- | ------------------------------ | ------------------------------------------- |
| End‑to‑end OCR latency | ≤2 s (median)                  | `flutter_benchmark` scenario                |
| CPU usage              | <40 % median during processing | Android Studio Profiler & Xcode Instruments |
| Battery drain          | <5 % over 15 min session       | Android Battery Historian                   |

Add perf tests under `benchmark/` – run on GitHub Actions nightly.
Benchmark results are summarized in [docs/perf_report.md](docs/perf_report.md). Latest run attempt on **2025‑07‑20**.

---

## 12  Testing Strategy

* **Unit Tests:** `flutter test --coverage` (>90 % coverage mandatory).
* **Golden Tests:** Pixel‑perfect UI snapshots per locale.
* **Integration Tests:** Camera flow mocked via `CameraTestingApi`.
* **End‑to‑End (Beta):** Firebase Test Lab ‑‑> 5 device matrix.

CI will fail PR if any test fails or coverage <90 %.
Use `scripts/run_tests.sh` to run tests locally with coverage enforcement.

---

## 13  CI/CD Pipeline

GitHub Actions workflows:

* `build.yml` – matrix build (Android, iOS), run tests, archive artifacts.
* `deploy_beta.yml` – on tag `v*.*.*-beta*`: Fastlane upload to TestFlight & Play Console closed track.
* `release.yml` – on tag `v*.*.*`: notarize, distribute to stores.

Secrets stored as GitHub encrypted secrets (`APPSTORE_CONNECT_API_KEY`, `PLAY_KEY_JSON`, etc.).

---

## 14  Security & Privacy

* All photos stored in sandbox path → encrypted via `flutter_secure_storage` + AES‑256.
* No external image upload without opted‑in account.
* Comply with OWASP MASVS‑L2; audit automated via `mobile‑security‑framework‑mobsf` GitHub Action.

---

## 15  Roadmap & Milestones

| Milestone     | Branch  | Duration    | Deliverables                                                    |
| ------------- | ------- | ----------- | --------------------------------------------------------------- |
| **MVP Alpha** | `alpha` | W‑1 → W‑6   | Capture, OCR, cart calc, unit tests                             |
| **Beta v0.9** | `beta`  | W‑7 → W‑10  | Discount engine, receipt reconcile, PT‑BR & EN‑US, golden tests |
| **GA v1.0**   | `main`  | W‑11 → W‑12 | Export/share, polished UI, analytics, launch stores             |
| Phase 2       | `sync`  | TBD         | Cloud sync, community discount DB, spending insights            |

---

## 16  Branch Workflow

* `main` – protected release branch; enable GitHub branch protection so merges require a review and green CI.
* `alpha` – created from `main` for early milestone work. Feature branches merge here until Alpha is feature complete.
* `beta` – forked from `main` for stabilization after Alpha. Bug fixes and polish land here before final merge back to `main`.
* Feature branches (`feat/`, `fix/`, `docs/`) start from the active milestone branch (`alpha` or `beta`).

---

## 17  Contribution Guidelines

* **Branch naming:** `feat/<scope>`, `fix/<scope>`, `docs/<scope>`.
* **Commits:** Conventional Commits (`feat:`, `fix:`, `perf:`) with footer `Refs #<requirement‑id>`.
* **Pull Requests:** Must reference requirement ID(s) & include test evidence.
* **Code Style:** run `flutter format .` & `dart fix --apply`.
* **Static Analysis:** `flutter analyze` + `melos run lint` must pass.
* **Linters:** run `flake8` and `mypy` for Python sources. For JavaScript and CSS
  sources, first run `npm install` then `npm run lint:js`,
  `npm run lint:css`, and `npm run format`.

PRs auto‑labelled via `.github/labeler.yml`.

---

## 18  License

Code released under **MIT License** (see `LICENSE`).  Third‑party dependencies retain their respective licenses – see `THIRD_PARTY_NOTICES.md`.

---

*© 2025 Shopping Bill App Project. All rights reserved.*
