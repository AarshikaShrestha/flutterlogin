# AuthFlow - Flutter Login & Registration App

## Project Description

AuthFlow is a clean, responsive login and registration interface built with Flutter for a university assignment. It demonstrates Material widgets, form validation, password visibility controls, and navigation between two authentication screens. Authentication is a UI demonstration and does not connect to a backend.

## Features

- Login page with email or username and password fields
- Registration page with full name, email, password, and confirmation fields
- Basic email validation and minimum password length validation
- Confirm password matching validation
- Show/hide controls for password fields
- Navigation between Login and Registration pages
- Responsive, scrollable layout with form validation feedback
- Success messages for the demo login and registration flows



## Technologies Used

- Flutter
- Dart
- Material Design 3

## Project Structure

```text
lib/
├── main.dart
├── pages/
│   ├── login_page.dart
│   └── registration_page.dart
├── theme/
│   └── app_theme.dart
└── widgets/
	 └── custom_text_field.dart
screenshots/
├── login.png            # Add the Login screenshot here
└── registration.png     # Add the Registration screenshot here
pubspec.yaml
README.md
```

## How to Run

1. Clone the repository:

	```bash
	git clone https://github.com/AarshikaShrestha/flutterlogin.git
	cd flutter-login-registration-app
	```

2. Open the project in Android Studio or VS Code.
3. Install the Flutter SDK with Dart 3.13.2 or later and confirm setup with `flutter doctor`.
4. Fetch dependencies:

	```bash
	flutter pub get
	```

5. Connect an Android device with USB debugging enabled or start an Android emulator.
6. Run the application:

	```bash
	flutter run
	```

No additional packages are required by the app.

