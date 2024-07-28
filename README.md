# moovup_test

Flutter project for Moovup program test.

## System Requirement
- Flutter 3.22.3
- Dart 3.4.4
- Android SDK Platfrom-Tools 35.0.1
- XCode 15.4
- CocoaPods 1.15.2

## Getting Started

This project is build for the Moovup program test. The project is a simple Flutter project that uses Google Map API to display the map and the location of the user.

### Plese note that
1. The best way to protect the API key is to use a C++ file to store the key and retrieve it at runtime. However, for testing purposes, I will place the key directly in the code.
2. The Map API Key is not restricted to the Android and iOS platforms. It is open for all platforms for testing purposes.
3. Accessibility, security, lint, and integration tests... are still missing, as this is a simple project intended for testing purposes.

## Ensure the Flutter environment is ready
```bash
flutter doctor
```

## Setup Google map API key
1. Register in https://console.cloud.google.com/google/maps-apis/onboard;flow=gmp-api-key-flow
or use the following key: (place here for the program test only)
    ```
    AIzaSyCSbfY_Tc404GGRdeQM4Vbw42WNz5hGGao
    ```

2. Place the key inside android/secrets.properties
    ```
    MAPS_API_KEY={YOUR_KEY}
    ```
3. Place the key on ios/Runner/AppDelegate.swift
    ```Swift
    GMSServices.provideAPIKey("{YOUR_KEY}")
    ```

## Setup backend API Key
1. The key has been hardcoded in the project for the test purpose.


## Run build_runner on project root for go_router and injectable
```bash
flutter pub run build_runner build
```

## Analyze the project
```bash
flutter analyze
```

## Debug build
1. Launch any iOS or Android emulator.
```bash
flutter run
```

## Release build

### Android release build
1. Follow the Android Studio key generation steps
https://developer.android.com/studio/publish/app-signing#generate-key

2. Run the following command at the command line on iOS:
    ```bash
    keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA \
        -keysize 2048 -validity 10000 -alias upload
    ```
    which will generate a update-keystore.jks file. Keep this file safe.

3. Fill in the file named key.properties in the android directory.

4. Run the following command at the command line on MacOS:
    ```bash
    flutter build apk --release --obfuscate --split-debug-info=build/app/outputs/symbols
    ```

5. Follow the guildline to release the APP:
https://docs.flutter.dev/deployment/android

### iOS release build
1. Follow the steps for XCode installation, CocoaPods installation, and Flutter installation on iOS:
https://docs.flutter.dev/platform-integration/ios/install-ios/install-ios-from-android

2. Run the guildline to release the APP:
https://docs.flutter.dev/deployment/ios

3. Run the following command at the command line on iOS:
    ```bash
    flutter build ios --release
    ```