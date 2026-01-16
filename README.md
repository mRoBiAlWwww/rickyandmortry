# Project Name

## <a name="introduction"></a> Introduction :

This is a simple application for getting to know characters from the Rick and Morty cartoon, where users can search for characters, view character details, and add them to their favorites. This application is built using Flutter with BLoC/Cubit as the state management approach and follows Clean Architecture principles. It is also powered by the Rick and Morty API (rickandmortyapi.com).

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Libraries](#libraries)
- [Project Structure](#project-structures)
- [APK Link](#apk-link)

## <a name="features"></a> Features :

You may list what feature you created, example :

- List of character
- Detail character
- Search character
- Favorite character

## <a name="libraries"></a> Libraries :

You may list what libraries you used in this project, example :

- Flutter (version)
- BLoC/Cubit as State Management
- Getit as Dependency Injection
- Motion_toast as Toast Notification
- Dio as API Client
- Sqflite as Local Database
- Dartz as Functional Programming & Error Handling

## <a name="project-structures"></a> Project Structure :

```text
lib/
├── common/
│   └── widget/
│
├── core/
│   ├── bloc/
│   ├── config/
│   ├── data/
│   ├── database/
│   ├── dependency_injection/
│   ├── domain/
│   └── wrapper/
│
├── features/
│   ├── details/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── cubit/
│   │       ├── pages/
│   │       └── widgets/
│   │
│   ├── favorite/
│   │   └── ...
│   │
│   ├── home/
│   │   └── ...
│   │
│   ├── search/
│   │   └── ...
│   │
│   └── splash/
│       └── ...
│
└── main.dart
```

## <a name="apk-link"></a> APK Link :

Upload your apk to google drive and attach the link here
https://drive.google.com/file/d/14jR-d3UHol1f668aIqrJO8qb5cO5A6sn/view?usp=sharing
