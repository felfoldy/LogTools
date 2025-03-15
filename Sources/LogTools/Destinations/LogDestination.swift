//
//  LogDestination.swift
//  
//
//  Created by Tibor Felföldy on 2024-06-11.
//

import OSLog

public protocol LogDestination: Sendable {
    var minLevel: LogLevel { get }
    
    func canLog(level: LogLevel) -> Bool
    
    func log(subsystem: String?, category: String?,
             level: LogLevel, _ message: String,
             file: String, function: String, line: Int)

    func log(subsystem: String?, category: String?,
             level: LogLevel, _ message: Any,
             file: String, function: String, line: Int)
}

public extension LogDestination {
    @inlinable var minLevel: LogLevel { .debug }
    
    @inlinable func canLog(level: LogLevel) -> Bool {
        minLevel <= level
    }
    
    @inlinable func log(subsystem: String?, category: String?,
             level: LogLevel, _ message: Any,
             file: String, function: String, line: Int) {
        let message = "\(message)"
        log(subsystem: subsystem, category: category, level: level, message, file: file, function: function, line: line)
    }
}

extension Logger {
    nonisolated(unsafe) private static var lock = os_unfair_lock_s()
    nonisolated(unsafe) private static var _destinations: [LogDestination] = [
        OSLogDestination()
    ]
    
    public static var destinations: [LogDestination] {
        get {
            os_unfair_lock_lock(&lock)
            let value = _destinations
            os_unfair_lock_unlock(&lock)
            return value
        }
        set {
            os_unfair_lock_lock(&lock)
            _destinations = newValue
            os_unfair_lock_unlock(&lock)
        }
    }
}
