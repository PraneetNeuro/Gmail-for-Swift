//
//  Labels.swift
//  gmail-client
//
//  Created by Praneet S on 09/04/21.
//

import Foundation

struct Color : Codable {
    let textColor: String?
    let backgroundColor: String?
}

struct Label : Codable {
      let id: String?
      let name: String?
      let messageListVisibility: MessageListVisibility?
      let labelListVisibility: LabelListVisibility?
      let type: Type_?
      let messagesTotal: Int?
      let messagesUnread: Int?
      let threadsTotal: Int?
      let threadsUnread: Int?
      let color: Color?
    
    enum MessageListVisibility : String, Codable {
        case SHOW
        case HIDE
    }
    
    enum LabelListVisibility : String, Codable {
        case LABEL_SHOW
        case LABEL_SHOW_IF_UNREAD
        case LABEL_HIDE
    }
    
    enum Type_ : String, Codable {
        case SYSTEM
        case USER
    }
}

struct LabelList : Codable {
    let labels: [Label]
}
