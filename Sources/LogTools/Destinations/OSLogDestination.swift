//
//  OSLogDestination.swift
//  
//
//  Created by Tibor Felföldy on 2024-06-11.
//

import OSLog

public struct OSLogDestination: LogDestination {
    public var minLevel: LogLevel {
        #if DEBUG
        .debug
        #else
        .info
        #endif
    }
    
    public func log(subsystem: String?, category: String?,
             level: OSLogType, _ message: String,
             file: String, function: String, line: Int) {
        let logger = if let subsystem, let category {
            os.Logger(subsystem: subsystem, category: category)
        } else {
            os.Logger()
        }
        
        guard let file = URL(string: file)?.lastPathComponent else {
            logger.log(level: level, "\(message, privacy: .public)")
            return
        }
        
        logger.log(level: level, "\("<\(file):\(line)> \(message)", privacy: .public)")
    }
}
