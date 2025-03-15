//
//  PrintLogDestination.swift
//  LogTools
//
//  Created by Tibor Felföldy on 2025-03-15.
//

import Foundation

public struct PrintLogDestination: StringLogDestination {
    public func log(subsystem: String?, category: String?, level: LogLevel, _ message: String, file: String, function: String, line: Int) {
        guard let file = URL(string: file)?.lastPathComponent else { return }
        print("<\(file):\(line)> \(message)")
    }
}
