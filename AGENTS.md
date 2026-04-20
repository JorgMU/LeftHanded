Scope: Entire repository.

## Single Project Focus
- This repository contains one script only: `LeftHandedTyping.ahk`.
- Runtime is AutoHotkey v2 (`#Requires AutoHotkey v2.0`).
- No additional modules, files, or abstractions should be created unless explicitly requested.

## Core Behavior Contract (Must Not Change)
### Spacebar Logic
- Tap Space → send a normal space.
- Hold Space → enable mirrored typing mode.
- Release Space → return to normal typing immediately.

### Mirrored Typing Logic
- Mirrored output is defined only by `mirrorMap`.
- Only keys present in `mirrorMap` should be mirrored.
- Unmapped keys behave normally, even while Space is held.
- Mirroring must not interfere with Shift, Ctrl, Alt, Win, or function keys.

## Tap vs Hold Timing Model
- A tap is pressing and releasing Space without pressing any other key and within a short time window (150–250 ms).
- A hold is when Space is down and another key is pressed, or the hold exceeds the tap threshold.
- Tap and hold logic must be mutually exclusive.
- Space must never send unintended extra spaces.

## mirrorMap Structure Requirements
- All mirrored key pairs must be inside a single `mirrorMap` object.
- Do not scatter mappings across the script.
- Do not hard‑code mirrored keys in conditional logic.
- Do not generate multiple maps.
- Keys must be lowercase strings unless explicitly changed.
- If Shift is held, output the shifted version of the mirrored key.

## Editing Rules for Copilot
1. Read the entire script before editing.
2. Keep changes small and explicit.
3. Preserve the core behavior contract.
4. Use AutoHotkey v2 syntax only.
5. Do not introduce new files unless explicitly instructed.
6. Do not convert the script into a class-based architecture unless requested.
7. Avoid unnecessary abstractions or helper modules.

## Modifier Key Handling Rules
- Shift + mirrored key → send shifted mirrored key.
- Ctrl, Alt, and Win pass through normally.
- Do not override Ctrl+Key, Alt+Key, or Win+Key shortcuts.
- Do not mirror modifier keys themselves.

## Error Handling & Debugging
- If adding debug output, use a single function (e.g., `Debug(msg)`).
- Debug output must not be enabled by default.
- Debugging must not interfere with typing behavior.

## Environment
- `AutoHotkey64.exe` is on the user's PATH (`C:\Program Files\AutoHotkey\v2\AutoHotkey64.exe`).
- VS Code extensions installed: `mark-wiemer.vscode-autohotkey-plus-plus`, `zero-plusplus.vscode-autohotkey-debug`.
- The VS Code run button (▷, top-right) launches the active `.ahk` file directly.

## Quick Verification Steps
### Syntax Check
AutoHotkey64.exe /ErrorStdOut LeftHandedTyping.ahk

### Runtime Check
AutoHotkey64.exe LeftHandedTyping.ahk

### Manual Behavior Tests
- Tap Space → outputs a single space.
- Hold Space + mirrored key → outputs mirrored key.
- Hold Space + unmapped key → outputs normal key.
- Release Space → normal typing resumes instantly.
- Shift + mirrored key → shifted mirrored output.

## Conversation Wrap-Up
When the user says **"wrap up"** (or "save context" / "end conversation"), do the following before closing:
1. Review what was discovered or changed this conversation.
2. Update `context.json` with any new facts (tooling, paths, settings, behavior notes).
3. Update `AGENTS.md` with any new environment facts or editing rules.
4. Commit all modified files with message `"Conversation wrap-up: <one-line summary>"`.
5. Confirm what was saved and that it is safe to close.

## Conversation Start
When first loading context at the start of a new conversation, after acknowledging readiness, remind the user:
> "Say **'wrap up'** when you're done and I'll save context and commit before you close."
