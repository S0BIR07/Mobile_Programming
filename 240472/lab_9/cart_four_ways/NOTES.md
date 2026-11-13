## Checkpoint Questions

1. **Where state lives and when it dies (one line per style):**
   - **setState:** Lives inside the `State` object in the widget tree and dies as soon as the page is popped (`dispose()`).
   - **Riverpod:** Lives in the root `ProviderContainer` outside the widget tree and survives page pops until the app closes (unless marked `autoDispose`, in which case it dies when the last listener unmounts).
   - **Cubit:** Lives in the `CartCubit` instance owned by `BlocProvider` in the widget subtree and dies when `BlocProvider` unmounts and calls `close()`.
   - **Bloc:** Lives in the `CartBloc` instance owned by `BlocProvider` in the widget subtree and dies when `BlocProvider` unmounts and calls `close()`.

2. **Single public mutation API in each style (and which has none):**
   - **Riverpod (`Notifier`):** Assigning to `state = ...` inside the notifier (triggered via `ref.read(provider.notifier).method()`).
   - **Cubit:** Calling `emit(newState)` inside the cubit (triggered via `context.read<CartCubit>().method()`).
   - **Bloc:** Calling `bloc.add(Event)` from outside, which triggers `emit(newState)` inside the registered `on<Event>` handler.
   - **No single public mutation API:** `setState`—any private method on the `State` class can mutate fields directly and schedule a rebuild via `setState(() { ... })`.

3. **Mapping Riverpod vs. Bloc/Cubit primitives (and where `setState` fits):**
   - `ref.watch(provider)` ↔ `BlocBuilder` / `context.watch<T>()` (subscribes and rebuilds UI on state change)
   - `ref.watch(provider.select(...))` ↔ `BlocSelector` / `buildWhen` (rebuilds UI only when a derived slice changes)
   - `ref.read(provider.notifier)` ↔ `context.read<T>()` (one-off lookup inside callbacks without subscribing)
   - `ref.listen(...)` ↔ `BlocListener` (runs one-shot side effects like SnackBars/navigation without rebuilding)
   - **Where `setState` fits:** It combines mutation and subscription into one mechanism—calling `setState()` mutates local fields and unconditionally marks the entire `State` subtree dirty for rebuild, with no built-in selector or listener separation.

4. **Why Riverpod, Cubit, and Bloc skip notifying when `newState == oldState`, and two things required on `CartState`:**
   - **Why:** Rebuilding widgets and re-running listeners when nothing actually changed wastes frame budget and can cause infinite reaction loops.
   - **Two requirements on `CartState`:**
     1. **Immutability (`@immutable` + `final` fields + `copyWith`):** Creating a new instance rather than mutating fields in place ensures `oldState` isn't already identical to `newState` by reference.
     2. **Value equality (`operator ==` and `hashCode`, or `Equatable`):** Deeply comparing fields (including `listEquals` on `lines` and `history`) so two distinct instances with identical data evaluate as equal (`==`).

5. **Post-`await` guards in `checkout` across the four styles and why they differ:**
   - **setState (`if (!mounted) return;`):** State and `BuildContext` belong to the widget element; mutating state or showing a `SnackBar` after unmount throws a `FlutterError`.
   - **Riverpod (`nothing` needed):** `CartNotifier` outlives the page in the root `ProviderContainer` (and `ref.listen` auto-detaches when the widget unmounts), so updating `state` after pop is safe.
   - **Cubit (`if (isClosed) return;`):** `BlocProvider` calls `close()` when the page pops; calling `emit()` on a closed cubit throws a `StateError`.
   - **Bloc (`if (emit.isDone) return;`):** Event handlers can run concurrently or be superseded/closed; `emit.isDone` checks whether that specific event handler's emitter is still active and the bloc hasn't closed.

---

## Comparison Table (Parts 2–5)

| Style | Lines of Code (T1–T5) | Lines of Test Code | Number of Files | One Strength | One Weakness |
| :--- | :---: | :---: | :---: | :--- | :--- |
| **setState** | ~105 | ~30 | 1 (`cart_page_setstate.dart`) | Zero boilerplate and zero external dependencies; everything is in one file. | State dies on pop, cannot be shared across sibling routes, and rebuilds the whole page on every change. |
| **Riverpod** | ~145 | ~40 | 2 (`cart_notifier.dart`, `cart_page_riverpod.dart`) | Cleanest compile-safe dependency injection (`ref.watch`/`select`) and state survives navigation naturally. | Requires a root `ProviderScope` and understanding of `watch` vs. `read` vs. `listen` rules. |
| **Cubit** | ~165 | ~65 | 2 (`cart_cubit.dart`, `cart_page_cubit.dart`) | Simple method-based API with sequential state stream testing via `blocTest`. | Requires manual value equality (`==`/`Equatable`) and `isClosed` guards on async methods. |
| **Bloc** | ~210 | ~95 | 3 (`cart_event.dart`, `cart_bloc.dart`, `cart_page_bloc.dart`) | Full auditability (`currentState -> event -> nextState`) and declarative concurrency (`droppable()`). | Highest boilerplate cost (sealed event classes + handlers) for simple synchronous UI mutations. |