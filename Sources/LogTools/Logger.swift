//
//  Logger.swift
//
//
//  Created by Tibor Felföldy on 2024-06-11.
//

import Foundation
import OSLog

public struct Logger: Sendable {
    private let subsystem: String?
    private let category: String?
    
    public init(subsystem: String, category: String) {
        self.subsystem = subsystem
        self.category = category
    }
    
    public init() {
        subsystem = nil
        category = nil
    }
    
    @usableFromInline func logToDestinations(level: LogLevel,
                                             _ message: () -> Any,
                                             file: String,
                                             function: String,
                                             line: Int) {
        let destinations = Logger.destinations
            .filter { $0.canLog(level: level) }
        
        if destinations.isEmpty { return }
        
        let message = message()
        
        for destination in destinations {
            destination.log(subsystem: subsystem, category: category,
                            level: level, message,
                            file: file, function: function, line: line)
        }
    }
}

// MARK: - Logger + Any messages

public extension Logger {
    /// Writes a message to the log using the specified log type.
    @inlinable func log(level: LogLevel = .default,
                        _ message: @autoclosure () -> Any,
                        file: String = #file,
                        function: String = #function,
                        line: Int = #line) {
        logToDestinations(level: level, message, file: file, function: function, line: line)
    }
    
    /// Writes an informative message to the log.
    @inlinable func info(_ message: @autoclosure () -> Any,
                         file: String = #file,
                         function: String = #function,
                         line: Int = #line) {
        logToDestinations(level: .info, message, file: file, function: function, line: line)
    }
    
    /// Writes a debug message to the log.
    @inlinable func debug(_ message: @autoclosure () -> Any,
                          file: String = #file,
                          function: String = #function,
                          line: Int = #line) {
        logToDestinations(level: .debug, message, file: file, function: function, line: line)
    }
    
    /// Writes information about an error to the log.
    @inlinable func error(_ message: @autoclosure () -> Any,
                          file: String = #file,
                          function: String = #function,
                          line: Int = #line) {
        logToDestinations(level: .error, message, file: file, function: function, line: line)
    }
    
    /// Writes a message to the log about a bug that occurs when your app executes.
    @inlinable func fault(_ message: @autoclosure () -> Any,
                          file: String = #file,
                          function: String = #function,
                          line: Int = #line) {
        logToDestinations(level: .fault, message, file: file, function: function, line: line)
    }
    
    /// Writes information about a warning to the log.
    ///
    /// This method is functionally equivalent to the `error(_:)` method.
    @inlinable func warning(_ message: @autoclosure () -> Any,
                            file: String = #file,
                            function: String = #function,
                            line: Int = #line) {
        logToDestinations(level: .error, message, file: file, function: function, line: line)
    }
    
    /// Writes a trace message to the log.
    ///
    /// This method is functionally equivalent to the `debug(_:)` method.
    @inlinable func trace(_ message: @autoclosure () -> Any,
                          file: String = #file,
                          function: String = #function,
                          line: Int = #line) {
        logToDestinations(level: .debug, message, file: file, function: function, line: line)
    }
    
    /// Writes a message to the log using the default log type.
    func notice(_ message: @autoclosure () -> Any,
                file: String = #file,
                function: String = #function,
                line: Int = #line) {
        logToDestinations(level: .default, message, file: file, function: function, line: line)
    }
    
    /// Writes a message to the log about a critical event in your app’s execution.
    ///
    /// This method is functionally equivalent to the `fault(_:)` method.
    func critical(_ message: @autoclosure () -> Any,
                  file: String = #file,
                  function: String = #function,
                  line: Int = #line) {
        logToDestinations(level: .fault, message, file: file, function: function, line: line)
    }
}
