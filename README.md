
<div align="center">

# ✦ CyberStudios ModKit

### open source modding, creative freedom & a little digital chaos ♡

**An open-source collection of game mods, development resources, and experiments created within CyberStudios™.**

[![License: MIT](https://img.shields.io/badge/License-MIT-C6B6F3?style=for-the-badge)](LICENSE)
[![Game: inZOI](https://img.shields.io/badge/Game-inZOI-AED8F5?style=for-the-badge)](https://playinzoi.com/)
[![Open Source](https://img.shields.io/badge/Open-Source-A8E8DC?style=for-the-badge&logo=github&logoColor=202842)](https://github.com/cyberthreed/CyberStudios-ModKit)
[![CyberStudios](https://img.shields.io/badge/By-CyberStudios-F4C8EA?style=for-the-badge)](https://github.com/CyberStudiosTM)

*Made with curiosity. Shared with the community.*

[Explore Repository](https://github.com/cyberthreed/CyberStudios-ModKit) · [CyberStudios Website](https://cyberthreed.github.io/CyberStudios/) · [Report an Issue](https://github.com/cyberthreed/CyberStudios-ModKit/issues)

---

**dream in pixels. create without limits.**

</div>

## ◇ Welcome to ModKit

**CyberStudios ModKit** is the open-source home for my game modifications, technical experiments, and modding resources.

I created this repository to make the development side of my projects more accessible to the community.

Rather than keeping everything behind packaged downloads, I want other creators to have the opportunity to explore how my mods are structured, learn from their implementation, suggest improvements, and experiment with their own ideas.

ModKit is both a growing source-code archive and a collaborative space for creative game modification.

Whether you're an experienced mod developer, someone learning to work with the inZOI ModKit, or simply curious about what happens behind the scenes, you're welcome to explore.

> **A note about this repository**
>
> This repository contains development files and source resources. It is not necessarily a collection of ready-to-install mods.
>
> Individual projects may be experimental, incomplete, or intended for use with specific modding tools.

---

## ✧ The Collection

The following projects currently have source files available in this repository.

### 🍷 TipsyZois

**An intoxication-themed gameplay modification for inZOI.**

TipsyZois explores how alcohol-related gameplay interactions, character states, and consequences can become part of a more expressive life simulation experience.

Its development scope includes staged intoxication, gameplay effects, and related character interactions.

**Source currently available:**

- Unreal plugin project files
- Content and resource directories
- Metadata
- Localization resources
- Lua scripts

**Project:** [Explore TipsyZois](TipsyZois/)

> The presence of source files does not indicate that every planned gameplay feature has been implemented or released.

### ✦ More projects will be added

As additional CyberStudios mods are prepared for open-source publication, they'll be organized into their own project directories.

Each project can have its own documentation, requirements, implementation notes, and contribution guidance.

---

## 01 / Repository Structure

The repository currently includes:

```text
CyberStudios-ModKit/
│
├── TipsyZois/
│   ├── Content/
│   ├── Meta/
│   ├── Resources/
│   ├── l10n/
│   ├── lua/
│   └── TipsyZois_899D9EC7.uplugin
│
├── LICENSE
└── README.md
```

### Directory Overview

| Directory | Purpose |
| :--- | :--- |
| `Content/` | Mod-specific Unreal content and assets |
| `Meta/` | Project metadata |
| `Resources/` | Supporting mod resources |
| `l10n/` | Localization resources |
| `lua/` | Lua scripts and gameplay-related logic |
| `*.uplugin` | Unreal plugin descriptor |

Individual projects may use different structures depending on their implementation.

---

## 02 / Getting Started

### Clone the Repository

```bash
git clone https://github.com/cyberthreed/CyberStudios-ModKit.git
cd CyberStudios-ModKit
```

### Explore a Project

Navigate to the directory for the mod you're interested in.

For example:

```text
CyberStudios-ModKit/TipsyZois/
```

Review the available source files, metadata, scripts, and supporting resources.

### Working with inZOI Projects

Depending on the project, development may require:

- A compatible version of inZOI
- The official inZOI ModKit
- A supported Unreal-based development environment
- Additional tools identified in the individual project's documentation

Not every file is intended to be edited, executed, or installed independently.

**Important:** Do not assume that copying an entire source directory into your game's mod folder will install the mod correctly.

Use a packaged release and its installation instructions when available.

---

## 03 / Contributing

Contributions, feedback, and technical discussions are welcome! ♡

I want this repository to encourage learning, experimentation, and thoughtful collaboration.

### Ways to Contribute

- Report reproducible bugs or unexpected behavior.
- Suggest improvements to existing gameplay systems.
- Help investigate technical issues.
- Improve documentation and development guides.
- Contribute localization fixes or translations.
- Submit targeted code improvements.
- Share findings about supported game and ModKit behavior.

### Contribution Workflow

1. Check the existing issues and project documentation.
2. Open an issue for substantial changes before implementing them.
3. Fork the repository and create a focused development branch.
4. Make your changes while preserving existing functionality.
5. Test your work wherever possible.
6. Submit a pull request describing what changed and why.

Please keep pull requests focused and avoid unrelated formatting or structural changes.

### A Few Ground Rules

- Respect other contributors.
- Don't upload copyrighted third-party assets without permission.
- Don't include private information, credentials, or proprietary game files.
- Clearly describe untested or experimental behavior.
- Avoid introducing destructive or intentionally harmful functionality.
- Keep implementation decisions grounded in observable game behavior.

**Opening a pull request does not guarantee that a change will be merged.**

Final project direction and release decisions remain with the maintainer.

---

## 04 / Open-Source Philosophy

For me, open source is about more than making a repository public.

It's an opportunity to share knowledge, encourage experimentation, and give other developers a clearer understanding of the systems behind a project.

I want people to be able to study how things work, challenge assumptions, suggest better approaches, and explore what they can create themselves.

At the same time, I believe good development requires honesty about limitations.

A source repository may contain unfinished features, experimental approaches, or code that needs further testing.

**Transparency matters more than pretending every experiment is finished.**

This repository will continue evolving as the projects within it grow.

---

## 05 / Releases & Installation

**Source code and playable releases are not necessarily the same thing.**

The contents of this repository are primarily intended for inspection, development, and collaboration.

When a mod has an installable build available, refer to its official release listing and installation instructions.

Do not assume that the latest source commit represents a stable or game-compatible build.

Game updates, dependencies, and changes to the official ModKit can affect compatibility.

---

## 06 / License

This repository includes an [MIT License](LICENSE).

Unless otherwise indicated, original software covered by that license may be used, modified, and redistributed under its terms, including preserving the required copyright and license notice.

Third-party game assets, trademarks, tools, and other materials remain subject to their respective owners' rights and applicable licenses.

**CyberStudios™ branding, original characters, and visual identity are not automatically granted unrestricted trademark or branding rights by the software license.**

Check individual project documentation for any additional notices.

---

## 07 / Community & Support

Found an issue? Have an idea? Want to contribute?

I'd love to see what you're exploring.

| Resource | Link |
| :--- | :--- |
| 🐛 Bug Reports | [Open an Issue](https://github.com/cyberthreed/CyberStudios-ModKit/issues) |
| ✧ Feature Requests | [Suggest an Improvement](https://github.com/cyberthreed/CyberStudios-ModKit/issues/new) |
| 💻 Source Repository | [CyberStudios ModKit](https://github.com/cyberthreed/CyberStudios-ModKit) |
| ☁️ CyberStudios Website | [Explore CyberStudios](https://cyberthreed.github.io/CyberStudios/) |
| ♡ GitHub Organization | [CyberStudiosTM](https://github.com/CyberStudiosTM) |

---

<div align="center">

### ✦ Built within CyberStudios™

*an independent creative technology studio exploring game development, modding, software, and digital experiences.*

**made for curiosity. built for possibility.**

[CyberStudios Website](https://cyberthreed.github.io/CyberStudios/) · [GitHub](https://github.com/CyberStudiosTM)

♡ **welcome to my cyberspace** ♡

</div>
