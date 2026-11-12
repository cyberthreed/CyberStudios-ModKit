
<div align="center">

# ୨୧ CyberStudios ModKit ୨୧

### ˚₊‧꒰ა welcome to my little modding corner ໒꒱ ‧₊˚

**a source-available collection of inZOI mods, creative experiments & development resources.**

[![CyberStudios](https://img.shields.io/badge/CyberStudios-♡-F4C8EA?style=for-the-badge&labelColor=202842)](https://github.com/CyberStudiosTM)
[![inZOI](https://img.shields.io/badge/Game-inZOI-AED8F5?style=for-the-badge&labelColor=202842)](https://playinzoi.com/)
[![License](https://img.shields.io/badge/License-Source--Available-C6B6F3?style=for-the-badge&labelColor=202842)](#-09-licensing--usage)
[![Contributions](https://img.shields.io/badge/PRs-Welcome-A8E8DC?style=for-the-badge&labelColor=202842)](CONTRIBUTING.md)

**☁️ dream in pixels. create without limits. ☁️**

*✧ a little code, a little creativity, and endless possibilities ✧*

[♡ Website](https://cyberthreed.github.io/CyberStudios/) · [✦ Repository](https://github.com/cyberthreed/CyberStudios-ModKit) · [🎀 Contribute](CONTRIBUTING.md) · [🐛 Issues](https://github.com/cyberthreed/CyberStudios-ModKit/issues)

</div>

---

<div align="center">

## 𓆩♡𓆪 01. welcome to modkit

*˚₊‧ a little peek behind the pixels ‧₊˚*

</div>

**Haiii, welcome to CyberStudios ModKit!** ♡

*˚₊‧ a little peek behind the pixels ‧₊˚*

This is the source-available home for my game modifications, development resources, and technical experiments.

I created this repository because I wanted the development side of my projects to be more accessible. Not just the finished mods you download and play with, but the scripts, resources, experiments, and little details that go into making them work.

Whether you're an experienced developer, someone learning how the inZOI ModKit works, or simply curious about what happens behind the scenes, you're welcome to explore!

This repository is designed to grow alongside my projects, with room for community contributions and technical experimentation.

> **୨୧ A LITTLE NOTE**
>
> ModKit is intended to be source-available, not an unrestricted mod distribution archive.
>
> You're welcome to study the source, fork the repository, experiment privately, and submit pull requests under the applicable license.
>
> **Official mod uploads and releases are managed by CyberStudios.**
>
> Previously granted MIT permissions remain valid for materials received under that license.

### ♡ what you're welcome to do

| ✧ | Activity |
| :---: | :--- |
| ☁️ | Explore and study available source files |
| 🎀 | Fork the repository through GitHub |
| 💿 | Experiment with private modifications |
| 🧸 | Report bugs and suggest improvements |
| 🌸 | Submit pull requests for review |
| ✦ | Contribute documentation, fixes, and translations |

### ✧ what requires permission

- Redistributing covered mods or modified packages.
- Uploading mods to Nexus Mods, CurseForge, or other platforms.
- Publishing unofficial packaged releases or download mirrors.
- Selling or sublicensing covered materials.
- Presenting unofficial builds as CyberStudios releases.

These restrictions are subject to the license applicable to each version.

---

<div align="center">

## 𓆩♡𓆪 02. the mod collection

*˚₊‧ tiny modifications, endless possibilities ‧₊˚*

</div>

Welcome to the collection! ♡

Each project has its own purpose, from small quality-of-life adjustments to more ambitious gameplay systems.

Some source projects are already available, while others will be added as their development materials are prepared.

### 🍷 TipsyZois

**✧ a little too much fun for your Zois**

TipsyZois is an intoxication gameplay project for inZOI, exploring how alcohol-related interactions and character states can create more expressive gameplay.

Its broader development vision includes:

- Multiple intoxication stages.
- Character effects and reactions.
- Alcohol-related interactions.
- Hangover mechanics.
- Recovery behaviors and gameplay consequences.

Not every planned feature is necessarily implemented.

**♡ Source:** [Explore TipsyZois](TipsyZois/)

**✦ Download:** Official CyberStudios distribution listing.

> ☁️ Source files may represent development work rather than a complete, installable release.

### 💤 PowerNaps

**✧ five more minutes, please...**

PowerNaps is a quality-of-life gameplay modification focused on making the **Take Power Nap** interaction faster and more convenient.

It's designed to improve short naps without broadly changing the game's entire sleep system.

**♡ Source:** To be linked when available.

**✦ Download:** Official Nexus Mods listing to be added.

### 🎉 PajamaParty

**✧ sleepovers are better with friends**

PajamaParty introduces a custom pajama party social event for inZOI, giving your Zois another way to gather, socialize, and make memories.

**♡ Source:** To be linked when available.

**✦ Download:** Official Nexus Mods listing to be added.

### 💍 AllowProposalOnVacation

**✧ love doesn't follow a travel schedule**

AllowProposalOnVacation removes the restriction preventing marriage proposals while traveling or on vacation.

A small gameplay adjustment that gives you more freedom to tell your Zois' stories wherever they happen.

**♡ Source:** To be linked when available.

**✦ Download:** Official Nexus Mods listing to be added.

---

<div align="center">

## 𓆩♡𓆪 03. inside the modkit

*˚₊‧ a little tour through the files ‧₊˚*

</div>

The repository currently includes the TipsyZois development project and supporting resources.

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
├── .github/
│   ├── ISSUE_TEMPLATE/
│   │   ├── bug_report.md
│   │   └── feature_request.md
│   └── PULL_REQUEST_TEMPLATE.md
│
├── README.md
├── LICENSE
├── LICENSE.md
├── CONTRIBUTING.md
├── SECURITY.md
└── CODE_OF_CONDUCT.md
```

*The policy and template files above represent the intended repository layout. Some may still need to be committed.*

### ✧ directory guide

| Folder | What's inside? |
| :--- | :--- |
| `Content/` | Unreal content and mod assets |
| `Meta/` | Project metadata |
| `Resources/` | Supporting resources |
| `l10n/` | Localization files |
| `lua/` | Scripts and gameplay logic |
| `*.uplugin` | Unreal plugin descriptor |
| `.github/` | Issue and pull request templates |

Individual mods may use different structures depending on their technical requirements.

---

<div align="center">

## 𓆩♡𓆪 04. getting started

*˚₊‧ ready to explore? ‧₊˚*

</div>

### ♡ step one: clone the repository

```bash
git clone https://github.com/cyberthreed/CyberStudios-ModKit.git
cd CyberStudios-ModKit
```

### ♡ step two: choose a project

Navigate to the directory for the mod you're interested in.

For example:

```text
CyberStudios-ModKit/TipsyZois/
```

Explore its scripts, metadata, resources, and project files.

### ♡ step three: prepare your environment

Depending on the project, you may need:

- A compatible version of inZOI.
- The official inZOI ModKit.
- Compatible Unreal development tools.
- Project-specific dependencies.
- Any additional instructions provided with the mod.

> **🎀 PLEASE REMEMBER**
>
> Source directories are not necessarily installable mods!
>
> Copying an entire development folder into your game's mod directory may not produce a working installation.
>
> For gameplay, use official packaged releases and their installation instructions.

---

<div align="center">

## 𓆩♡𓆪 05. official downloads

*˚₊‧ made with love, released with care ‧₊˚*

</div>

CyberStudios manages official distribution of its mods.

**Nexus Mods** is the primary download platform for mods with official Nexus listings.

**CurseForge** may also be available as a secondary download source for certain projects.

Official links will be added to each project's section as they're confirmed.

### ♡ distribution guidelines

Please do not:

- Reupload covered mods to other websites.
- Redistribute covered mod archives.
- Publish unofficial modified packages.
- Create unauthorized download mirrors.
- Represent forks as officially supported releases.

If you'd like to improve a mod, submit a pull request instead!

Approved changes can be reviewed, integrated, packaged, and published through the official CyberStudios distribution channels.

These restrictions are subject to the applicable license, including previously granted MIT rights.

---

<div align="center">

## 𓆩♡𓆪 06. let's create together!

*˚₊‧ your ideas belong in our little cyberspace ‧₊˚*

</div>

Contributions are always appreciated! ♡

Whether you're reporting a bug, suggesting a new feature, improving documentation, or submitting code, there's a place for you here.

### 🎀 choose your contribution

| ✧ | I want to... | Start here |
| :---: | :--- | :--- |
| 🐛 | Report a bug | [♡ Bug Report Template](.github/ISSUE_TEMPLATE/bug_report.md) |
| 🌸 | Suggest a feature | [♡ Feature Request Template](.github/ISSUE_TEMPLATE/feature_request.md) |
| 💻 | Submit code changes | [♡ Pull Request Template](.github/PULL_REQUEST_TEMPLATE.md) |
| 📖 | Read contribution rules | [♡ Contributing Guide](CONTRIBUTING.md) |
| 🛡️ | Report a security concern | [♡ Security Policy](SECURITY.md) |
| 💌 | Review community standards | [♡ Code of Conduct](CODE_OF_CONDUCT.md) |

### ☁️ ready to contribute?

**01.** Read the [Contribution Guidelines](CONTRIBUTING.md).

**02.** Check existing issues before opening a new one.

**03.** Fork the repository and create a focused development branch.

**04.** Make and test your changes.

**05.** Open a pull request using the repository template.

**06.** Wait for maintainer review and approval. ♡

### ✧ quick links

- 🐛 [Open a New Issue](https://github.com/cyberthreed/CyberStudios-ModKit/issues/new/choose)
- 🌸 [Browse Existing Issues](https://github.com/cyberthreed/CyberStudios-ModKit/issues)
- 💻 [Create a Pull Request](https://github.com/cyberthreed/CyberStudios-ModKit/compare)
- 🎀 [View Pull Request Template](.github/PULL_REQUEST_TEMPLATE.md)
- 🧸 [View Bug Report Template](.github/ISSUE_TEMPLATE/bug_report.md)
- 💌 [View Feature Request Template](.github/ISSUE_TEMPLATE/feature_request.md)

### ✧ pull request checklist

- [ ] I've explained what changed and why.
- [ ] I've identified the affected mod.
- [ ] I've tested my changes where possible.
- [ ] I've documented compatibility concerns.
- [ ] I haven't included unauthorized third-party assets.
- [ ] I've reviewed the applicable license.
- [ ] I understand that official releases are managed by CyberStudios.

> **♡ A LITTLE MAINTAINER NOTE**
>
> Pull requests are proposals, not automatic approvals.
>
> CyberStudios reviews submissions and decides which changes become part of official releases.
>
> Contributors may fork, study, privately modify, and propose improvements under the applicable license.
>
> Official mod publishing remains managed by CyberStudios, subject to previously granted licensing rights.

---

<div align="center">

## 𓆩♡𓆪 07. development guidelines

*˚₊‧ thoughtful code makes better mods ‧₊˚*

</div>

I want this repository to encourage experimentation while maintaining clear, reliable development practices.

### ✧ code quality

Please:

- Follow existing project conventions.
- Preserve working gameplay behavior.
- Avoid unnecessary dependencies.
- Document compatibility assumptions.
- Clearly identify experimental functionality.
- Include testing evidence where practical.

### ✧ assets & intellectual property

Do not commit:

- Unauthorized copyrighted assets.
- Proprietary game files.
- Extracted third-party resources without permission.
- Credentials, tokens, or personal information.
- Materials that violate third-party licenses.

### ✧ AI-assisted development

AI-assisted development is welcome.

Contributors are responsible for reviewing, testing, and ensuring they have the rights to submit their work.

AI-assisted contributions are held to the same technical, security, and licensing expectations as other contributions.

---

<div align="center">

## 𓆩♡𓆪 08. safety first!

*˚₊‧ keeping our little cyberspace safe ‧₊˚*

</div>

Security concerns should be reported privately whenever possible.

If you discover an issue involving unsafe file handling, unexpected execution, exposed credentials, or another vulnerability, follow the [Security Policy](SECURITY.md).

Avoid publicly disclosing exploit details before maintainers have had an opportunity to investigate.

For ordinary gameplay bugs and compatibility issues, use the [Bug Report Template](.github/ISSUE_TEMPLATE/bug_report.md).

For improvement suggestions, use the [Feature Request Template](.github/ISSUE_TEMPLATE/feature_request.md).

---

<div align="center">

## 𓆩♡𓆪 09. licensing & usage

*˚₊‧ sharing knowledge while protecting creative work ‧₊˚*

</div>

CyberStudios ModKit is intended to use a **custom source-available licensing model**.

The goal is to allow public source inspection, GitHub forks, private experimentation, and community pull requests while reserving control over public mod distribution.

### ♡ intended permissions

- View and study the source.
- Fork through GitHub.
- Make private modifications.
- Submit improvements through pull requests.

### ✧ reserved rights

- Public redistribution of covered mods.
- Third-party uploads and mirrors.
- Unofficial packaged releases.
- Official branding and publication decisions.

### ⚖️ important licensing notice

This repository was initially published under the **MIT License**.

Existing permissions granted under MIT cannot be retroactively revoked.

A custom CyberStudios ModKit Source License is being prepared for future materials and versions where CyberStudios has the necessary rights to apply it.

Until that transition is completed, the applicable existing license remains controlling.

**Source-available does not mean OSI-approved open source.**

Read the repository's currently published [License](LICENSE) before reusing materials.

---

<div align="center">

## 𓆩♡𓆪 10. community guidelines

*˚₊‧ be kind, stay curious, create freely ‧₊˚*

</div>

CyberStudios is intended to be a welcoming environment for creators and developers.

Please:

- Treat other contributors respectfully.
- Offer constructive feedback.
- Respect project boundaries.
- Credit other people's work.
- Keep discussions productive.
- Avoid harassment or discriminatory behavior.

Maintainers may moderate discussions, close issues, or reject pull requests when necessary.

Read the [Code of Conduct](CODE_OF_CONDUCT.md).

---

<div align="center">

## 𓆩♡𓆪 11. project status

*˚₊‧ our little collection is still growing ‧₊˚*

</div>

Not every project is represented by a complete source release.

| Project | Source Availability |
| :--- | :--- |
| 🍷 TipsyZois | Available |
| 💤 PowerNaps | To be added |
| 🎉 PajamaParty | To be added |
| 💍 AllowProposalOnVacation | To be added |

Source availability is separate from whether a playable mod has been released.

For the latest official builds, refer to CyberStudios' official distribution channels.

---

<div align="center">

## 𓆩♡𓆪 12. links & resources

*˚₊‧ your little navigation directory ‧₊˚*

</div>

| ♡ | Resource | Link |
| :---: | :--- | :--- |
| ☁️ | CyberStudios Website | [Visit Website](https://cyberthreed.github.io/CyberStudios/) |
| 💿 | ModKit Repository | [Explore Source](https://github.com/cyberthreed/CyberStudios-ModKit) |
| 🐛 | Bug Report Template | [Report a Bug](.github/ISSUE_TEMPLATE/bug_report.md) |
| 🌸 | Feature Request Template | [Suggest a Feature](.github/ISSUE_TEMPLATE/feature_request.md) |
| 💻 | Pull Request Template | [Submit Changes](.github/PULL_REQUEST_TEMPLATE.md) |
| 🎀 | Contribution Guidelines | [Read Guide](CONTRIBUTING.md) |
| 🛡️ | Security Policy | [Read Policy](SECURITY.md) |
| 💌 | Code of Conduct | [Community Standards](CODE_OF_CONDUCT.md) |
| ⚖️ | License | [Usage Terms](LICENSE) |
| 💜 | CyberStudios Organization | [GitHub](https://github.com/CyberStudiosTM) |

---

<div align="center">

### ☁️ ˚₊‧꒰ა you've reached the end of the page ໒꒱ ‧₊˚

**thank you for visiting my little corner of cyberspace!**

Whether you're here to learn, contribute, or peek behind the scenes, I hope you find something interesting to explore.

♡ *built with curiosity, creativity & a little too much caffeine* ♡

### ✦ CyberStudios™

*an independent creative technology studio*

**dream in pixels. create without limits.**

[♡ Website](https://cyberthreed.github.io/CyberStudios/) · [✦ GitHub](https://github.com/CyberStudiosTM)

</div>
