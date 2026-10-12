# RuneVM

RuneVM is a cross-platform virtual machine simulation and execution framework built using Haxe, HaxeFlixel, Lime, and OpenFL. It features an interactive retro TV terminal display interface to execute custom stack-based bytecode instructions across Windows and Android devices.

---

## Features

- Cross-Platform Target: Native binaries built for Windows and Android (APK).
- Custom Virtual Machine: Lightweight stack-based execution pipeline supporting arithmetic and control flow opcodes.
- Retro TV UI: TV-like terminal simulation rendering bytecode execution in real-time.
- Automated CI/CD: Seamless multi-platform builds using GitHub Actions.

---

## Technical Stack

- Language: Haxe (4.3.7)
- Framework: HaxeFlixel
- Windowing & Native Bridge: Lime & OpenFL
- Native Backend: HXCPP
- Package Manager: Haxe Module Manager (hmm)

---

## Project Structure

.github/
└── workflows/
    └── build.yml          # GitHub Actions CI workflow
assets/                    # Game and application assets
source/
├── machine/
│   ├── play/
│   │   └── PlayState.hx   # Main state rendering TV UI and VM execution
│   ├── ui/
│   │   └── Codex.hx       # Instructions reference overlay
│   ├── Init.hx            # Engine initialization sequence
│   ├── OpCode.hx          # Virtual machine instruction set definitions
│   └── VM.hx              # Core execution engine logic
└── Main.hx                # Application entry point
template/
└── application/
    └── AndroidManifest.xml # Custom Android manifest template
hmm.json                   # Haxe library dependencies manifest
project.xml                # Lime project configuration

---

## Building Locally

### Prerequisites

1. Install Haxe 4.3.7+: https://haxe.org/
2. Install the hmm library manager:
   haxelib install hmm
   haxelib run hmm setup
3. Install project dependencies:
   haxelib run hmm install

### Building for Windows

haxelib run lime build windows

### Building for Android

Ensure Android SDK, NDK (25.2.9519653), and Java JDK 17 are installed and configured in your environment or ~/.lime/config.xml.

haxelib run lime build android

---

## License

This project is licensed under the MIT License.
