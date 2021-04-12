//
//  Settings.swift
//  gmail-client
//
//  Created by Meghana Khuntia on 10/04/21.
//

import Foundation

struct AutoForwarding : Codable {
    let enabled: Bool
    let emailAddress: String
    let disposition: Disposition
}

struct ImapSettings : Codable {
    let enabled: Bool
    let autoExpunge: Bool
    let expungeBehavior: ExpungeBehavior
    let maxFolderSize: Int
    
    enum ExpungeBehavior : String, Codable {
        case EXPUNGE_BEHAVIOR_UNSPECIFIED
        case ARCHIVE
        case TRASH
        case DELETE_FOREVER
    }
}

struct LanguageSettings: Codable {
    let displayLanguage: String
}

struct PopSettings: Codable {
    let accessWindow: AccessWindow
    let disposition: Disposition
    
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
