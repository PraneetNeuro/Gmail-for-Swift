//
//  Labels.swift
//  gmail-client
//
//  Created by Praneet S on 09/04/21.
//

import Foundation

struct Color : Codable {
    public let textColor: String?
    public let backgroundColor: String?
}

struct Label : Codable {
      public let id: String?
      public let name: String?
      public let messageListVisibility: MessageListVisibility?
      public let labelListVisibility: LabelListVisibility?
      public let type: Type_?
      public let messagesTotal: Int?
      public let messagesUnread: Int?
      public let threadsTotal: Int?
      public let threadsUnread: Int?
      public let color: Color?
    
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
    public let labels: [Label]?
}

