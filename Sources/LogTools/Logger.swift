//
//  Logger.swift
//
//
//  Created by Tibor Felföldy on 2024-06-11.
//

import Foundation
import OSLog

public struct Logger {
    public static var destinations: [LogDestination] = [
        OSLogDestination()
    ]
    
    private let subsystem: String
    private let category: String
    
    public init(subsystem: String, category: String) {
        self.subsystem = subsystem
        self.category = category
    }
    
    public func log(level: OSLogType, _ message: @escaping @autoclosure () -> String,
                    file: String = #file, function: String = #function, line: Int = #line) {
        logToDestinations(level: level, message, file: file, function: function, line: line)
    }
    
    public func info(_ message: @escaping @autoclosure () -> String,
                     file: String = #file, function: String = #function, line: Int = #line) {
        logToDestinations(level: .info, message, file: file, function: function, line: line)
    }
    
    public func debug(_ message: @escaping @autoclosure () -> String,
                      file: String = #file, function: String = #function, line: Int = #line) {
        logToDestinations(level: .debug, message, file: file, function: function, line: line)
    }
    
    public func error(_ message: @escaping @autoclosure () -> String,
                      file: String = #file, function: String = #function, line: Int = #line) {
        logToDestinations(level: .error, message, file: file, function: function, line: line)
    }
    
    public func fault(_ message: @escaping @autoclosure () -> String,
                      file: String = #file, function: String = #function, line: Int = #line) {
        logToDestinations(level: .fault, message, file: file, function: function, line: line)
    }
    
    private func logToDestinations(level: OSLogType,
                                   _ message: @escaping () -> String,
                                   file: String,
                                   function: String,
                                   line: Int) {
        for destination in Logger.destinations {
            destination.log(subsystem: subsystem, category: category,
                            level: level, message,
                            file: file, function: function, line: line)
        }
    }
}
