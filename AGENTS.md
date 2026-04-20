# AGENTS.md

Scope: Entire repository.

## Single Project Focus
- This repository is one script: [LeftHandedTyping.ahk](LeftHandedTyping.ahk).
- Runtime is AutoHotkey v2 only (`#Requires AutoHotkey v2.0`).

## Behavior To Preserve
- Tap `Space` sends a normal space.
- Hold `Space` enables mirrored key output using `mirrorMap`.
- Releasing `Space` returns typing to normal behavior.

## Editing Rules
1. Read [LeftHandedTyping.ahk](LeftHandedTyping.ahk) fully before editing.
2. Keep changes small and explicit; do not change unrelated key behavior.
3. Keep mirrored key pairs in `mirrorMap` (do not scatter hard-coded mappings).
4. Use AutoHotkey v2 syntax only (no v1 command syntax).

## Quick Verification
- `AutoHotkey64.exe /ErrorStdOut LeftHandedTyping.ahk`
- `AutoHotkey64.exe LeftHandedTyping.ahk`
- Manual checks: tap `Space`, hold `Space` + mapped keys, release `Space`.