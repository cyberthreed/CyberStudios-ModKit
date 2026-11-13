
# 🌈 Color UI Toggle
### Source Code | CyberStudios™

**Color UI Toggle** is a Lua-based runtime interface recoloring mod for **inZOI**, developed as part of the CyberStudios™ modding ecosystem.

This directory contains the source code for Color UI Toggle, a customizable UI theming system with 22 selectable color modes.

The project uses **UE4SS** to access supported Unreal Motion Graphics (UMG) widgets and apply runtime color changes without replacing the game's original interface assets.

> ♡ Your game. Your colors. Your cyberspace.

---

## ♡ Project Overview

| Property | Details |
|---|---|
| Project | Color UI Toggle |
| Developer | CyberStudios™ |
| Game | inZOI |
| Language | Lua |
| Framework | UE4SS |
| Available modes | 22 |
| Default mode | Baby Pink |
| Input | CTRL + ALT + SHIFT + C |
| Status | Full release |
| Source directory | `ColorTogglerUI/` |

This directory provides the implementation for inspection, learning, issue reporting, and community contributions.

**This is a source repository, not the official mod distribution page.**

---

## 🎨 Theme System

Color UI Toggle defines 22 color modes.

### Pink & Specialty
1. Pink
2. Baby Pink
3. Hot Pink
4. Lavender
5. Black
6. Mint-Choco
7. Neapolitan

### Classic Colors
8. Red
9. Orange
10. Yellow
11. Green
12. Blue
13. Violet

### Pastel Colors
14. Pastel Red
15. Pastel Orange
16. Pastel Yellow
17. Pastel Green
18. Pastel Blue
19. Pastel Violet

### Multicolor & Default
20. Rainbow
21. Pastel Rainbow
22. Off

Each applicable mode defines color values for supported widget properties, including main colors, accents, hover states, pressed states, and disabled states.

Rainbow modes distribute colors across captured widget properties rather than applying a single uniform tint.

The Off mode restores captured original widget colors.

---

## 📂 Source Structure

    ColorTogglerUI/
    ├── README.txt
    ├── README.md
    └── Scripts/
        └── main.lua

### `Scripts/main.lua`

The primary Lua implementation contains:

- Theme definitions and RGB color conversion.
- Widget discovery and runtime hooks.
- Widget color capture and restoration.
- Supported widget recoloring logic.
- Rainbow color distribution.
- Exclusion rules for protected interface elements.
- Keyboard shortcut registration.
- Widget refresh scheduling.
- Logging and palette notification attempts.

---

## ⚙️ Implementation Overview

### 1. Theme Definitions

The script stores its available palettes in a `MODES` table.

Each theme can specify values such as:

- `Main`
- `Accent`
- `Hover`
- `Pressed`
- `Disabled`
- `MapIcon`
- `Text`, where applicable

Color values are converted from standard RGB channel values to linear color values for use with Unreal Engine.

For example, Baby Pink uses:

    Main:   #F2BDCF
    Accent: #DC507F

The initial selected mode is Baby Pink.

### 2. Runtime Widget Discovery

Color UI Toggle uses UE4SS callbacks and runtime object discovery to locate supported interface widgets.

The implementation monitors:

- `/Script/UMG.Border`
- `/Script/UMG.Button`
- `/Script/UMG.ProgressBar`
- `/Script/UMG.Image`
- `/Script/UMG.TextBlock`
- `/Script/UMG.BackgroundBlur`

Newly created widgets are processed after a short initialization delay.

The script also performs scheduled refresh passes after relevant game loading events.

### 3. Color Preservation

Before recoloring supported widget properties, the implementation captures their original values.

These captured values allow the mod to:

- Apply different color modes.
- Avoid progressively stacking recolor transformations.
- Restore supported original colors when Off is selected.

Restoration is limited to properties successfully captured by the script.

### 4. Theme Switching

The keyboard shortcut is:

**CTRL + ALT + SHIFT + C**

Each key press advances to the next mode.

After the final mode, the selection wraps around to the beginning.

Theme changes trigger a refresh of supported widgets.

The script also attempts to display the selected theme name using a native player-controller message.

Notification visibility depends on the game's handling of those messages.

### 5. Compatibility Exclusions

