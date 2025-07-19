# PixPricer Product Specification

This document defines the core product requirements for PixPricer, a cross-platform mobile app that scans price tags and receipts.

## Functional Overview

1. Capture images of shelf price tags or receipts using the device camera.
2. Perform on-device OCR to extract item names, prices and discounts.
3. Build a running bill, including taxes and totals.
4. Allow users to verify the calculated bill against the store receipt.
5. Highlight mismatches for manual correction or dispute.

## Non-Functional Requirements

- Offline-first operation with optional cloud sync.
- End-to-end OCR latency under 2 seconds.
- Accessibility compliance with WCAG 2.1 contrast guidelines.

See `README.md` for architecture details and additional requirements.
