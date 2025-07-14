🧘‍♀️ InspireMe — Daily Quotes App

**InspireMe** is a beautiful, inspirational quotes app built with Flutter.
It helps users stay motivated with uplifting quotes every day.
The app is designed with elegant animations, mood-based themes (light/dark), and smooth UI.


### ✨ Features

* 🌞 Daily motivational quotes
* 🌓 Light and Dark Mode toggle
* 🎨 Clean UI with beautiful color combinations
* 💾 Save Light and Dark with **SharedPreferences**
* ☁️ Save favorite quotes in  **Firebase Firestore**
* 🔐 User authentication with **Firebase Auth**
* 🔒 Each user can access **only their own saved data**
* 🧠 State management using **Provider**
* 💫 Smooth animations throughout the app


### ▶️ How to Run the App

1. **Clone the repository**

   git clone https://github.com/tanveerkhan87/InspireMe.git
   cd InspireMe
  
2. **Get Flutter packages**

   flutter pub get

3. **Run the app**

   flutter run

4. **(Optional) Build a release APK**

   flutter build apk

### 🧰 Tech Stack

* **Flutter (Dart)** – Cross-platform UI framework
* **Provider** – For scalable state management
* **SharedPreferences** – For storing  Light and Dark locally
* **Firebase Authentication** – For secure user sign-in and sign-up
* **Firebase Firestore** – For cloud-based storage of user quotes

  * 🔐 Each user's data is **secure and private**
  * 🧾 Quotes saved by users are stored in Firestore under **their unique user ID**
  * 🚫 Other users **cannot access** someone else's data


