# Riverpod Ticker Lab Notes

## Part 2 Inline Questions
1. **Why is the feed behind its own Provider instead of being constructed inside `tickerProvider`?**
   - Placing `TickFeed` behind `tickFeedProvider` enables dependency injection, allowing tests and error demos to override `tickFeedProvider` (e.g. using `TickFeed(failAfter: 5)`) without altering `tickerProvider`.
2. **What does `autoDispose` do when the user navigates away mid-stream?**
   - It disposes of the provider state and cancels the active stream subscription as soon as all listeners unsubscribe, preventing memory and resource leaks.
3. **What `AsyncValue` does `tickerProvider` hold during the 800 ms delay, and what is `hasValue` at that moment?**
   - It holds `AsyncLoading<List<Tick>>()`, and `hasValue` evaluates to `false`.

## Part 3 Inline Questions & Diagnostics
- **Exercise 3.3 Diagnostic:**
  `The type 'AsyncValue<List<Tick>>' is not exhaustively matched by the switch cases because it doesn't match 'AsyncLoading()'.`
  - *Significance:* Dart switch expressions enforce exhaustiveness on sealed classes, guaranteeing unhandled loading or error states produce compile-time errors.
- **Exercise 3.4 Arm Ordering:**
  - Pattern matching evaluates sequentially from top to bottom. Specific list arms (`[]`, `[only]`) must come before the general `AsyncData(:final value)` arm; otherwise, the general arm intercepts all data lists, rendering specific matches unreachable.

## Part 4 Inline Questions
- **Exercise 4.3 `refresh` vs `invalidate`:**
  - Both keep previous data visible while re-fetching. `ref.refresh(tickerProvider.future)` returns an awaitable `Future` allowing `RefreshIndicator` to hide its pull-to-refresh UI when the reload completes.
- **Exercise 4.4 `isRefreshing` vs `isReloading`:**
  - `isRefreshing` is `true` when re-fetching while holding previous `AsyncData` or `AsyncError`, whereas `isReloading` is `true` when re-fetching after an `AsyncError` or `AsyncLoading` state without holding active data.

## Checkpoint Questions
1. **Which three subtypes make `AsyncValue` sealed, and what does the analyzer report when a switch expression misses one?**
   - `AsyncData`, `AsyncLoading`, and `AsyncError`. The compiler reports that the switch expression is not exhaustive because it fails to match the missing subtype.
2. **When does `AsyncError.value` carry a non-null value, and when is it null?**
   - `AsyncError.value` carries a non-null value when the provider held a previous successful `AsyncData` emission before an error occurred; it is `null` when an error occurs on cold start with no previous data.
3. **What is the difference between `ref.refresh(provider)`, `ref.refresh(provider.future)`, and `ref.invalidate(provider)`?**
   - `ref.refresh(provider)` immediately forces a re-read and returns the new `AsyncValue`.
   - `ref.refresh(provider.future)` forces a re-read and returns a `Future` that completes when the new value emits (ideal for `RefreshIndicator.onRefresh`).
   - `ref.invalidate(provider)` marks the provider as stale, causing it to re-initialize lazily upon its next read.
4. **Why does `AsyncValue(:final value?, isLoading: true)` need to sit above `AsyncData(:final value)`?**
   - `AsyncValue(:final value?, isLoading: true)` matches an active reload state containing previous data. Since `AsyncData(:final value)` matches any valid data state, placing it first would intercept re-loading data and prevent rendering the in-flight progress indicator.
5. **Give one reason to prefer switch expressions over `.when(...)` for `AsyncValue`, and one situation where `.when` is still convenient.**
   - *Switch expressions* allow advanced structural pattern matching (e.g., matching sub-properties like `:final value?`, empty list states, or `isLoading` flags).
   - *.when* remains convenient for straightforward 3-way branching (`data`, `error`, `loading`) without requiring custom pattern syntax.

## Also I coudn't add 30 second screenrecord of cold load, live ticks, forced error and others. I'm sorry