Color Toggler UI

Requires UE4SS installed for inZOI. Copy ColorTogglerUI into ue4ss/Mods and add ColorTogglerUI : 1 to mods.txt. Enable only one UI recolor mod at a time.

Controls
CTRL+ALT+SHIFT+C cycles forward once per press.
Sends a 2.5-second palette-name notification through the local player controller. Visibility depends on the game HUD handling native client messages and needs in-game confirmation.
Starts in Baby Pink on first use, then restores the last saved palette, including Off. Each color switch writes the palette name to Scripts/theme.txt. Off restores captured widget colors.

Modes
Pink, Baby Pink, Hot Pink, Lavender, Black, Mint-Choco, Neapolitan, Red, Orange, Yellow, Green, Blue, Violet, Pastel Red, Pastel Orange, Pastel Yellow, Pastel Green, Pastel Blue, Pastel Violet, Rainbow, Pastel Rainbow, Off.
Baby Pink uses #F2BDCF with #DC507F accents.

Coverage
Refreshes supported widgets after loading a world and after each color switch.
Targets exposed UMG borders, button states, named panel images, background blur tints, map and interaction images identified by their names, and blue/cyan progress fills. Rainbow modes distribute colors across captured widget properties. Black mode lightens captured dark neutral text.
Emotion and mood widgets and widget paths containing FamilyTies or CyberCore are excluded. Status meter fill hues outside blue/cyan are preserved.

Limits
Coverage depends on exposed UMG properties and widget names. Material-rendered icons, baked artwork, Slate-only UI, and late game-driven color updates may require additional handling. HUD recoloring and palette switching have been tested in game by the player. Name-based exclusions cannot identify every anonymous widget created by another mod. Cross-session theme restoration and the palette notification require confirmation in game. Settings need write access to Scripts/theme.txt.

This package contains a Lua script and this README. It contains no game artwork or third-party mod assets.
