# Hello Flutter

A new Flutter project for learn flutter.

## Getting Started

before starting, you need to:

- [install flutter](https://flutter.dev/docs/get-started/install)
- setup & run [iOS simulator](https://flutter.dev/docs/get-started/install/macos#set-up-the-ios-simulator) / [Android emulator](https://flutter.dev/docs/get-started/install/macos#android-setup)

after that, go to this repository and install all the dependencies by using pub package manager:

```bash
flutter pub get
```

to run this project, run iOS simulator / Android Emulator and then run the flutter:

```bash
flutter run
```

## Lint

to run lint, use this command:

```bash
flutter analyze
```


## Test

to run unit testing & widget testing, use this command:

```bash
flutter test
```

for getting test coverage, use this command:

```bash
flutter test --coverage
```

it will create `coverage` folder with `lcov.info` file inside it. To open the coverage result, `lcov` is needed:

```bash
brew install lcov
```

```bash
sudo apt install lcov
```

for generate html result, use this command:

```bash
genhtml coverage/lcov.info -o coverage/html
```

then open `coverage/html/index.html` using browser.

To open the result using terminal only, run lcov command:

```bash
lcov -l coverage/lcov.info
```