The script intentionally avoids recoloring identified emotion and mood widgets.

It also contains name-based exclusions for widget paths associated with:

- CyberCore
- FamilyTies

These exclusions are intended to reduce interference with other CyberStudios projects.

The source code does not modify or include files belonging to CyberCore or FamilyTies.

**Note:** Name-based exclusions cannot guarantee detection of every unnamed widget introduced by another mod.

### 6. Rainbow Modes

Rainbow and Pastel Rainbow use dedicated color sequences.

Instead of treating the interface as one uniformly colored surface, the script distributes palette colors across supported widget properties.

This allows multiple coordinated colors to appear within the same interface theme.

---

## 🧩 Dependencies

Color UI Toggle requires **UE4SS** for runtime scripting and access to supported Unreal Engine objects.

Official UE4SS repository:

https://github.com/UE4SS-RE/RE-UE4SS

The current source directory contains a Lua script and documentation.

It does not contain:

- UE4SS binaries.
- Game artwork.
- Third-party mod assets.
- CyberCore source files.
- FamilyTies source files.

---

## 🧪 Development & Testing

Developers examining or modifying the source should test changes against an appropriate inZOI and UE4SS installation.

### Suggested Validation

1. Confirm that the Lua script loads without errors.
2. Verify that the keyboard shortcut cycles through all 22 modes.
3. Check the appearance of supported widgets after loading a world.
4. Confirm that Off restores captured original colors.
5. Verify that emotion and mood widgets remain excluded.
6. Check that CyberCore and FamilyTies widget exclusions are respected.
7. Inspect UE4SS logs for errors during theme switching.
8. Test behavior after world transitions and UI reconstruction.

The repository does not currently document an automated test suite for this mod.

### Known Technical Limitations

- Complete HUD coverage has not been confirmed in-game.
- Some interface elements use materials, baked artwork, or Slate-only rendering.
- Late game-driven color updates may override some changes.
- Native palette notifications may not appear in every HUD configuration.
- Widget-name exclusions cannot identify all anonymous widgets.

These limitations are useful areas for future investigation and contributions.

---

## ♡ Contributing

Community feedback, technical suggestions, and pull requests are welcome!

Useful contribution areas include:

- Improving widget coverage.
- Investigating additional supported UI properties.
- Improving compatibility with game updates.
- Expanding safe widget exclusion rules.
- Investigating theme persistence.
- Improving error handling and diagnostics.
- Documenting reproducible issues.

### Contribution Workflow

1. Fork the CyberStudios ModKit repository.
2. Create a branch for your proposed change.
3. Make your changes within the relevant project directory.
4. Test your changes where possible.
5. Open a pull request explaining the changes and validation performed.

Please avoid unrelated changes to other mods in the repository.

Pull requests are reviewed by the repository maintainer before being merged.

---

## 🛡️ Source Usage & Distribution

This source is published for transparency, learning, and community collaboration.

Please review the repository's current license and contribution guidelines before using or redistributing any source code.

**Publicly accessible source code does not automatically mean unrestricted redistribution rights.**

Official mod releases and distribution are managed by CyberStudios™.

Do not assume that a fork or pull request is an officially supported release.

---

## 🐛 Issues & Bug Reports

If you discover a reproducible problem, open an issue:

https://github.com/cyberthreed/CyberStudios-ModKit/issues

Helpful reports include:

- inZOI version.
- UE4SS version.
- Selected theme.
- Affected widget or interface screen.
- Steps to reproduce.
- Relevant logs or screenshots.

Please avoid including personal information in logs or screenshots.

---

## ♡ Project Credits

**Color UI Toggle**
Created and maintained by CyberStudios™.

Built with Lua and UE4SS for inZOI.

UE4SS is an independent open-source project maintained by its respective contributors.

Color UI Toggle is an independent community mod and is not affiliated with or endorsed by the developers of inZOI.

---

## ☁️ CyberStudios™

**CyberStudios ModKit:**
https://github.com/cyberthreed/CyberStudios-ModKit

**CyberStudios GitHub:**
https://github.com/CyberStudiosTM

**Color UI Toggle Source:**
https://github.com/cyberthreed/CyberStudios-ModKit/tree/main/ColorTogglerUI

*Made with ♡ in cyberspace.*
