# Architecture Decisions

This document records notable architectural choices made for PixPricer.
New decisions should be appended here using the Architecture Decision
Record (ADR) format.

## ADR 1: Adopt Flutter

**Status:** Accepted

Using Flutter allows a single code base to target both iOS and Android while
maintaining high performance. The project uses `fvm` to manage Flutter
versions and ensures reproducible builds.
