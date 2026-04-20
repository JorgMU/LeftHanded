#Requires AutoHotkey v2.0

; ------------------------------------------------------------
; Left-Handed Typing Mirror
; Tap Space  → normal space
; Hold Space → mirror mode (use mirrorMap)
; Release    → return to normal typing
; Optional: CapsLock modifier, toggle mode, on-screen indicator
; ------------------------------------------------------------

; ------------------------------------------------------------
; Mirror map: left-hand key → right-hand key
; Letters, numbers, punctuation
; ------------------------------------------------------------
mirrorMap := Map(
    ; Letters
    "a", "h", "s", "j", "d", "k", "f", "l",
    "q", "u", "w", "i", "e", "o", "r", "p",
    "z", "m", "x", ",", "c", ".", "v", "/",

    ; Numbers (optional)
    "1", "0",
    "2", "9",
    "3", "8",
    "4", "7",
    "5", "6",

    ; Punctuation (optional)
    ";", "'",
    "[", "]",
    "-", "="
)

; ------------------------------------------------------------
; Settings
; ------------------------------------------------------------
tapThreshold := 200
isMirroring := false
spaceDownTime := 0
mirrorToggle := false   ; for optional toggle mode
useCapsLockModifier := false  ; set true to enable CapsLock-as-modifier

; ------------------------------------------------------------
; Space down: start timing
; ------------------------------------------------------------
*Space::
{
    global spaceDownTime, isMirroring
    spaceDownTime := A_TickCount
    isMirroring := false
}

; ------------------------------------------------------------
; Space up: decide tap vs hold
; ------------------------------------------------------------
*Space Up::
{
    global spaceDownTime, isMirroring, tapThreshold

    if !isMirroring {
        if (A_TickCount - spaceDownTime <= tapThreshold) {
            Send " "
        }
    }
}

; ------------------------------------------------------------
; Optional toggle mode (Ctrl+Space toggles mirror mode)
; ------------------------------------------------------------
^Space::
{
    global mirrorToggle
    mirrorToggle := !mirrorToggle
    ShowIndicator(mirrorToggle)
}

; ------------------------------------------------------------
; Optional CapsLock modifier mode
; ------------------------------------------------------------
*CapsLock::
{
    global useCapsLockModifier
    if useCapsLockModifier {
        SetCapsLockState "Off"
    }
}

; ------------------------------------------------------------
; Main mirroring logic
; ------------------------------------------------------------
for key, _ in mirrorMap {
    Hotkey "~*" key, MirrorKey.Bind(key)
}

MirrorKey(key) {
    global isMirroring, mirrorMap, mirrorToggle, useCapsLockModifier

    if mirrorToggle
        return SendMirrored(key)

    if useCapsLockModifier && GetKeyState("CapsLock", "P")
        return SendMirrored(key)

    if GetKeyState("Space", "P") {
        isMirroring := true
        return SendMirrored(key)
    }
}

SendMirrored(key) {
    global mirrorMap

    if mirrorMap.Has(key) {
        out := mirrorMap[key]
        if GetKeyState("Shift", "P")
            out := Format("{:U}", out)
        Send out
    } else {
        Send key
    }
}

; ------------------------------------------------------------
; On-screen indicator (optional)
; ------------------------------------------------------------
ShowIndicator(state) {
    if state {
        ToolTip "Mirror Mode: ON", 10, 10
    } else {
        ToolTip
    }
}

; ------------------------------------------------------------
; Debug function (disabled by default)
; ------------------------------------------------------------
Debug(msg) {
    ; MsgBox msg
}
