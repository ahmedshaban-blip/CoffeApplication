# ☕ Coffee App

[![Flutter](https://img.shields.io/badge/Made%20with-Flutter-blue.svg?logo=flutter)](https://flutter.dev)
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![State Management: BLoC](https://img.shields.io/badge/State%20Management-flutter_bloc-yellow.svg)](https://pub.dev/packages/flutter_bloc)

> Welcome to the **Coffee App** — a beautifully designed and animated mobile experience that brings the warmth of a coffee shop to your hands.  
> Built with 💙 **Flutter**, powered by `flutter_bloc`, and infused with delightful UI & UX magic.  
> **Every cup is a hug in a mug ☕.**

---

![Coffee Preview](https://github.com/ahmedshaban-blip/CoffeeApplication/blob/main/assets/images/americano.jpg?raw=true)

---

## 🚀 Features at a Glance

✨ Smooth animations using `flutter_animate`  
🧠 Clean architecture using `Cubit` (from BLoC)  
🍃 Responsive layout across all screen sizes  
📍 Map integration with `OpenStreetMap`  
🍭 UI enhanced with external packages for a modern look  

---

## 📲 Screens Overview

### 🌟 Welcome Screen
> _"Fall in Love with Coffee in Blissful Delight!"_

- 🖤 Coffee beans background with gradient
- 🧡 Stylish **Get Started** button (with loading spinner)
- 🌌 Clean animated text intro

### 🏠 Home Screen
- 📍 Location: Bilzen, Tanjungbalai
- 🔎 Fully functional **search bar**
- 🧾 Interactive promo banner: *Buy One Get One FREE*
- 📊 Tabbed categories (All, Macchiato, Latte, Americano)
- 🧃 Coffee Grid:
  - Image + rating + price
  - ➕ Add to cart (snackbar feedback)
- 📱 Bottom Navigation (Home, Favorite, Cart, Notifications)

### 📋 Detail Screen
- ↩️ Back navigation + ❤️ favorite toggle
- ☕ Big product image + description
- 📏 Size selector (S, M, L)
- 💳 Price + "Buy Now" (with loader)
- 🔍 Read More toggle

### 🛒 Order Screen
- 📦 Delivery/Pickup mode
- 🗺️ Address with map selection via `openstreetmap_flutter`
- ➕ Quantity controller
- 💰 Full payment summary + dropdown for methods
- ✅ Finalize order with animated button

### 🗺️ Tracking Screen
- 📍 Map preview of delivery
- ⏱️ Countdown timer
- 🧑‍🍳 Courier info + call option
- ✅ Delivery progress feedback

---

## 📦 External Packages Used

| Package              | Description |
|----------------------|-------------|
| [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) | State management (Cubit) |
| [`equatable`](https://pub.dev/packages/equatable) | Value comparison for states |
| [`flutter_animate`](https://pub.dev/packages/flutter_animate) | Smooth animations |
| [`google_fonts`](https://pub.dev/packages/google_fonts) | Beautiful fonts |
| [`flutter_svg`](https://pub.dev/packages/flutter_svg) | SVG support for crisp icons |
| [`fluttertoast`](https://pub.dev/packages/fluttertoast) | Toast notifications |
| [`url_launcher`](https://pub.dev/packages/url_launcher) | Open map / call options |
| [`flutter_map`](https://pub.dev/packages/flutter_map) | Map via OpenStreetMap |
| [`cached_network_image`](https://pub.dev/packages/cached_network_image) | Optimized image caching |

---

## 🧱 Folder Structure

```bash
lib/
├── main.dart
├── core/                # Shared constants, themes, utils
├── models/              # Data models
├── screens/
│   ├── welcome/
│   ├── home/
│   ├── detail/
│   ├── order/
│   └── tracking/
├── widgets/             # Reusable UI components
└── cubit/               # App-wide cubits (optional)
