# MP Report

## Team

- Name(s): Patel Zeel Rakshitkumar.
- AID(s): A20556822.

## Self-Evaluation Checklist

Tick the boxes (i.e., fill them with 'X's) that apply to your submission:

- [X] The app builds without error
- [X] I tested the app in at least one of the following platforms (check all that apply):
  - [ ] iOS simulator / MacOS
  - [X] Android emulator
- [X] Users can register and log in to the server via the app
- [X] Session management works correctly; i.e., the user stays logged in after closing and reopening the app, and token expiration necessitates re-login
- [X] The game list displays required information accurately (for both active and completed games), and can be manually refreshed
- [X] A game can be started correctly (by placing ships, and sending an appropriate request to the server)
- [X] The game board is responsive to changes in screen size
- [X] Games can be started with human and all supported AI opponents
- [X] Gameplay works correctly (including ship placement, attacking, and game completion)

## Summary and Reflection
In this submission, I updated the pubspec.yaml file to include the win32 package, ensuring compatibility with Windows platforms. This update enhances system integration and allows the application to function seamlessly across both Windows and Android environments.

All required functions were implemented and tested thoroughly on an Android emulator and are also functional on Windows. However, due to space limitations on my laptop, I occasionally faced challenges running the emulator, which might have slightly impacted testing efficiency in specific scenarios. Despite this, I ensured the application's performance and functionality were thoroughly verified.

Key features and validations implemented include:

Users must select exactly five distinct ships before the "Submit" button becomes active, ensuring proper game setup.
If a game is deleted by a user during their session, it automatically counts as a win for their opponent.
Validation checks for usernames and passwords enforce a minimum length of three characters to prevent invalid inputs.
A feature to check for existing users has been added, with the following test credentials available for evaluation:
Username: kskd, Password: 215
Username: dpndr, Password: 456
Username: zzz, Password: zzz
Username: rty, Password: 789



I enjoyed implementing the various features of this MP, particularly designing the validation checks and ensuring the user interface was intuitive and user-friendly. The process of integrating the win32 package and making the application compatible with Windows systems was a valuable learning experience, as it allowed me to explore cross-platform development in Flutter.

However, I found testing on the Android emulator challenging at times due to space constraints on my laptop, which occasionally limited my ability to work seamlessly with the emulator. Debugging certain features, such as ensuring the correct validation of ship selection and handling game deletion scenarios, required additional effort but provided an opportunity to deepen my problem-solving skills.

I wish I had known more about optimizing system resources and emulator configurations before starting this MP, as it would have helped streamline the testing process. Despite these challenges, the experience was rewarding, and I am pleased with the final outcome.
