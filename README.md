# Pocket FM Assignment

This is a coding assignment for a Pocket FM.

*Links:*
- [GitHub Repository](https://github.com/ashoksisara/pocket_fm_assignment)
- [APK (Google Drive)](https://drive.google.com/file/d/1IYtcLQxlHmMxezWdIqJhcq9YIILlMl_8/view?usp=drive_link)

## Product Listing & Cart

### Objectives
- Display product list from a local JSON file
- View product details
- Add products to cart
- Cart screen with total price and item removal

### Requirements
- No API calls; use mock JSON data
- Cart state maintained in memory
- (Optional) Persist cart using local storage

**Evaluation Focus:**
- List rendering
- Shared state management
- Navigation flow

## Prerequisites

- **Flutter SDK**: 3.32.7
- **Dart**: 3.8.1
- **Android Studio** / **VS Code** with Flutter extensions

## Installation & Setup

### 1. Clone the Repository
```bash
git clone https://github.com/ashoksisara/pocket_fm_assignment
cd pocket_fm_assignment
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Run the Project

```bash
flutter run
```

## Project Structure

```
lib/
├── app/
│   ├── routes/
│   │   └── app_routes.dart
│   └── theme/
│       ├── app_theme.dart
│       └── theme_constant.dart
├── core/
│   ├── constants/
│   │   └── app_constants.dart
│   └── utils/
│       └── extension.dart
├── data/
│   ├── models/
│   │   ├── cart_item.dart
│   │   └── product.dart
│   └── services/
│       ├── json_service.dart
│       └── storage_service.dart
├── presentation/
│   └── screens/
│       ├── cart/
│       │   ├── cart_screen.dart
│       │   └── widgets/
│       │       └── cart_item_widget.dart
│       └── product/
│           ├── product_details_screen.dart
│           ├── product_list_screen.dart
│           └── widgets/
│               ├── no_products.dart
│               └── product_card.dart
├── providers/
│   ├── cart_provider.dart
│   └── product_provider.dart
├── widgets/
│   ├── cart_button.dart
│   ├── custom_error_widget.dart
│   ├── image_widget.dart
│   └── loader.dart
└── main.dart
```
