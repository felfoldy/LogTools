//
//  LogDestination.swift
//  
//
//  Created by Tibor Felföldy on 2024-06-11.
//

import OSLog

public protocol LogDestination {
    var minLevel: LogLevel { get }
    
    func log(subsystem: String?, category: String?,
             level: LogLevel, _ message: String,
             file: String, function: String, line: Int)
}
