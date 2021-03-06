Godot TTS
This addon was primarily developed for the Godot Accessibility addon, but should work well in other contexts where a Godot game might require text-to-speech.

Supported Platforms
Text-to-speech is complicated, and some features may not work everywhere. Most optional features have an associated boolean property used to determine if the feature is available. Further, while I do attempt to ensure that this addon works as well as possible on all platforms, there may be bugs, and pull requests are welcome. Known supported platforms include:

Windows
Screen readers/SAPI via Tolk (requires use_tolk Cargo feature)
WinRT
Linux via Speech Dispatcher
MacOS
AppKit on MacOS 10.13 and below
AVFoundation on MacOS 10.14 and above, and iOS
Web
Features
Note that not all features are supported on all synthesizers. Any feature that may not be supported has a boolean property that can be checked to determine whether it works on the current platform.

Speaking text, with interruption support on most platforms
Stopping speech in progress
Getting and setting speech rate in both native synthesizer units and percentages
Detecting whether a screen reader is active
Determining whether the synthesizer is speaking, and sending a signal on completion
API
The public-facing API is contained entirely within TTS.GD.

Download
Download the latest release.

Usage
Inside your projects root folder create a new folder named addons. Then extract godot-tts.zip into that folder. After attaching TTS.GD to a node you can make calls to the API.

Notes on Android
Usage on Android is a bit more complicated:

Set up a custom Android build.
Create a directory reachable at res://android/plugins and place the godot-tts.aar and .godot-tts.gdap files from a release into that directory.
Update res://android/build/config.gradle to specify a minSdk of at least 21. Individual versions may vary, but minSdk is the critical value from this example:
ext.versions = [
    androidGradlePlugin: '3.5.3',
    compileSdk         : 29,
    minSdk             : 21,
    targetSdk          : 29,
    buildTools         : '29.0.3',
    supportCoreUtils   : '1.0.0',
    kotlinVersion      : '1.3.61',
    v4Support          : '1.0.0'

]
Notes on Universal Windows Platform
Godot's UWP export is currently broken. In order to use this addon in a UWP game, do the following:

Export to UWP.
Extract the newly-created .appx file with makeappx unpack.
If you've extracted the .appx file to a directory like _mygame_, copy addons\godot-tts\target\release\godot_tts.dll to mygame\game\addons\godot-tts\target\release\godot_tts.dll, creating the directory if it doesn't exist.
Repack the appx using makeappx.
It should then be ready to sign and install. Hopefully Godot's UWP export will eventually copy GDNative DLLs correctly so this procedure isn't necessary.
