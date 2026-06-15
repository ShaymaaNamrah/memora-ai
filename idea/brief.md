## SmartCards — Working Brief (Draft)

A native iOS app that turns lecture notes, PDFs, and pasted text into high-quality study flashcards in seconds, then drives daily retention through spaced repetition, quizzes, and streaks. Built for university & grad students cramming for exams.

### Core Human Driver
Esteem / mastery + safety (exam confidence). The streak + daily review loop taps the same consistency psychology as Duolingo; the "instant cards from my notes" moment delivers immediate perceived value.

### Target Demographic
University and grad students. Tone: clean, motivating, lightly gamified — credible enough for serious study, energetic enough to keep daily habit. Not childish.

### North Star Metric
Cards reviewed per active user per day (retention loop health). Secondary activation metric: decks generated from upload in first session.

### Core Action
Upload/paste source → AI generates a deck → study it. This is the magic moment and must be the fastest, most polished flow in the app.

## v1 Scope (proposed)
- **AI Generator**: paste text or import PDF/DOCX → choose card types (Q&A, multiple-choice, true/false) → AI returns an editable deck. (Mock generation in first pass, OpenAI-wired after.)
- **Dashboard / Decks**: list of decks with progress rings, search, create deck, per-deck stats.
- **Study Mode**: one card at a time, tap-to-flip animation, rate Easy / Medium / Hard.
- **Spaced Repetition**: FSRS-style scheduling, a "Due today" daily review queue, learning streak.
- **Quiz Mode**: timed quiz from a deck, live score, review-mistakes summary.
- **Analytics**: cards learned, accuracy rate, weekly chart, streak history.
- **Premium (Superwall)**: unlimited AI generations, unlimited imports, advanced analytics, export.
- **Auth**: email + Google (Supabase) — wired when we go live; mock/local first.

### Non-goals (v1)
- No collaborative/shared decks or social feed.
- No web/desktop client (native iOS only).
- No image-occlusion or handwriting OCR cards.
- No multi-language UI localization.

## UX patterns to mirror
- **Quizlet** — Deck-centric dashboard with progress and a prominent "create" entry; mirror the deck card layout and per-deck study/quiz modes. Avoid its overwhelming nav and aggressive paywall friction (top complaints).
- **Anki (FSRS)** — Mirror the spaced-repetition scheduling model and the Easy/Good/Hard rating after each card; surface a clean "Due today" count instead of Anki's dense stats.
- **Duolingo** — Mirror the streak counter, daily-goal loop, and celebratory completion states to drive the habit, without going childish.
- **Coconote / StudyFetch** — Mirror the "upload → processing → review generated cards" flow with a clear processing state and an editable card review screen before saving.

## Screen Map (v1)
1. Onboarding (quiz-style, ends on personalized study plan + paywall)
2. Dashboard (decks, streak, due-today, search)
3. Generate (source input → card-type picker → processing → editable review)
4. Study Mode (flip cards + difficulty rating)
5. Quiz Mode (timed + results/review)
6. Analytics (charts + streak)
7. Settings / Premium

## Technical stance
- v1 built mock/local-first with SwiftData persistence so the full loop is real and demoable offline.
- OpenAI generation, Supabase auth/DB, and Superwall paywall wired as a second pass when you're ready to go live.
- Premium via Superwall + StoreKit (not Stripe, per Apple rules).

## Selected Design System

- Reference: Duolingo
- Design traits: rounded, friendly, gamified, high-energy, motivating
- Catalog seed: Clean (`clean`)
- Palette: Premium Ink + Indigo
- Palette tokens: primary #18181B, accent #6366F1, background #FAFAF7
- Status: selected by the user in Research.