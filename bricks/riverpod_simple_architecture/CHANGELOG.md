# 2.1.5
- Fixed dependency erro of velocityx for intl.


# 2.1.4
- Fix responsive framework mobile size
-
# 2.1.3
- Fix heading

# 2.1.2
- Fix links

# 2.1.1
- ✨ **Architecture Documentation:** Added comprehensive architecture documentation ([architecture/architecture.md](__brick__/architecture/architecture.md)) detailing the feature-first approach, layer responsibilities, and usage of Riverpod, AutoRoute, and other libraries.
- ✨ **README Enhancement:** Updated the README to include a reference to the architecture documentation, making it easily accessible to users.


# 2.1.0
- ✨ **Enhanced Error Handling:** Improved error handling across the architecture, providing more robust and informative error messages and recovery mechanisms.
- ✨ **Dependency Management Refinements:** Addressed and resolved several dependency-related issues, ensuring better stability and compatibility within the project. This includes:
    - Updated dependency constraints to be more specific and reliable.
    - Fixed potential conflicts between dependencies.
    - Resolved issues related to incorrect or missing dependency installations.
    - dependency `spot` updated version

# 2.0.33
- Fix error installing dependency `riverpod_test`


# 2.0.32
- Fix error removeing dependency `custom_lint` and `riverpod_lint`

# 2.0.31
- Fix error installing dependency `riverpod_test`

# 2.0.30
- Upgrade version


# 2.0.29
- Fix error installing dependency `riverpod_test`


# 2.0.28+28
- Fix unused import in `no_internet_widget_test.dart`

# 2.0.27+27
-Improved Pre-Generation Script:
The pre-generation script now prompts the user to specify the project name.
If the user leaves the input empty, the script automatically uses the default project name from pubspec.yaml.
A hint is provided in the prompt message to guide the user.

- Fix `spot` version (semantic problem on pub add)

# 2.0.26+26
- Improved pre gen with auto filling project name
- fix `spot` dependency not added to dev_dependencies

# 2.0.25+25
- Fix dependency adding
- added default project name in

# 2.0.24+24
- Migrated to slang for localization
- Fix tests for internet checker
- Add `spot` for widget test


# 2.0.23+23
- fix missing dependency
- fixed imports
- remove depreceate class,functions(`AutoDisposeRef` -> `Ref`)


# 2.0.22+22
- Fixed for new version upgrade
```dart
mason upgrade --global
The current mason version is 0.1.0.
Because riverpod_simple_architecture requires mason version >=0.1.0-dev.49 <0.1.0, version solving failed.
```

# 2.0.21+21
- Added success error handler

# 2.0.20+20
- Fixed hive_ce_flutter import replace old hive import

# 2.0.19+19
- Fixed Wasm Support for flutter_secure_storage

# 2.0.18+18
- dependecy fixes

# 2.0.17+17
- Fix issues

# 2.0.16+16
- Fix issues

# 2.0.15+15
- Add talker_riverpod_logger for better logging
- Refactored code for logger of riverpod

# 2.0.14+14
- Update project name include in class App

# 2.0.13+13
- Fixed unused import

# 2.0.12+12
- Pinning dependency
- Chore: Update dependencies to latest
- Responsive framework nowusing a fork from [this repo](https://github.com/Shreemanarjun/ResponsiveFramework.git)
- Updated on test to cover 100%

# 2.0.11+11
- Fix tests for internet checker


# 2.0.10+10
- Fix IOS loading splash due to keychain access
- Fix themed segment button(remove MaterialStatePropertyAll with WidgetStatePropertyAll) (Flutter 3.22)

# 2.0.10+8
- Added secure storage for encryption
- Replaced bootstrap with Splasher. So user can have a smooth splash screen without flickering(deferFrame/allowFrame).
- (The template now using two runApp which will helpful for long async initialization with a freedback loading screen.)
- Fixed error on responsive framework where type cast failed due to the flutter engines first frame always return heigh and width as 0.


# 2.0.7+7
- fixed cache extension with commenting onResume function
- added additional pub get on all steps complete
- Covered 100% of code now....

# 2.0.5+5
- Fix spellings

# 2.0.4+4
- Added mason upgrades

# 2.0.3+4
- Fix localization errors

# 2.0.2+3
- Fix import with post generation conflicts

# 2.0.1+2
- Fix project name replacement

# 2.0.0+1
- Upgrade with 100% coverage
- Fixed all test case

# 1.0.2+1
- update internet checker to internet connectin plus for web support
- update tests for 100% coverage

# 1.0.1+7
- update docs

# 1.0.1+6
- fix issues

# 1.0.1+5
- fix issues

# 1.0.1+4
- upgraded responsive framework
- migration of dependencies to latest

# 1.0.1+3
- add vscode recommendation extensions

# 1.0.1+2
- fix gitignore

# 1.0.1+1
- Fix project name in pubspec

# 1.0.1+0
- no internet widget refined and restructured for simple usecase
- downgrade responsive framework (no migration note/docs to 1.1.0)
- fix text scaling issue
- rename no internet widget to ConnectionMonitor widget

# 1.0.0+11
- doc improvement

# 1.0.0+10
- remove custom lint

# 1.0.0+9
- remove custom lint

# 1.0.0+8
- 🐛 add herotag on floating action button
- ✨ add no internet to Root app
- ✨ added default main.dart
- 🐛 disable talker in release mode
- ✨ added analysis options with custom lint

# 1.0.0+7
- 🐛 changes in talker dio logger

# 1.0.0+6
- Fix interceptor (form data)

# 1.0.0+5
- Fix test files

# 1.0.0+4
- Fix test files

# 1.0.0+3
- Replace main.dart

# 1.0.0+2
- Fix Errors

# 1.0.0+1
- Make widgets testable
- Added test coverage
- Removed some dependency
- Added test tree

# 0.1.0+20
- 📝 update on completion msg

# 0.1.0+19
- 📝 update on completion msg

# 0.1.0+18
- 📝 update on completion msg

# 0.1.0+17
- 🚑 fix analysis issue
- 📝 update on docs

# 0.1.0+16
- ✨ fix postgen directory path

# 0.1.0+15
- ✨ fix postgen directory path

# 0.1.0+14
- ✨ fix postgen directory path

# 0.1.0+13
- ✨ Add postgen hooks

# 0.1.0+12
- 🚑 fix docs

# 0.1.0+11
- 🚑 fix state restoration on internet disconnection

# 0.1.0+10
- 🚑 theme selection in ui

# 0.1.0+9
- bootstraping method update to support provider scope

# 0.1.0+8
- 🌐 localization l10n.yaml file added

# 0.1.0+7
- fix runInShell
- removed hooks

# 0.1.0+6
- fix runInShell

# 0.1.0+5
- fix pregen

# 0.1.0+4
- fix pregen

# 0.1.0+3
- Check project on pregen

# 0.1.0+2
- Fix path and build issue post gen  release.

# 0.1.0+1
- initial release.
