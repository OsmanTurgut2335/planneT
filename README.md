# Plant Care App

A Flutter application designed to help users track and care for their plants. The app allows you to add new plants, manage watering schedules, view upcoming watering events on a calendar, and more.

---

## Table of Contents

1. [Features](#features)  
2. [Screenshots](#screenshots)  
3. [Tech Stack](#tech-stack)  
4. [Folder Structure](#folder-structure)  
5. [Testing](#testing)  
6. [Installation & Setup](#installation--setup)  
7. [Contributing](#contributing)

---

## Features

- **Add & Manage Plants**  
  - Add new plants with name, nickname, type, and image.
  - Set watering frequency and last watered date.
  - View a grid/list of your plants with detailed plant cards.

- **Watering Calendar**  
  - View upcoming watering events in a monthly calendar.
  - Check specific dates for watering tasks.
  - Interactive calendar with day selection and event loading.

- **State Management & Navigation**  
  - Uses Bloc/Cubit for predictable state management.
  - GoRouter is used for seamless navigation between screens.
  - Hive is utilized as a local database for storing plant data.

---

## Screenshots

| Home Screen               | Add Plant                | Calendar               | Plant Details            |My Plants
|---------------------------|--------------------------|------------------------|--------------------------|--------------------------|
| ![Home Screen](./screenshots/home_screen.png) | ![Add Plant](./screenshots/add_plant.png) | ![Calendar](./screenshots/calendar_view.png) | ![Plant Detail](./screenshots/plant_details.png) | ![My Plants](./screenshots/my_plants.png) |



---

## Tech Stack

- **Flutter & Dart**: The core framework and language.
- **Hive**: Lightweight local database for plant data.
- **Bloc/Cubit**: For state management.
- **GoRouter**: For navigation and routing.
- **TableCalendar**: Calendar widget for displaying watering schedules.
- **ImagePicker**: To capture images from camera or gallery.


---
## Folder Structure

```
lib
 ┣ core
 ┃ ┣ constants       // App-wide constants (colors, paddings, strings, etc.)
 ┃ ┣ cubit           // Cubit/BLoC classes for state management
 ┃ ┣ provider        // Provider factories (e.g., watering_provider.dart)
 ┃ ┣ repository      // Data repositories (Hive and network access)
 ┃ ┣ router          // App routing configuration (GoRouter)
 ┃ ┣ theme           // App theme files (light/dark themes)
 ┃ ┗ widgets         // Reusable widgets across the app
 ┗ features
   ┣ models          // Data models (e.g., Plant)
   ┣ widgets         // Feature-specific widgets (e.g., plant cards, calendars, image pickers)
   ┗ pages           // Screens for each feature (e.g., AddPlantScreen, CalendarScreen, MyPlantsScreen)
  

```

## Testing

- **Unit Tests**: Basic unit tests are implemented for core logic and business rules.  
- **Widget Tests**: Currently incomplete, planned for future development to ensure UI components behave correctly.

---

## Installation & Setup

1. **Clone the repository**:
     ```bash
     git clone https://github.com/yourusername/plant_care_app.git
2. **Navigate to the project directory**:
     ```bash
     cd plant_care_app
3. **Install dependencies**:
    ```bash
     flutter pub get
4.  **:Run the app**: 
    ```bash
     flutter run
    ```

---

## Contributing

Any contributions or suggestions are fully welcome!  
1. Fork the repository.  
2. Create a new branch: `git checkout -b release`.  
3. Commit your changes: `git commit -m "Add some feature"`.  
4. Push to your branch: `git push origin release`.  
5. Open a pull request describing your changes.

---
