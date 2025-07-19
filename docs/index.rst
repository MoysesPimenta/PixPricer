PixPricer Documentation
=======================

Welcome to the PixPricer documentation. This space provides
architecture notes, developer guides and API references.

.. toctree::
   :maxdepth: 2
   :caption: Contents:

   ACCESSIBILITY
   ARCHITECTURE_DECISIONS
   perf_report

API Reference
-------------

.. toctree::
   :maxdepth: 2

   api/modules

Color Palette and Contrast
-------------------------

The application adopts a simple palette that favors high contrast:

* **Primary blue** ``#005A9C`` on white – contrast ratio **8.6:1**.
* **Accent yellow** ``#FFC20E`` on black – contrast ratio **15:1**.

Each pair exceeds the WCAG AA requirement of 4.5:1 ensuring legibility across
light and dark themes.

