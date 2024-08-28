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
}

public extension LogDestination {
    var minLevel: LogLevel { .debug }
    
    func canLog(level: LogLevel) -> Bool {
        minLevel < level
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
