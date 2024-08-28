//
//  LogDestination.swift
//  
//
//  Created by Tibor Felföldy on 2024-06-11.
//

import OSLog

public protocol LogDestination {
    func log(subsystem: String?, category: String?,
             level: OSLogType, _ message: String,
             file: String, function: String, line: Int)
}
