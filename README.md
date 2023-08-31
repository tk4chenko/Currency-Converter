# CurrencyConverter

This app is a currency exchange and tracking application built using UIKit with a modern architecture. It follows the MVVM (Model-View-ViewModel) pattern along with the Coordinator pattern for navigation. The user interface is created programmatically without the use of storyboards, ensuring a clean and modular design. The app leverages the RealmSwift framework for data persistence.

## Table of contents

* [Features](#features)
* [Overview](#overview)
* [Resources](#resources)
* [Requirements](#requirements)
* [Installation](#installation)

## Features

* **Exchange Rate Tracking:** Users can easily access the current exchange rates for various currencies. This feature helps users stay informed about the latest currency conversion rates.
* **MVVM + Coordinator Architecture:** The app employs the MVVM architecture for a clear separation of concerns between data, presentation, and user interactions. Additionally, the Coordinator pattern is used to handle navigation and flow control.
* **Programmatic UI:** The user interface is constructed programmatically, avoiding the use of Interface Builder and storyboards. This approach promotes maintainability, flexibility, and better version control.
* **Data Persistence:** The app utilizes RealmSwift, a mobile database framework, to provide reliable data storage capabilities. Users can securely store their own bids or wallet balances even when offline.
* **Custom Bids and Wallet:** Users have the ability to add and manage their own bids or wallet balances in dollars. This feature enhances the app's usability by allowing users to keep track of their financial activities.
* **Offline Functionality:** The app ensures that users can access their bids and wallet balances even without an internet connection. This is achieved through the offline capabilities provided by RealmSwift's data storage.

## Overview

| Currency List | Wallet | Bids |
|:-------------:|:------:|:----:|
| ![Currency List](https://github.com/tk4chenko/Currency-Converter/assets/106691125/32d029fa-ff61-4ce6-9c13-9247dfe5a169) | ![Wallet](https://github.com/tk4chenko/Currency-Converter/assets/106691125/621b7d57-fe17-4445-8fe0-451924996b98) | ![Bids](https://github.com/tk4chenko/Currency-Converter/assets/106691125/96344848-1879-4921-92cd-22ebeca060da) |

## Resources

* [ExchangeRate-API](https://www.exchangerate-api.com)

## Requirements

- iOS 15.0+
- Xcode 14.0+

## Installation

1. Clone repository on your Mac
2. Open CurrencyConverter.xcodeproj file in Xcode
3. Build by pressing <kbd> <br>⌘</kbd> + <kbd> <br>R</kbd>
4. Enjoy!
