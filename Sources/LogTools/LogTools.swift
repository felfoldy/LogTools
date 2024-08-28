// The Swift Programming Language
// https://docs.swift.org/swift-book

import OSLog

public typealias LogLevel = OSLogType

extension LogLevel: @retroactive Comparable {
    private var severityRank: Int {
        switch self {
        case .debug: 1
        case .info: 2
        case .default: 3
        case .error: 4
        case .fault: 5
        default: 0
        }
    }
    
    public static func < (lhs: OSLogType, rhs: OSLogType) -> Bool {
        lhs.severityRank < rhs.severityRank
    }
}
