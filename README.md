# Weather Widget Showcase App (iOS)

Overview

![Image0](https://drive.usercontent.google.com/download?id=12wXsmpnU6R92vHZCuhInC5-qJ-cegkmu)
![Image1](https://drive.usercontent.google.com/download?id=1N9md_BccYgwhRYWB7Q6ejrTbj3FATJs4)
![Image2](https://drive.usercontent.google.com/download?id=1txDt6tXomRV5RDPZhIxrmKg-8te8mjlf)
![Image3](https://drive.usercontent.google.com/download?id=1dguoVM7uF0h7VuF-oiLVrLAPbNBtjY0y)

This project is an iOS application that demonstrates how to build a widget-like UI inside a main app and share the same UI and data with a real WidgetKit extension.

The app focuses on a single screen that displays weather information in three different card sizes—Small, Medium, and Large—similar to real iOS widgets. The project is designed with scalability in mind, using Clean Architecture and MVVM.

Minimum supported iOS version: iOS 13

⸻

Architecture & Design
    •    Clean Architecture with clear separation of Domain, Data, and Presentation layers
    •    MVVM to manage data flow between views and business logic
    •    ViewController focuses on UI rendering and user interaction
    •    ViewModel handles data processing through use cases

⸻

UI & Data Sharing
    •    Main app UI built with UIKit using Storyboards and XIB
    •    Widget UI built with SwiftUI
    •    SwiftUI views reused in UIKit via UIHostingController to avoid duplicated UI
    •    Data shared between app and widget using UserDefaults with App Group
    •    Shared resources placed in a common folder

⸻

Tech Stack
    •    Swift
    •    UIKit
    •    SwiftUI
    •    WidgetKit
    •    Clean Architecture
    •    MVVM
    •    OpenWeather API
    •    UserDefaults (App Group)
    •    iOS 13+

⸻

Purpose

This project demonstrates reusable UI between UIKit and SwiftUI, data sharing between the main app and widgets, and a clean architectural approach for building scalable iOS applications.
