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
    
    public func log(level: LogLevel,
                    _ message: @autoclosure () -> String,
                    file: String = #file,
                    function: String = #function,
                    line: Int = #line) {
        logToDestinations(level: level, message, file: file, function: function, line: line)
    }
    
    /// Writes an informative message to the log.
    public func info(_ message: @autoclosure () -> String,
                     file: String = #file,
                     function: String = #function,
                     line: Int = #line) {
        logToDestinations(level: .info, message, file: file, function: function, line: line)
    }
    
    /// Writes a debug message to the log.
    public func debug(_ message: @autoclosure () -> String,
                      file: String = #file,
                      function: String = #function,
                      line: Int = #line) {
        logToDestinations(level: .debug, message, file: file, function: function, line: line)
    }
    
    /// Writes information about an error to the log.
    public func error(_ message: @autoclosure () -> String,
                      file: String = #file,
                      function: String = #function,
                      line: Int = #line) {
        logToDestinations(level: .error, message, file: file, function: function, line: line)
    }
    
    /// Writes a message to the log about a bug that occurs when your app executes.
    public func fault(_ message: @autoclosure () -> String,
                      file: String = #file,
                      function: String = #function,
                      line: Int = #line) {
        logToDestinations(level: .fault, message, file: file, function: function, line: line)
    }
    
    private func logToDestinations(level: LogLevel,
                                   _ message: () -> String,
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

public extension Logger {
    func warning(_ message: @autoclosure () -> String,
                 file: String = #file,
                 function: String = #function,
                 line: Int = #line) {
        logToDestinations(level: .error, message, file: file, function: function, line: line)
    }
    
    func trace(_ message: @autoclosure () -> String,
                 file: String = #file,
                 function: String = #function,
                 line: Int = #line) {
        logToDestinations(level: .debug, message, file: file, function: function, line: line)
    }
    
    func notice(_ message: @autoclosure () -> String,
                 file: String = #file,
                 function: String = #function,
                 line: Int = #line) {
        logToDestinations(level: .default, message, file: file, function: function, line: line)
    }

    func critical(_ message: @autoclosure () -> String,
                 file: String = #file,
                 function: String = #function,
                 line: Int = #line) {
        logToDestinations(level: .fault, message, file: file, function: function, line: line)
    }
}
