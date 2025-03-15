# LogTools

![Swift Version](https://img.shields.io/badge/Swift-6.0-orange.svg)
![Platform](https://img.shields.io/badge/platform-iOS%20%7C%20macOS%20%7C%20visionOS-blue.svg)

LogTools is a Swift logging library designed to enhance the existing OSLog system.
It allows you to easily integrate custom log destinations such as file streaming, network logging, or built-in console logging without rewriting your entire logging system.
Simply update your imports and enjoy extended logging capabilities.

## Features

- Seamless integration with existing OSLog-based logging.
- Support for multiple log destinations.
- Easy setup and minimal adjustments needed to existing codebases.

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/felfoldy/LogTools.git", from: "1.0.1")
]
```

## Usage

Change the `OSLog` import to `LogTools`:

```swift
// import OSLog
import LogTools

let log = Logger(subsystem: "com.your_company.your_subsystem", category: "your_category_name")
            
log.notice("The array contains \(itemCount) items")
log.debug("The user selected the color \(selectedColor)")
```

You can implement a `LogDestination` and add it like this:
```swift
Logger.destinations.append(NetworkLogDestination())
```

