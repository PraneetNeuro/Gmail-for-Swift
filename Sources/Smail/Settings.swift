//
//  Settings.swift
//  gmail-client
//
//  Created by Meghana Khuntia on 10/04/21.
//

import Foundation

struct AutoForwarding : Codable {
    public let enabled: Bool
    public let emailAddress: String
    public let disposition: Disposition
}

struct ImapSettings : Codable {
    public let enabled: Bool
    public let autoExpunge: Bool
    public let expungeBehavior: ExpungeBehavior
    public let maxFolderSize: Int
    
    enum ExpungeBehavior : String, Codable {
        case EXPUNGE_BEHAVIOR_UNSPECIFIED
        case ARCHIVE
        case TRASH
        case DELETE_FOREVER
    }
}

struct LanguageSettings: Codable {
    public let displayLanguage: String
}

struct PopSettings: Codable {
    public let accessWindow: AccessWindow
    public let disposition: Disposition
    
    enum AccessWindow: String, Codable {
        case ACCESS_WINDOW_UNSPECIFIED
        case DISABLED
        case FROM_NOW_ON
        case ALL_MAIL
    }
}

enum Disposition : String, Codable {
    case DISPOSITION_UNSPECIFIED
    case LEAVE_IN_INBOX
    case ARCHIVE
    case TRASH
    case MARK_READ
}
