## SmartCards — Build Plan

A native iOS app (SwiftUI) that turns lecture notes, PDFs, and pasted text into high-quality study flashcards in seconds, then drives daily retention through spaced repetition, quizzes, and streaks. Built for university & grad students, with German + English support.

### Core Action
Upload/paste source → AI generates a deck → study it. This is the magic moment and the fastest, most polished flow in the app.

### Target Demographic
University and grad students. Tone: premium-minimal and motivating — Notion-clean structure, Duolingo-style streak energy, CalAI-style premium AI feel. Credible for serious study, not childish.

## Design Direction
- **Reference:** Duolingo (rounded, friendly, gamified, motivating) — interface language for the habit loop and celebratory states, kept minimal.
- **Palette — Premium Ink + Indigo (custom, user-directed):**
  - Background `#FAFAF7` (Notion off-white)
  - Surface `#FFFFFF`
  - Primary / Text `#18181B` (charcoal ink)
  - Accent `#6366F1` (refined indigo — reserved for streaks, AI moments, primary CTAs)
- Minimalistic, mobile-first. Light + dark mode. One accent hue only; everything else neutral.

## v1 Scope
- **AI Generator**: paste text or import PDF/DOCX → choose card types (Q&A, multiple-choice, true/false) → AI returns an editable deck. Mock generation first pass; OpenAI-wired in live pass.
- **Dashboard / Decks**: deck list with progress rings, search, create deck, per-deck stats, streak + due-today header.
- **Study Mode**: one card at a time, tap-to-flip animation, rate Easy / Medium / Hard.
- **Spaced Repetition**: FSRS-style scheduling, "Due today" daily review queue, learning streak.
- **Quiz Mode**: timed quiz from a deck, live score, review-mistakes summary.
- **Analytics**: cards learned, accuracy rate, weekly chart, streak history (Swift Charts).
- **Premium (Superwall + StoreKit)**: unlimited AI generations, unlimited imports, advanced analytics, export.
- **Localization**: German + English UI from v1.
- **Auth**: email + Google (Supabase) — mock/local first, wired in live pass.

### Non-goals (v1)
- No collaborative/shared decks or social feed.
- No web/desktop client (native iOS only).
- No image-occlusion or handwriting OCR cards.
- Languages limited to German + English.

## UX patterns to mirror
- **Quizlet** — deck-centric dashboard with prominent create entry and per-deck study/quiz modes. Avoid its overwhelming nav and aggressive paywall friction.
- **Anki (FSRS)** — spaced-repetition scheduling + Easy/Good/Hard rating; surface a clean "Due today" count instead of dense stats.
- **Duolingo** — streak counter, daily-goal loop, celebratory completion states.
- **StudyFetch / Coconote** — "upload → processing → editable review" generation flow with a clear processing state.

## Screen Map (v1)
1. Onboarding — personalization quiz ending on a personalized plan + paywall.
2. Dashboard — decks, streak, due-today, search.
3. Generate — source input → card-type picker → processing → editable review.
4. Study Mode — flip cards + difficulty rating.
5. Quiz Mode — timed + results/review.
6. Analytics — charts + streak.
7. Settings / Premium (incl. language toggle).

## Technical stance
- v1 built mock/local-first with SwiftData so the full loop is real and demoable offline.
- OpenAI generation, Supabase auth/DB, and Superwall paywall wired in a second live pass.
- Premium via Superwall + StoreKit (not Stripe, per Apple rules).

## Onboarding
- **Personalization quiz** → personalized study-plan reveal → paywall-first placement (matches CalAI-style premium positioning and the habit-loop goal).

## Pre-Build Confirmation
- **Features:** AI Generate (mock first), Dashboard/Decks, Study Mode, Spaced Repetition + streaks, Quiz Mode, Analytics, Premium gating, DE/EN localization.
- **Design reference:** Duolingo feel.
- **Palette:** Premium Ink + Indigo — bg `#FAFAF7`, surface `#FFFFFF`, primary/text `#18181B`, accent `#6366F1`.
- **Onboarding:** personalization quiz + paywall-first.
- **Exclusions:** no social/shared decks, no web client, no OCR, languages limited to DE/EN.
- **Data/integration stance:** mock/local-first (SwiftData); OpenAI + Supabase + Superwall wired in a later live pass.
- **First screens to build:** navigation shell + Dashboard, then the Generate flow.