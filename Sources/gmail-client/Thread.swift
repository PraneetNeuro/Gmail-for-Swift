//
//  Thread.swift
//  gmail-client
//
//  Created by Praneet S on 09/04/21.
//

import Foundation

struct Thread : Codable {
    let id: String?
    let snippet: String?
    let historyId: String?
    let messages: [Message]?
}
