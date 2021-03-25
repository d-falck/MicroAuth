# MicroAuth

![GitHub release (latest by date)](https://img.shields.io/github/v/release/d-falck/MicroAuth) ![GitHub all releases](https://img.shields.io/github/downloads/d-falck/MicroAuth/total) ![Platform](https://img.shields.io/badge/platform-macos-lightgrey) ![macOS version](https://img.shields.io/badge/macos-%3E%3D10.15-blue) ![GitHub](https://img.shields.io/github/license/d-falck/MicroAuth)

**A tiny authenticator that lives in the menu bar and in a customisable keyboard shortcut**

![Screenshot 1](https://github.com/d-falck/MicroAuth/blob/e84ff49158deec80cdafc677799fa5b3c0b48739/Screenshots/Screenshot%202021-03-11%20at%2011.25.40.png)

MicroAuth is customisable multi-factor authentication client for macOS that sits in the menu bar, easily accessible and out of your way, and _lets you paste a current authentication code into any application with a single, configurable, keyboard shortcut_.

## Installation

**Just download the installer [here](https://github.com/d-falck/MicroAuth/releases/download/v1.8/MicroAuth_1.8_Installer.dmg).**

Note that the first time you launch MicroAuth **you'll have to right-click the app** (once it's in your Applications folder) **and click 'Open'** (and then Open again) to bypass Apple's security (it would cost me £99 to get apps signed by Apple to avoid this problem).

## Setup

Your organisation will provide you with a secret key which you copy into the app. For Office 365 users (including members of Oxford University), you can get this by going to `https://mysignins.microsoft.com/security-info -> Add method -> Authenticator app -> Add -> I want to use a different authenticator app -> Next -> Can't scan image`.

## Usage

When you use your configured keyboard shortcut in any application, MicroAuth will get a current authentication code and paste it into whatever text field your cursor is in. Alternatively, you can manually view and copy the current code from the MicroAuth icon in the menu bar, where you can also access preferences.

## Requirements

Requires macOS version 10.15 (Catalina) or later.

## Credit

Thanks are due to Freddie Rawlins and Kieran Ross for their ideas and help.

## To do
- Implement multiple authentication code functionality
- Add interface with browser for even faster workflow
- Store secret key more securely
- Make Windows version?

## Comments/suggestions

Create an issue or email me at damon.falck@worc.ox.ac.uk.

## Licence

This software is provided under the GNU General Public License v3.0, which in particular means you must disclose the source when reusing this code and use the same licence. No warranty is provided.
