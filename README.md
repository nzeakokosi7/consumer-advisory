# Consumable Advisory App

An app for providing advice on packaged consumables based on user's health profile

## How to Use

**Step 1:**

Go to project root and execute the following command in console to get the required dependencies:

```
flutter pub get 
```

**Step 2:**

Still on the project root execute the following command

```
dart run build_runner build 
```

### Libraries & Tools Used

* [flutter_riverpod](https://pub.dev/packages/provider)
* [Logging](https://pub.dev/packages/logger)
* [image_picker](https://pub.dev/packages/logger)
* [go_router](https://pub.dev/packages/logger)
* [dartz](https://pub.dev/packages/logger)
* [firebase_core](https://pub.dev/packages/logger)
* [firebase_auth](https://pub.dev/packages/logger)
* [cloud_firestore](https://pub.dev/packages/logger)
* [firebase_storage](https://pub.dev/packages/logger)
* [camera](https://pub.dev/packages/logger)
* [google_ml_kit](https://pub.dev/packages/logger)
* [path_provider](https://pub.dev/packages/logger)
* [intl](https://pub.dev/packages/logger)
* [google_mlkit_commons](https://pub.dev/packages/logger)
* [avatars](https://pub.dev/packages/logger)
* [email_validator](https://pub.dev/packages/logger)
* [google_sign_in]()


## Project architecture
This project uses the domain based clean architecture.

### Folder Structure
Here is the core folder structure which flutter provides.

```
consumable_advisory/
|- android/
    |-app/
        |-google-services.json
|- assets
|- build
|- ios
|- lib
|- test
```

Let's  a deeper look into the lib directory

```
lib/
|- config/
|- features/
|- app.dart
|- app_common.dart
|- firebase_options.dart
|- main_dev.dart
```

Role definition

```
1- config - All application level configuration classes within their respective directories.
2- features - Contains the different modules which represent the various features of the application
3- app.dart - This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title etc.
4- app_common.dart - Entry point class which supports app launch in different environments (in this case just development environments)
5- main_dev.dart - Launches the app in development environment via app_common.dart
6- firebase_options.dart - Contains app level firebase configurations for initializing firebase on app launch via app_common.dart
```